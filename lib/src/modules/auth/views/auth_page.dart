import 'package:az_banking_app/src/modules/home/home.dart';
import 'package:az_banking_app/src/modules/menu/view/menu_page.dart';
import 'package:flutter/material.dart';
import '/src/modules/auth/views/splash_page.dart';
import 'widgets/auth_handler.dart';
import 'login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthHandler(onAuthenticated: const MenuPage(), onNotAuthenticated: LoginPage(), onChecking: const SplashPage(),);
  }

}
