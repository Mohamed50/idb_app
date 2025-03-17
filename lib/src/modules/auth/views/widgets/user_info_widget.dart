import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/auth/auth.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.primaryColor,
      padding: EdgeInsets.all(24.0),
      child: SafeArea(
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
                      CustomText.title('${controller.user?.customerName}', color: Colors.white,),
                      CustomText.subtitle('${controller.user?.phoneNo}', color: Colors.white, fontSize: 12.0,),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
