import 'dart:io';

import 'package:digitalfarming/models/farmer.dart';
import 'package:digitalfarming/resources/hive_repository.dart';
import 'package:digitalfarming/screen/cultivation_screen.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/next_screen.dart';
import 'package:digitalfarming/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class CultivationFarmerSelectionScreen extends StatefulWidget {
  static const routeName = '/cultivation-selection';
  const CultivationFarmerSelectionScreen({Key? key}) : super(key: key);

  @override
  State<CultivationFarmerSelectionScreen> createState() =>
      _CultivationFarmerSelectionScreenState();
}

class _CultivationFarmerSelectionScreenState
    extends State<CultivationFarmerSelectionScreen> {
  TextEditingController searchController = TextEditingController();
  List<Farmer> farmersList = [];
  @override
  void initState() {
    getFarmers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
              left: width * 0.02, right: width * 0.02, top: height * 0.01),
          color: Colors.white,
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search Farmer Name / Tracenet Id / Mobile Number',
                ),
              ),
              ...farmersList.map(
                (farmer) => GFListTile(
                  avatar: GFAvatar(
                    backgroundColor: AppTheme.brandingColor,
                    child: farmer.imagePath != null
                        ? GFImageOverlay(
                            height: 200,
                            width: 200,
                            shape: BoxShape.circle,
                            image: FileImage(
                              File(farmer.imagePath!),
                            ),
                          )
                        : Text(
                            farmer.name?.substring(0, 2) ?? 'NA',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                  titleText: farmer.name ?? 'NA',
                  subTitleText: farmer.code ?? '',
                  onTap: () {
                    nextScreen(
                        context,
                        CultivationScreen(
                          farmer: farmer,
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getFarmers() async {
    HiveRepository hiveRepository = HiveRepository();
    Map? farmerMap = await hiveRepository.getOfflineFarmers();
    int len = farmerMap?.length ?? 0;
    List<Farmer> farmers = [];
    for (var i = 0; i < len; i++) {
      farmers.add(Farmer.fromJson(farmerMap!.values.elementAt(i)));
    }

    setState(() {
      farmersList = farmers;
    });
  }
}
