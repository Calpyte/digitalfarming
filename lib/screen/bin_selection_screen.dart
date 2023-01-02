import 'package:digitalfarming/blocs/bin_bloc.dart';
import 'package:digitalfarming/blocs/procurement_bloc.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/bin.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/ui_state.dart';
import 'package:digitalfarming/views/loading_progress_indicator.dart';
import 'package:digitalfarming/widgets/border_button.dart';
import 'package:digitalfarming/widgets/bin_item_list.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/getwidget.dart';

import '../models/procurement.dart';
import '../resources/app_logger.dart';

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
  UIState _uiState = UIState.completed;

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

          nextScreen(context, const HomeScreen());
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: height * 0.2,
                  child: ViewBin(
                    bin: bins[index],
                    selectedBin: selectedBin,
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

  validateAndSave() {
    if (selectedBin == '') {
      GFToast.showToast('Please select bin to proceed', context);
    } else {
      Procurement procurement = widget.procurement;
      procurement.bin = Basic(id: selectedBin);
      procurementBloc?.saveProcurement(procurement: procurement);
    }
  }
}
