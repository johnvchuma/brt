import 'package:cloud_firestore/cloud_firestore.dart';

class Road {
  late String name;
  late String road;
  late double longitude;
  late double latitude;
  Road({
    required this.name,
    required this.road,
    required this.longitude,
    required this.latitude,
  });
  Road.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    longitude = documentSnapshot["longitude"];
    latitude = documentSnapshot["latitude"];
  }
}
