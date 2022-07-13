// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, import_of_legacy_library_into_null_safe

import 'package:brt/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Icon(
              MaterialCommunityIcons.bus,
              color: Colors.blue,
              size: 70,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Sign in to BRT",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w800,
                  fontSize: 25),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Login using your google account",
              style: TextStyle(color: Colors.black45, fontSize: 13),
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                AuthController().googleLogin();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.blue)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 23,
                          width: 23,
                          child: Image.asset("assets/icons/google.png")),
                      SizedBox(
                        width: 40,
                      ),
                      Text("Sign in with google",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17)),
                    ],
                  ),
                ),
                width: double.infinity,
              ),
            ),
            Spacer(),
            Text(
                "By signing in here you agree to our company's \nterms and conditions.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w600,
                    fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
