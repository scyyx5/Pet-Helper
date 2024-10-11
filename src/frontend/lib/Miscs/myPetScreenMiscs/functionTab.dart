import 'package:flutter/material.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/calendarPage.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/commandsPage.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/foodCalculatorPage.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/settingPage.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/infoPage.dart';
import 'package:pethelper/model/pet.dart';
import 'package:pethelper/api/petapi.dart';
import 'package:pethelper/SettingSave.dart';
import 'dart:ui' as ui;
import 'package:pethelper/const.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class functionTab extends StatefulWidget {
  const functionTab(
      {Key? key,
      required this.title,
      required this.image,
      required this.discription,
      required this.direction,
      required this.userid})
      : super(key: key);
  final String title, image, discription, direction;
  final int userid;
  @override
  State<functionTab> createState() => functionTabState(
        title: title,
        image: image,
        discription: discription,
        direction: direction,
        userid: userid,
      );
}

class functionTabState extends State<functionTab> {
  final String title, image, discription, direction;
  final int userid;
  //final Color color;

  functionTabState({
    Key? key,
    required this.title,
    required this.image,
    required this.discription,
    required this.direction,
    required this.userid,
    //required this.color,
  });

  @override
  Widget build(BuildContext context) {
    gotoCalculator() async {
      List<Pet1> list = await getPets(userid);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  foodCalculatorPage(image: image, list: list)));
    }

    gotoCalendar() async {
      List<Pet1> list = await getPets(userid);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => calendarPage(image: image, list: list)));
    }

    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {
              /*
              List of pages:

              calendarPage
              commandsPage
              settingPage
              foodCalculatorPage
              feedbackPage
              */
              if (direction == 'calendarPage') {
                gotoCalendar();
              } else if (direction == 'commandsPage') {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => commandsPage(image: image)))
                    .then((value) {
                  setState(() {});
                });
              } else if (direction == 'settingPage') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => settingPage(
                              image: image,
                              userid: userid,
                            ))).then((value) {
                  setState(() {});
                });
              } else if (direction == 'foodCalculatorPage') {
                gotoCalculator();
              } else if (direction == 'infoPage') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => infoPage(image: image)));
              }
            },
            child: Row(children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: image,
                      child: Image(
                        image: AssetImage(image),
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width *
                                  0.07 *
                                  fontSize,
                              color: (darkMode) ? Colors.white : Colors.black),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Text(
                              discription,
                              style: TextStyle(
                                color:
                                    (contrastMode) ? Colors.black : Colors.grey,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.03 *
                                    fontSize,
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ])));
  }
}
