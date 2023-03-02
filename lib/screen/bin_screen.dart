import 'package:digitalfarming/blocs/bin_bloc.dart';
import 'package:digitalfarming/models/bin.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/screen/bin_contributions.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/next_screen.dart';
import 'package:digitalfarming/utils/routes.dart';
import 'package:digitalfarming/utils/ui_state.dart';
import 'package:digitalfarming/views/loading_progress_indicator.dart';
import 'package:digitalfarming/widgets/dialog/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_button_bar.dart';
import 'package:getwidget/components/card/gf_card.dart';

import 'bin_registration_screen.dart';

class BinScreen extends StatefulWidget {
  static const routeName = '/bin-screen';

  const BinScreen({Key? key}) : super(key: key);

  @override
  State<BinScreen> createState() => _BinScreenState();
}

class _BinScreenState extends State<BinScreen> {
  BinBloc? binBloc;
  List<Bin> bins = [];
  String selectedBin = "";
  UIState _uiState = UIState.loading;

  @override
  initState() {
    binBloc = BinBloc();

    binBloc?.binStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            bins = snapshot.data;
            _uiState = UIState.completed;
          });
          break;
        case Status.error:
          setState(() {
            _uiState = UIState.error;
          });
          break;
      }
    });

    binBloc?.binDeleteStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.loading:
          setState(() {
            _uiState = UIState.loading;
          });
          break;
        case Status.completed:
          setState(() {
            _uiState = UIState.completed;
          });
          binBloc?.getBins();
          break;
        case Status.error:
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.APP_NAME,
          style: AppTheme.body,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: _widgetForUIState(),
      ),
      bottomNavigationBar: Container(
        height: height * 0.09,
        decoration: Constants.withShadow(),
        //padding: const EdgeInsets.all(20),
        child: GFButton(
          onPressed: () =>
              AppRouter.pushNamed(context, BinRegistrationScreen.routeName),
          color: AppTheme.brandingColor,
          child: const Text(
            Constants.ADD_NEW_BIN,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _widgetForUIState() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    switch (_uiState) {
      case UIState.loading:
        return const Center(
          child: LoadingProgressIndicator(),
        );
      case UIState.completed:
        return Column(
          children: [
            SizedBox(
              height: height * 0.01,
            ),
            const Text(
              Constants.BIN_MANAGEMENT,
              style: AppTheme.brandHeader,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              Constants.All_BINS.toUpperCase(),
              style: AppTheme.headline,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: List.generate(
                bins.length,
                (index) => InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: width * 0.45,
                    height: height * 0.25,
                    decoration: Constants.withShadow(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (bins[index].totalWeight! <= 0) {
                                  showPopupDialog(
                                    context,
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: height * 0.3,
                                          bottom: height * 0.45),
                                      child: GFCard(
                                        content: const Text(
                                          "Are You Sure, Do you want to Delete ?",
                                        ),
                                        buttonBar: GFButtonBar(
                                          children: [
                                            GFButton(
                                              onPressed: () =>
                                                  deleteBin(bins[index].id),
                                              text: 'Yes',
                                            ),
                                            GFButton(
                                              onPressed: () => {
                                                Navigator.pop(context),
                                              },
                                              text: 'No',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  showPopupDialog(
                                    context,
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: height * 0.3,
                                          bottom: height * 0.45),
                                      child: GFCard(
                                        content: const Text(
                                          "Bins with weight can't be deleted",
                                        ),
                                        buttonBar: GFButtonBar(
                                          children: [
                                            GFButton(
                                              onPressed: () =>
                                                  {Navigator.pop(context)},
                                              text: 'Close',
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              bins[index].totalWeight != null
                                  ? bins[index].totalWeight.toString()
                                  : '0',
                              style: AppTheme.brandLabel,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          bins[index].name ?? '',
                          style: AppTheme.brandHeader2,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Wrap(
                          children: [
                            Text(
                              //"${bins[index].variety?.name ?? ''} | ${bins[index].grade?.name ?? ''}",
                              bins[index].variety?.name ?? '',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    if (bins[index].contributions?.isNotEmpty ?? false) {
                      nextScreen(
                        context,
                        BinContributionScreen(
                          bin: bins[index],
                        ),
                      );
                    } else {
                      showPopupDialog(
                        context,
                        Container(
                          margin: EdgeInsets.only(
                            top: height * 0.3,
                            bottom: height * 0.45,
                          ),
                          child: GFCard(
                            content: const Text(
                              "No Contributions available for this bin",
                            ),
                            buttonBar: GFButtonBar(
                              children: [
                                GFButton(
                                  onPressed: () => {Navigator.pop(context)},
                                  text: 'Close',
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
          ],
        );
      default:
        return const Center(
          child: GFBadge(
            text: 'Internal Server Error',
            color: Colors.red,
          ),
        );
    }
  }

  deleteBin(String? id) {
    Navigator.pop(context);
    binBloc?.deleteBin(id: id ?? '');
  }
}
