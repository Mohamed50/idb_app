import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/utils/screen_utils.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;

  const CustomScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkBackgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: ColorManager.cardGradient,
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(
            width: ScreenUtils.getScreenWidth(context),
            height: ScreenUtils.getScreenHeight(context),
            child: body,
          ),
        ],
      ),
    );
  }
}
