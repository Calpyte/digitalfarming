import 'dart:convert';

import 'package:digitalfarming/models/Menu.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/routes.dart';
import 'package:flutter/material.dart';

class CardMenu extends StatefulWidget {
  const CardMenu({Key? key}) : super(key: key);

  @override
  State<CardMenu> createState() => _CardMenuState();
}

class _CardMenuState extends State<CardMenu> {
  List<Menu> menus = [];

  @override
  void initState() {
    getMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: List.generate(
        menus.length,
        (index) => Container(
          margin: EdgeInsets.only(
              left: width * 0.02, right: width * 0.02, top: height * 0.02),
          decoration: Constants.withShadow(),
          child: ListTile(
            leading: Image.asset(
              menus[index].icon ?? '',
              height: 30,
            ),
            title: Text(
              menus[index].label ?? '',
              style: AppTheme.brandSmallLabel,
            ),
            onTap: () => AppRouter.pushNamed(context, menus[index].route ?? ''),
          ),
        ),
      ),
    );
  }

  Future<void> getMenu() async {
    Future<String> data =
        DefaultAssetBundle.of(context).loadString("assets/json/menu.json");

    data.then((value) {
      List<dynamic> response = jsonDecode(value);
      List<Menu> menuList = [];
      for (var i = 0; i < response.length; i++) {
        menuList.add(Menu.fromJson(response[i]));
      }
      setState(() {
        menus = menuList;
      });
    });
  }
}
