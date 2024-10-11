import 'package:flutter/material.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/gdprScreen.dart';
import 'package:pethelper/SettingSave.dart';
import 'package:pethelper/const.dart';

class sideBar extends StatelessWidget {
  const sideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: (darkMode) ? darkx : whitex,
        child: Padding(
          padding: EdgeInsets.only(top: 30),
          child: ListView(
            children: [
              InkWell(
                child: Text(
                  'PetHelper GDPR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15 * fontSize,
                    color: (darkMode) ? Colors.white : Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => gdprScreen()));
                },
              )
            ],
          ),
        ));
  }
}
