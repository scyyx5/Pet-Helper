import 'package:flutter/material.dart';
import 'package:pethelper/const.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/functionTabS.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/functionTab.dart';
import 'package:pethelper/SettingSave.dart';

class naviBar extends StatelessWidget {
  const naviBar({Key? key, required this.userid}) : super(key: key);
  final int userid;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: (darkMode) ? Colors.black : Colors.white,
        child: Row(
          children: [
            // functionTabS(image: 'assets/Info.png', direction: 'InfoScreen'),
            functionTabS(
                image: 'assets/feedbackIcon.png',
                direction: 'feedbackPage',
                userid: userid),
            functionTabS(
                image: 'assets/settingsIcon.png',
                direction: 'settingPage',
                userid: userid),
          ],
        ));
  }
}
