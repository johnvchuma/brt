// ignore_for_file: import_of_legacy_library_into_null_safe, sized_box_for_whitespace, prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              MaterialCommunityIcons.bus,
              color: Colors.white,
              size: 70,
            ),
            SizedBox(
              height: 20,
            ),
            Flash(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "BRT",
                    style: GoogleFonts.rubik(
                        color: Colors.white,
                        wordSpacing: 5,
                        letterSpacing: 10,
                        fontWeight: FontWeight.w800,
                        fontSize: 30),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
