import 'package:brt/controller/auth_controller.dart';
import 'package:brt/pages/home_page.dart';
import 'package:brt/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class WayPage extends StatelessWidget {
  const WayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      init: AuthController(),
      builder: (find) {
        return find.user == null ? const LoginPage() : const HomePage();
      },
    );
  }
}
