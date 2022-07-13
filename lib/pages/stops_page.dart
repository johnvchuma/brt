// ignore_for_file: avoid_unnecessary_containers, unnecessary_const, prefer_const_constructors

import 'package:brt/controller/main_controller.dart';

import 'package:brt/pages/found_page.dart';
import 'package:brt/widgets/bus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class StopsPage extends StatelessWidget {
  StopsPage({Key? key}) : super(key: key);
  TextEditingController firsts = TextEditingController();
  TextEditingController lasts = TextEditingController();
  int active = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => FoundPage());
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.arrow_forward),
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
          style: TextStyle(
              fontWeight: FontWeight.w800, fontSize: 22, color: Colors.black),
        ),
      ),
      body: GetX<MainController>(
          init: MainController(),
          builder: (find) {
            return Container(
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
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
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
                                          controller: firsts,
                                          onTap: () {
                                            active = 1;
                                          },
                                          onChanged: (value) {
                                            find.searchStops(value);
                                          },
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
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
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
                                          controller: lasts,
                                          onTap: () {
                                            active = 2;
                                          },
                                          onChanged: (value) {
                                            find.searchStops(value);
                                          },
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
                        itemCount: find.allBuses2.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              switch (active) {
                                case 1:
                                  firsts.text = find.allBuses2[index].name;
                                  break;
                                case 2:
                                  lasts.text = find.allBuses2[index].name;
                                  break;
                                default:
                              }
                            },
                            child: bus(find.allBuses2[index].name,
                                find.allBuses2[index].road),
                          );
                        })),
                  )
                ],
              ),
            );
          }),
    );
  }
}
