import 'package:flutter/material.dart';

Widget bus(String name, String road) {
  return ListTile(
    leading: const Icon(
      Icons.location_on_outlined,
      color: Colors.black45,
    ),
    title: Text(
      name,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Text(road),
  );
}
