import 'package:flutter/material.dart';
import 'package:pethelper/const.dart';
import 'package:pethelper/api/userApi2.dart';
import 'package:pethelper/SettingSave.dart';
import 'dart:ui' as ui;

class changePasswordPage extends StatefulWidget {
  const changePasswordPage({
    Key? key,
    required this.image,
    required this.userid,
  }) : super(key: key);
  final String image;
  final int userid;
  @override
  State<changePasswordPage> createState() =>
      changePasswordState(image: image, userid: userid);
}

emptyWarning(BuildContext context) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Missing value"),
    content: Text("Please enter value into every field"),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

passConfirmation(BuildContext context) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Password not match"),
    content: Text("Content password and confirm password does not match"),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class changePasswordState extends State<changePasswordPage> {
  final String image;
  final int userid;
  final TextEditingController changePassController =
      new TextEditingController();
  final TextEditingController confirmChangeController =
      new TextEditingController();
  changePasswordState({
    Key? key,
    required this.image,
    required this.userid,
  });

  @override
  Widget build(BuildContext context) {
    //temp variables later will be passed by the last page
    return ColorFiltered(
      colorFilter: ColorBlindMode(colorblindMode),
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.0,
            0.3,
            0.5,
            0.7,
          ],
          colors: [
            a10,
            a7,
            a3,
            a1,
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
                'Change Password',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:
                        MediaQuery.of(context).size.width * 0.07 * fontSize,
                    foreground: Paint()),
              ),
              centerTitle: true,
            ),
            body: ListView(children: [
              Stack(children: [
                Container(
                    height: MediaQuery.of(context).size.height - 90,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent),
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
                    left: 0,
                    top: MediaQuery.of(context).size.height * 0.23,
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                style: (darkMode)
                                ? TextStyle(color: Colors.white)
                                : TextStyle(color: Colors.black),
                                    autofocus: false,
                                    controller: changePassController,
                                    obscureText: true,
                                    onSaved: (value) {
                                      changePassController.text = value!;
                                    },
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelStyle: (darkMode)
                                          ? TextStyle(
                                        color: Colors.white,
                                      )
                                          : TextStyle(
                                        color: Colors.grey,
                                      ),
                                      labelText: "Change Password",
                                      prefixIcon: Icon(Icons.password, color: darkMode ? Colors.white : Colors.black),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 15, 20, 15),
                                      //enabledBorder: UnderlineInputBorder(
                                      //borderSide: BorderSide(color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )),
                                SizedBox(
                                  height: 70,
                                ),
                                TextFormField(
                                    style: (darkMode)
                                        ? TextStyle(color: Colors.white)
                                        : TextStyle(color: Colors.black),
                                    autofocus: false,
                                    controller: confirmChangeController,
                                    obscureText: true,
                                    onSaved: (value) {
                                      confirmChangeController.text = value!;
                                    },
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelStyle: (darkMode)
                                          ? TextStyle(
                                        color: Colors.white,
                                      )
                                          : TextStyle(
                                        color: Colors.grey,
                                      ),
                                      labelText: "Confirm Password",
                                      prefixIcon: Icon(Icons.password, color: darkMode ? Colors.white : Colors.black),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 15, 20, 15),
                                      //enabledBorder: UnderlineInputBorder(
                                      //borderSide: BorderSide(color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )),
                              ],
                            )))),
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
                              if (changePassController.text != "" &&
                                  confirmChangeController.text != "" &&
                                  changePassController.text ==
                                      confirmChangeController.text) {
                                updatePassword(userid.toString(),
                                    changePassController.text);
                                Navigator.pop(context);
                              } else if (changePassController.text !=
                                  confirmChangeController) {
                                passConfirmation(context);
                              } else {
                                emptyWarning(context);
                              }
                            },
                            child: Text(
                              "Apply",
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
