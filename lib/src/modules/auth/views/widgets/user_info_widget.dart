import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/auth/auth.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: ColorManager.darkBackgroundColor,
      padding: EdgeInsets.all(12.0),
      child: GetBuilder<AuthViewModel>(
        builder:(controller)=> Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCard(child: Image.asset(AssetsManager.icUserPath, width: 40.0,)),
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CustomText.subtitle('Username', fontSize: 12.0,),
                    CustomText.title('${controller.user?.customerName}'),
                    CustomText.subtitle('${controller.user?.phoneNo}', fontSize: 12.0,),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
