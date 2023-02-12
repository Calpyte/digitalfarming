import 'package:digitalfarming/models/bin.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/card/gf_card.dart';

class BinContributionScreen extends StatefulWidget {
  final Bin bin;
  const BinContributionScreen({Key? key, required this.bin}) : super(key: key);

  @override
  State<BinContributionScreen> createState() => _BinContributionScreenState();
}

class _BinContributionScreenState extends State<BinContributionScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
        child: Column(
          children: [
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              widget.bin.name ?? '',
              style: AppTheme.brandHeader,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Wrap(
              children: [
                Text(
                  "${widget.bin.variety?.name ?? ''} | ${widget.bin.grade?.name ?? ''}",
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            const Divider(),
            const Text(
              'FARMER CONTRIBUTIONS',
              style: AppTheme.brandHeader,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: GFCard(
                content: Column(
                  children: List.generate(
                    widget.bin.contributions?.length ?? 0,
                    (index) => Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.only(bottom: 10),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * 0.3,
                            child: Text(widget
                                    .bin.contributions![index].farmer?.name
                                    ?.toUpperCase() ??
                                ''),
                          ),
                          SizedBox(
                            width: width * 0.2,
                            child: Text(
                              "${(widget.bin.contributions![index].weight.toString())} KG",
                            ),
                          ),
                          SizedBox(
                            width: width * 0.2,
                            child: Text(
                              "${(widget.bin.contributions![index].contributionPercentage.toString())}%",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: height * 0.1,
        child: GFButton(
          color: AppTheme.brandingColor,
          onPressed: () => {},
          child: const Text(
            Constants.RECONCILE_BIN,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
