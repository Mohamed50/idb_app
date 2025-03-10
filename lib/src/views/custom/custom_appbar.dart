import 'package:az_banking_app/src/config/config.dart';
import 'package:flutter/material.dart';
import 'customs.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? child;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final List<Widget>? actions;

  const CustomAppbar({super.key, this.backgroundColor = ColorManager.primaryColor, this.title = '', this.actions, this.child, this.leading, this.bottom});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.primaryColor,
      leading: leading,
      centerTitle: true,
      title: child ?? CustomText.title(title, color: Colors.white, fontSize: 24,),
      actions: actions,
      bottom: bottom,
    );
  }
}
