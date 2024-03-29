import 'dart:convert';

import 'package:digitalfarming/blocs/bin_bloc.dart';
import 'package:digitalfarming/blocs/procurement_bloc.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/bin.dart';
import 'package:digitalfarming/models/bin_contributions.dart';
import 'package:digitalfarming/models/procurement.dart';
import 'package:digitalfarming/resources/hive_repository.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/screen/home_screen.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/next_screen.dart';
import 'package:digitalfarming/utils/routes.dart';
import 'package:digitalfarming/utils/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';
import 'package:uuid/uuid.dart';

import '../widgets/border_button.dart';

class BinSelectionScreen extends StatefulWidget {
  final Procurement procurement;

  const BinSelectionScreen({Key? key, required this.procurement})
      : super(key: key);

  @override
  State<BinSelectionScreen> createState() => _BinSelectionScreenState();
}

class _BinSelectionScreenState extends State<BinSelectionScreen> {
  BinBloc? binBloc;
  List<Bin> bins = [];
  String selectedBin = "";
  ProcurementBloc? procurementBloc;
  UIState _uiState = UIState.loading;

  @override
  initState() {
    binBloc = BinBloc();
    procurementBloc = ProcurementBloc();

    binBloc?.binStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            bins = snapshot.data;
          });
          break;
      }
    });

    procurementBloc?.procurementStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.loading:
          setState(() {
            _uiState = UIState.loading;
          });
          break;
        case Status.completed:
          GFToast.showToast('Procurement Saved Successfully', context,
              toastPosition: GFToastPosition.BOTTOM);
          setState(() {
            _uiState = UIState.completed;
          });

          // nextScreen(context, const HomeScreen());
          break;
        case Status.error:
          GFToast.showToast('Internal Server Error', context);
          setState(() {
            _uiState = UIState.error;
          });
          break;
      }
    });

    binBloc?.getBins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.BIN_ADD,
          style: AppTheme.body,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: List.generate(
                bins.length,
                (index) => Container(
                  margin: EdgeInsets.only(top: height * 0.02),
                  width: width * 0.45,
                  height: height * 0.1,
                  child: ListTile(
                    tileColor: selectedBin == bins[index].tempBinId!
                        ? AppTheme.brandingColor
                        : Colors.white,
                    textColor: selectedBin != bins[index].tempBinId!
                        ? AppTheme.brandingColor
                        : Colors.white,
                    title: Text(
                      bins[index].name ?? '',
                    ),
                    subtitle: const Text(
                      'Weight : 0',
                    ),
                    onTap: () {
                      setState(() {
                        selectedBin = bins[index].tempBinId!;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            BorderButton(
              text: 'Submit',
              onPressed: () => validateAndSave(),
            ),
          ],
        ),
      ),
    );
  }

  validateAndSave() async {
    if (selectedBin == '') {
      GFToast.showToast('Please select bin to proceed', context);
    } else {
      var uuid = const Uuid();
      Procurement procurement = widget.procurement;
      procurement.bin = Basic(id: selectedBin);

      Map finalMap = Map.of(procurement.toJson()!);
      finalMap!['tempProcurementId'] = uuid.v4();
      finalMap!['isSynced'] = false;

      HiveRepository hiveRepository = HiveRepository();
      String procurementObj = json.encode(finalMap);
      hiveRepository.saveProcurement(
          procurementObj, finalMap['tempProcurementId']);

      List<Bin> bins = await hiveRepository.getBins();
      bins = bins.where((element) => element.tempBinId == selectedBin).toList();
      if (bins.isNotEmpty) {
        Bin bin = bins.first;
        List<BinContribution>? eContributions = bin.contributions;
        double? total = eContributions
                ?.map((item) => item.weight)
                .reduce((a, b) => a! + b!) ??
            0;

        List<BinContribution>? aContributions = [];
        int len = eContributions?.length ?? 0;
        for (var i = 0; i < len; i++) {
          aContributions?.add(
            getContribution(eContributions![i], total!),
          );
        }

        aContributions?.add(
          BinContribution(
            farmer: procurement.farmer,
            variety: Basic(
              id: procurement.variety?.id,
              name: procurement.variety?.name,
            ),
            weight: double.parse(procurement.totalWeight!),
            contributionPercentage: total > 0
                ? calculatePercentage(
                    double.parse(procurement.totalWeight!), total!)
                : 100,
          ),
        );

        bin.contributions?.clear();
        bin.contributions = aContributions;
        Map finalMap = Map.of(bin.toJson()!);
        try {
          hiveRepository.saveBin(json.encode(finalMap), bin.tempBinId!);
        } catch (e) {
          print(e);
        }
      }

      GFToast.showToast('Procurement Saved Successfully', context,
          toastPosition: GFToastPosition.BOTTOM);

      AppRouter.removeAllAndPush(context, HomeScreen.routeName);
    }
  }

  double calculatePercentage(double obtained, double total) {
    return double.parse(((obtained * 100) / total).toStringAsFixed(2));
  }

  BinContribution getContribution(BinContribution contribution, double total) {
    contribution.contributionPercentage =
        calculatePercentage(contribution.weight!, total);
    return contribution;
  }
}
