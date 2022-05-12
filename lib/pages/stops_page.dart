// ignore_for_file: avoid_unnecessary_containers, unnecessary_const, prefer_const_constructors

import 'package:brt/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

class StopsPage extends StatelessWidget {
  const StopsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => HomePage());
        },
        child: Icon(Icons.arrow_forward_ios),
      ),
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(
          Icons.close,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Select stops",
          style: GoogleFonts.rubik(
              fontWeight: FontWeight.w800, fontSize: 22, color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Material(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "From",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                height: 45,
                                color: Colors.grey[200],
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        hintText: "First stop",
                                        border: InputBorder.none),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          "To    ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                height: 45,
                                color: Colors.grey[200],
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        hintText: "Destination stop",
                                        border: InputBorder.none),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: ((context, index) {
                    return const ListTile(
                      leading: Icon(
                        Icons.location_on_outlined,
                        color: Colors.black45,
                      ),
                      title: const Text(
                        "Dar es salaam institute of technology (DIT)",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text("Morogoro road"),
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}
