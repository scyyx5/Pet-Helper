import 'package:flutter/material.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/calendarPage.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/commandsPage.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/feedbackPage.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/foodCalculatorPage.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/infoPage.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/settingPage.dart';
import 'dart:ui' as ui;
import 'package:pethelper/const.dart';

class functionTabS extends StatelessWidget {
  final String direction;
  final String image;
  final int userid;
  const functionTabS(
      {Key? key,
      required this.image,
      required this.direction,
      required this.userid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          /*
              List of pages:
              InfoScreen
              ?
              */
          if (direction == 'InfoScreen') {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => infoPage(image: image)));
          } else if (direction == 'feedbackPage') {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => feedbackPage(image: image)));
          } else if (direction == 'settingPage') {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    settingPage(image: image, userid: userid)));
          }
        },
        child: Row(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: image,
                  child: Image(
                    image: new AssetImage(image),
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.width * 0.15,
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
