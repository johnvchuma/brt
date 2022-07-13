// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore_for_file: prefer_const_constructors, avoid_print, duplicate_ignore
// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:brt/controller/main_controller.dart';
import 'package:brt/modal/road.dart';
import 'package:brt/pages/stops_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'dart:async';

BitmapDescriptor? busicon;
BitmapDescriptor? stationicon;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<BitmapDescriptor> getIcon() async {
      busicon = BitmapDescriptor.fromBytes(
          await getBytesFromAsset('assets/icons/bus.png', 70));
      stationicon = BitmapDescriptor.fromBytes(
          await getBytesFromAsset('assets/icons/station.png', 70));
      return BitmapDescriptor.fromBytes(
          await getBytesFromAsset('assets/icons/bus.png', 70));
    }

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

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => StopsPage());
        },
        child: Icon(Icons.search),
      ),
      body: FutureBuilder(
          future: getIcon(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return GetX<MainController>(
                init: MainController(),
                builder: (find) {
                  List<Road> roads = find.allRoads;
                  roads.sort((a, b) => a.latitude.compareTo(b.latitude));
                  print(roads.map((e) => e.latitude));
                  return find.allBuses.isNotEmpty
                      ? GoogleMap(
                          zoomControlsEnabled: true,
                          myLocationButtonEnabled: true,
                          markers: find.allBuses
                              .map((kituo) => Marker(
                                  flat: true,
                                  infoWindow: InfoWindow(
                                      title: kituo.name, snippet: kituo.road),
                                  markerId: MarkerId("${kituo.latitude}"),
                                  position: LatLng(
                                    kituo.latitude,
                                    kituo.longitude,
                                  ),
                                  icon: stationicon!))
                              .toSet(),
                          initialCameraPosition: CameraPosition(
                              zoom: 17.0,
                              target: LatLng(
                                find.allBuses.first.latitude.toDouble(),
                                find.allBuses.first.longitude.toDouble(),
                              )))
                      : Container();
                });
          }),
    );
  }
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);

  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);

  ui.FrameInfo fi = await codec.getNextFrame();

  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}
