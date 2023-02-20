import 'package:digitalfarming/resources/hive_repository.dart';
import 'package:digitalfarming/utils/app_colors.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settingsScreen';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.APP_NAME,
          style: AppTheme.body,
        ),
        elevation: 0,
      ),
      body: GFCard(
        content: Column(
          children: [
            GFListTile(
              titleText: 'Delete Data',
              avatar: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onTap: () {
                HiveRepository hiveRepository = HiveRepository();
                hiveRepository.delete();
              },
            ),
            const Divider(),
            GFListTile(
              titleText: 'Logout',
              avatar: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              onTap: () {},
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
