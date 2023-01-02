import 'package:digitalfarming/models/bin.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class BinItemListItem extends StatelessWidget {
  BinItemListItem(
      {Key? key,
      required this.bin,
      required this.selectedBin,
      required this.onTap})
      : super(key: key);

  final Bin bin;
  String selectedBin;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GFListTile(
      color: selectedBin == bin.id! ? AppTheme.brandingColor : Colors.white,
      description: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bin.name ?? '',
            style: AppTheme.brandHeader.copyWith(
              fontSize: 20,
              color: selectedBin != bin.id!
                  ? AppTheme.brandingColor
                  : Colors.white,
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text(
            '${bin.totalWeight} kg',
            style: AppTheme.brandLabel.copyWith(
              color: selectedBin != bin.id!
                  ? AppTheme.brandingColor
                  : Colors.white,
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text(
            '${bin.variety?.name} | ${bin.grade?.name}',
            style: AppTheme.brandSmallLabel.copyWith(
              fontSize: 12,
              color: selectedBin != bin.id!
                  ? AppTheme.brandingColor
                  : Colors.white,
            ),
          ),
        ],
      ),
      onTap: () {
        selectedBin = bin.id!;
      },
    );
  }
}
