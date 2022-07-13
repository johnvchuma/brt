// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe

import 'package:brt/controller/main_controller.dart';
import 'package:brt/modal/road.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'dart:async';

class FoundPage extends StatefulWidget {
  const FoundPage({Key? key}) : super(key: key);
  @override
  State<FoundPage> createState() => _IndexPageState();
}

Map data = {};
final databaseRef = FirebaseDatabase.instance.ref();

class _IndexPageState extends State<FoundPage> {
  @override
  void initState() {
    super.initState();
    databaseRef.onValue.listen((event) {
      data = jsonDecode(jsonEncode(event.snapshot.value));
      print(data["direction"]);
    });
  }

  BitmapDescriptor? busicon;
  BitmapDescriptor? stationicon;
  Future<BitmapDescriptor> getIcon() async {
    busicon = BitmapDescriptor.fromBytes(
        await getBytesFromAsset('assets/icons/bus.png', 70));
    stationicon = BitmapDescriptor.fromBytes(
        await getBytesFromAsset('assets/icons/station.png', 70));
    return BitmapDescriptor.fromBytes(
        await getBytesFromAsset('assets/icons/bus.png', 70));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: databaseRef.onValue,
          // ignore: duplicate_ignore
          builder: (context, snap) {
            // ignore: avoid_print

            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return FutureBuilder(
                future: getIcon(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return GetX<MainController>(
                      init: MainController(),
                      builder: (find) {
                        List<Road> roads = find.allRoads;
                        roads.sort((a, b) => a.latitude.compareTo(b.latitude));
                        print(roads.map((e) => e.latitude));

                        Set<Marker> pointz = {
                          Marker(
                              flat: true,
                              infoWindow: const InfoWindow(
                                  title: "My bus", snippet: ""),
                              markerId: MarkerId(
                                  "${double.parse(data["latitude"].toString())}"),
                              position: LatLng(
                                double.parse(data["latitude"].toString()),
                                double.parse(data["longitude"].toString()),
                              ),
                              icon: busicon!)
                        };
                        pointz.addAll(find.allBuses
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
                            .toSet());
                        return find.allBuses.isNotEmpty
                            ? GoogleMap(
                                zoomControlsEnabled: true,
                                myLocationButtonEnabled: true,
                                polylines: {
                                  Polyline(
                                      color: Colors.blue,
                                      startCap: Cap.roundCap,
                                      endCap: Cap.roundCap,
                                      geodesic: true,
                                      polylineId: const PolylineId("Home"),
                                      points: roads
                                          .map((road) => LatLng(
                                                road.latitude,
                                                road.longitude,
                                              ))
                                          .toList())
                                },
                                markers: pointz,
                                initialCameraPosition: CameraPosition(
                                  zoom: 17,
                                  target: LatLng(
                                    double.parse(data["latitude"].toString()),
                                    double.parse(data["longitude"].toString()),
                                  ),
                                ))
                            : Container();
                      });
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
