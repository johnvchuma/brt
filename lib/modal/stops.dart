import 'package:cloud_firestore/cloud_firestore.dart';

class Stops {
  late String name;
  late String road;
  late double longitude;
  late double latitude;
  Stops({
    required this.name,
    required this.road,
    required this.longitude,
    required this.latitude,
  });
  Stops.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    name = documentSnapshot["name"];
    road = documentSnapshot["road"];
    longitude = documentSnapshot["longitude"];
    latitude = documentSnapshot["latitude"];
  }
}
