import 'package:digitalfarming/models/bin.dart';
import 'package:digitalfarming/widgets/bin_item_list_item.dart';
import 'package:flutter/material.dart';

class BinItemList extends StatelessWidget {
  final List<Bin> bins;
  final String selectedBin;
  final Function() onTap;

  const BinItemList(
      {Key? key,
      required this.bins,
      required this.selectedBin,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return BinItemListItem(
            bin: bins[index], selectedBin: selectedBin, onTap: onTap);
      },
      itemCount: bins.length,
    );
  }
}
