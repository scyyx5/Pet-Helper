import 'package:flutter/material.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/calendarPage.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/commandsPage.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/foodCalculatorPage.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/petPage.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/settingPage.dart';
import 'dart:ui' as ui;
import 'package:pethelper/const.dart';

class petContainer extends StatelessWidget {
  final int id;
  final String name, dob, sex, weight, type, pic;
  const petContainer({
    Key? key,
    required this.id,
    required this.name,
    required this.dob,
    required this.sex,
    required this.weight,
    required this.type,
    required this.pic,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          width: MediaQuery.of(context).size.height * 0.2,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Padding(
            padding: EdgeInsets.zero,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => petPage(
                          id: id,
                          name: name,
                          dob: dob,
                          sex: sex,
                          weight: weight,
                          type: type,
                          pic: pic,
                        )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  child: Padding(
                      padding: EdgeInsets.zero,
                      child: Stack(
                        alignment: (Alignment.center),
                        children: [
                          Hero(
                              tag: id,
                              child: Image.network(
                                pic,
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.width * 0.4,
                              )),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ));
  }
}
