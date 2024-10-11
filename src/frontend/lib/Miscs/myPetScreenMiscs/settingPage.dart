import 'package:flutter/material.dart';
import 'package:pethelper/Miscs/settingMiscs/changeEmail.dart';
import 'package:pethelper/Miscs/settingMiscs/changePassword.dart';
import 'package:pethelper/api/userApi2.dart';
import 'package:pethelper/const.dart';
import 'package:pethelper/SettingSave.dart';
import 'dart:ui' as ui;

class settingPage extends StatefulWidget {
  const settingPage({
    Key? key,
    required this.image,
    required this.userid,
  }) : super(key: key);
  final String image;
  final int userid;
  @override
  State<settingPage> createState() => settingPageState(
        image: image,
        userid: userid,
      );
}

class settingPageState extends State<settingPage> {
  final String image;
  final int userid;
  settingPageState({Key? key, required this.image, required this.userid});

  @override
  Widget build(BuildContext context) {
    //temp variables later will be passed by the last page
    return ColorFiltered(
      colorFilter: ColorBlindMode(colorblindMode),
      child: Container(
        decoration: (darkMode)
            ? const BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.01,
                  0.7,
                ],
                colors: [
                  Color.fromARGB(255, 22, 22, 22),
                  Color.fromARGB(255, 34, 27, 23),
                ],
              ))
            : const BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.01,
                  0.7,
                ],
                colors: [
                  Color.fromARGB(255, 255, 244, 222),
                  Color.fromARGB(255, 255, 255, 255),
                ],
              )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              title: Text(
                'Setting',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:
                        MediaQuery.of(context).size.width * 0.07 * fontSize,
                    color: (darkMode) ? Colors.white : Colors.black),
              ),
              centerTitle: true,
            ),
            body: ListView(children: [
              Stack(children: [
                Container(
                    height: MediaQuery.of(context).size.height - 90,
                    width: MediaQuery.of(context).size.width,
                    color: Color.fromARGB(0, 248, 244, 244)),
                Positioned(
                    top: 75.0,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(45.0),
                              topRight: Radius.circular(45.0),
                            ),
                            color: (darkMode) ? darkxsolid : Colors.white),
                        height: MediaQuery.of(context).size.height - 100.0,
                        width: MediaQuery.of(context).size.width)),
                Positioned(
                    left: (MediaQuery.of(context).size.width / 2),
                    child: Hero(
                        tag: image,
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(image),
                                    fit: BoxFit.cover)),
                            height: 200.0,
                            width: 200.0))),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.23,
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: ListView(
                        // COMPONENTS______________________________________________________________________
                        children: [
                          Row(
                            children: [
                              Text(
                                "CHANGE ACCOUNT INFO",
                                style: TextStyle(
                                    color: darkMode ? Colors.white : Colors.black,
                                    fontSize: 17 * fontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/Edit.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => changePasswordPage(
                                          image: image, userid: userid)));
                            },
                            child: Text(
                              "Change password here",
                              style: TextStyle(
                                  color:
                                      (darkMode) ? Colors.white : Colors.black,
                                  decoration: TextDecoration.underline,
                                  fontSize: 15 * fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => changeEmailPage(
                                          image: image, userid: userid)));
                            },
                            child: Text(
                              "Change Email here",
                              style: TextStyle(
                                  color:
                                      (darkMode) ? Colors.white : Colors.black,
                                  decoration: TextDecoration.underline,
                                  fontSize: 15 * fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              Text(
                                "ACCESSIBILITY",
                                style: TextStyle(
                                    color: (darkMode)
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 17 * fontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/Accessibility.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Change fontSize:",
                            style: TextStyle(
                                fontSize: 15 * fontSize,
                                color:
                                    (darkMode) ? Colors.white : Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Title",
                            style: TextStyle(
                              fontSize: 30 * fontSize,
                              color: (darkMode) ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            "Sub-title",
                            style: TextStyle(
                              fontSize: 20 * fontSize,
                              color: (darkMode) ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            "Content",
                            style: TextStyle(
                              fontSize: 15 * fontSize,
                              color: (darkMode) ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  fontSize = 0.8;
                                  fontSizeString = "s";
                                  setState(() {});
                                },
                                child: Text(
                                  "Small",
                                  style: TextStyle(
                                      color: (darkMode)
                                          ? Colors.white
                                          : Colors.black,
                                      decoration: TextDecoration.underline,
                                      fontSize: 15 * fontSize,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  fontSize = 1;
                                  fontSizeString = "m";
                                  setState(() {});
                                },
                                child: Text(
                                  "Median",
                                  style: TextStyle(
                                      color: (darkMode)
                                          ? Colors.white
                                          : Colors.black,
                                      decoration: TextDecoration.underline,
                                      fontSize: 15 * fontSize,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  fontSize = 1.2;
                                  fontSizeString = "l";
                                  setState(() {});
                                },
                                child: Text(
                                  "Large",
                                  style: TextStyle(
                                      color: (darkMode)
                                          ? Colors.white
                                          : Colors.black,
                                      decoration: TextDecoration.underline,
                                      fontSize: 15 * fontSize,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "COLOUR VISION DEFICIENCY",
                                style: TextStyle(
                                    color: (darkMode)
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 17 * fontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/Colour.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          DropdownButton<String>(
                            value: colorblindMode,
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.blueGrey),
                            underline: Container(
                              height: 2,
                              color: a10,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                colorblindMode = newValue!;
                              });
                            },
                            items: <String>[
                              "None",
                              "Protanopia",
                              "Protanomaly",
                              "Deuteranopia",
                              "Deuteranomaly",
                              "Tritanopia",
                              "Tritanomaly",
                              "Achromatopsia",
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Dark Mode",
                                  style: TextStyle(
                                      color: (darkMode)
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 15 * fontSize,
                                      fontWeight: FontWeight.bold)),
                              Switch(
                                value: darkMode,
                                onChanged: (value) {
                                  setState(() {
                                    (value)
                                        ? darkModeString = '1'
                                        : darkModeString = '0';
                                    darkMode = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("High Contrast",
                                  style: TextStyle(
                                      color: darkMode ? Colors.white : Colors.black,
                                      fontSize: 15 * fontSize,
                                      fontWeight: FontWeight.bold)),
                              Switch(
                                value: contrastMode,
                                onChanged: (value) {
                                  setState(() {
                                    (value)
                                        ? contrastModeString = '1'
                                        : contrastModeString = '0';
                                    contrastMode = value;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.04,
                    left: MediaQuery.of(context).size.width * 0.5 -
                        MediaQuery.of(context).size.width * 0.3,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(30),
                        color: a8,
                        child: MaterialButton(
                            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {
                              print(fontSizeString +
                                  " " +
                                  colorblindMode +
                                  " " +
                                  darkModeString);
                              updatetextSize(userid.toString(), fontSizeString);
                              updatecolourBlind(
                                  userid.toString(), colorblindMode);
                              updatedarkMode(userid.toString(), darkModeString);
                              updateContrastMode(
                                  userid.toString(), contrastModeString);
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Save to Account",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20 * fontSize,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    )),
              ])
            ])),
      ),
    );
  }
}
