import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/auth/views/widgets/user_info_widget.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'settings_service_grid.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserInfoWidget(),
          SizedBox(height: 24.0),
          SettingsServiceList(),
          Spacer(),
          FutureBuilder(
            future: PackageInfo.fromPlatform(),
            builder: (context, asyncData) {
              if (asyncData.hasData) {
                return CustomText('version: ${asyncData.data!.version}+${asyncData.data!.buildNumber}');
              } else {
                return Container();
              }
            },
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
