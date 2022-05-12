// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:brt/pages/stops_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
    ).then((value) => Get.bottomSheet(ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 3,
                      width: 70,
                      color: Colors.black45,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Where from and to ? ",
                    style: GoogleFonts.rubik(
                        color: Colors.black87,
                        fontWeight: FontWeight.w800,
                        fontSize: 23),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => StopsPage());
                      print("working");
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 50,
                          color: Colors.grey[200],
                          width: double.infinity,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              ClipOval(
                                  child: Container(
                                      color: Colors.blueAccent,
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.search,
                                            color: Colors.white),
                                      ))),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                "Tap to enter your stops",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      "Your required to provide the name of the place where you want to catch a bus and where your going.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        )));

    return const Scaffold(
      body: GoogleMap(
          zoomControlsEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: CameraPosition(
              zoom: 11.5,
              target: LatLng(
                -6.89470617116838,
                39.227367611693694,
              ))),
    );
  }
}
