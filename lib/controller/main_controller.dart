import 'package:brt/modal/road.dart';
import 'package:brt/modal/stops.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';

class MainController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Rx<List<Stops>> stopsController = Rx<List<Stops>>([]);
  List<Stops> get allBuses => stopsController.value;
  Rx<List<Road>> roadsController = Rx<List<Road>>([]);
  List<Road> get allRoads => roadsController.value;
  Rx<List<Stops>> stopsController2 = Rx<List<Stops>>([]);
  List<Stops> get allBuses2 => stopsController2.value;

  String onesignal = "834bfd81-dd17-4aca-9867-4083daab412c";
  @override
  void onInit() {
    stopsController.bindStream(getStops());
    roadsController.bindStream(getRoads());
    super.onInit();
  }

  void searchStops(String value) {
    stopsController2.value = [];
    if (value.isNotEmpty) {
      for (var stops in allBuses) {
        if (stops.name.toLowerCase().contains(value.toLowerCase())) {
          stopsController2.value.add(stops);
        }
      }
    } else {
      stopsController2.value = [];
    }
  }

  Stream<List<Stops>> getStops() {
    return firebaseFirestore
        .collection("vituo")
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Stops> stops = [];
      for (var element in querySnapshot.docs) {
        stops.add(Stops.fromDocumentSnapshot(element));
      }
      return stops;
    });
  }

  Stream<List<Road>> getRoads() {
    return firebaseFirestore
        .collection("roads")
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Road> roads = [];
      for (var element in querySnapshot.docs) {
        roads.add(Road.fromDocumentSnapshot(element));
      }
      return roads;
    });
  }
}
