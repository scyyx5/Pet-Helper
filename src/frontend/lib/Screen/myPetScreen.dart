import 'dart:math';

import '../model/pet.dart';
import 'package:flutter/material.dart';
import 'package:pethelper/SettingSave.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/petContainer.dart';
import 'package:pethelper/api/petapi.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/functionTab.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/naviBar.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/sideBar.dart';
import 'package:pethelper/Screen/register_pet_screen.dart';
import 'package:pethelper/api/userApi2.dart';
import 'package:pethelper/notificationService.dart';
import 'package:pethelper/const.dart';
//
//imports for connecting the front with back
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class myPetScreen extends StatefulWidget {
  const myPetScreen({Key? key, required this.userid}) : super(key: key);
  final int userid;
  @override
  State<myPetScreen> createState() => myPetScreenState(userid: this.userid);
}

class myPetScreenState extends State<myPetScreen> {
  Timer _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {});

  @override
  void initState() {
    super.initState();
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {});
    });
  }

  final int userid;
  myPetScreenState({
    Key? key,
    required this.userid,
  });
  NotificationService _notificationService = NotificationService();

  gotoRegister() async {
    List<Pet1> list = await getPets(userid);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                register_pet_screen(userid: userid, list: list)));
  }

  Widget getPetCard() {
    return FutureBuilder(
        future: getPets(userid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
                child: Center(
              child: Text(
                "Loading...",
                style: TextStyle(fontSize: 20 * fontSize),
              ),
            ));
          }
          if (snapshot.data.length == 0) {
            return Container(
                child: Center(
              child: Text(
                "No pet registered",
                style: TextStyle(
                    color: (darkMode) ? Colors.white : Colors.black,
                    fontSize: 20 * fontSize),
              ),
            ));
          } else {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return petContainer(
                      id: snapshot.data[index].id,
                      name: snapshot.data[index].pet_name,
                      dob: snapshot.data[index].pet_birth,
                      sex: snapshot.data[index].pet_sex,
                      weight: snapshot.data[index].pet_weight,
                      type: snapshot.data[index].pet_type,
                      pic: snapshot.data[index].pet_pic);
                });
          }
        });
  }

  bool walk_state = walk;
  bool feed_state = feed;

  Future<void> walkNotificationOn() async {
    await _notificationService.schedulewalkdog();
  }

  Future<void> feedNotificationOn() async {
    await _notificationService.schedulefeedpet();
  }

  // Future<void> walkNotificationOff() async {
  //   await _notificationService.cancelNotifications(0);
  // }
  //
  // Future<void> feedNotificationOff() async {
  //   await _notificationService.cancelNotifications(1);
  // }

  Widget ConstructMyPet() {
    return Container(
      decoration: (darkMode)
          ? const BoxDecoration(
              gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
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
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
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
        drawer: const sideBar(),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(
                Icons.refresh,
                color: (darkMode)
                    ? Color.fromARGB(255, 255, 219, 183)
                    : Color.fromARGB(255, 39, 31, 24),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                color: (darkMode)
                    ? Color.fromARGB(255, 255, 204, 153)
                    : Color.fromARGB(255, 39, 31, 24),
              ),
              onPressed: () {
                gotoRegister();
              },
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.zero,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: getPetCard(),
                    ))),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7 - 15,
                decoration: (darkMode)
                    ? BoxDecoration(
                        //darkmode
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 155, 175, 174)
                                .withOpacity(0.5),
                            spreadRadius: 7,
                            blurRadius: 9,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        //change color
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            topRight: Radius.circular(50.0)),
                      )
                    : BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 175, 168, 155)
                                .withOpacity(0.5),
                            spreadRadius: 7,
                            blurRadius: 9,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        //change color
                        color: (darkMode) ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            topRight: Radius.circular(50.0)),
                      ),
                child: ListView(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20.0, right: 20.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                                height: MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).size.height * 0.47,
                                child: ListView(children: [
                                  Container(
                                    decoration: (darkMode)
                                        ? BoxDecoration(
                                            boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                          255, 158, 158, 158)
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      0), // changes position of shadow
                                                ),
                                              ],
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            gradient: const LinearGradient(
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight,
                                              stops: [
                                                0.1,
                                                0.5,
                                              ],
                                              colors: [
                                                Color.fromARGB(
                                                    130, 162, 204, 216),
                                                Color.fromARGB(
                                                    130, 211, 231, 233),
                                              ],
                                            ))
                                        : BoxDecoration(
                                            boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                          255, 142, 179, 189)
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 11,
                                                  offset: Offset(0,
                                                      0), // changes position of shadow
                                                ),
                                              ],
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            gradient: const LinearGradient(
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight,
                                              stops: [
                                                0.1,
                                                0.6,
                                              ],
                                              colors: [
                                                Color.fromARGB(
                                                    255, 162, 204, 216),
                                                Color.fromARGB(
                                                    255, 211, 231, 233),
                                              ],
                                            )),
                                    //size
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15, bottom: 5),
                                                child: Text(
                                                  'Reminder',
                                                  style: TextStyle(
                                                    color: (darkMode)
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 28 * fontSize,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                          Container(
                                              child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 30),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Walk the Dog',
                                                        style: TextStyle(
                                                            color: (darkMode)
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontSize:
                                                                20 * fontSize),
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.04,
                                                        child: Switch(
                                                            value: walk_state,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                (value)
                                                                    ? walkString =
                                                                        "1"
                                                                    : walkString =
                                                                        "0";
                                                                updatewalk(
                                                                    userid
                                                                        .toString(),
                                                                    walkString);
                                                                walk_state =
                                                                    value;
                                                                (walk_state)
                                                                    ? (walkNotificationOn())
                                                                    : (print(
                                                                        'cancel walk notification'));
                                                              });
                                                            }),
                                                      )
                                                    ],
                                                  ))),
                                          Container(
                                              child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 30),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Feed',
                                                        style: TextStyle(
                                                            color: (darkMode)
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontSize:
                                                                20 * fontSize),
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.04,
                                                        child: Switch(
                                                            value: feed_state,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                (value)
                                                                    ? feedString =
                                                                        "1"
                                                                    : feedString =
                                                                        "0";
                                                                updatefeed(
                                                                    userid
                                                                        .toString(),
                                                                    feedString);
                                                                feed_state =
                                                                    value;
                                                                (feed_state)
                                                                    ? (feedNotificationOn())
                                                                    : (print(
                                                                        'cancel feed notification'));
                                                              });
                                                            }),
                                                      )
                                                    ],
                                                  )))
                                        ],
                                      ),
                                    ),
                                  ),
                                  functionTab(
                                      title: 'Calendar',
                                      image: 'assets/calendarButton.png',
                                      discription:
                                          'Add pet\'s none daily events here!',
                                      direction: 'calendarPage',
                                      userid: userid),
                                  functionTab(
                                      title: 'Food Calculator',
                                      image: 'assets/calculatorButton.PNG',
                                      discription:
                                          'Calculate the appropriate amount of food you should fee your pet!',
                                      direction: 'foodCalculatorPage',
                                      userid: userid),
                                  functionTab(
                                      title: 'Commands',
                                      image: 'assets/commandsButton.png',
                                      discription:
                                          'Command your pet via speach!',
                                      direction: 'commandsPage',
                                      userid: userid),
                                  functionTab(
                                      title: 'Information',
                                      image: 'assets/infoIcon.png',
                                      discription:
                                          'plenty of articles to help you take care of your pet',
                                      direction: 'infoPage',
                                      userid: userid),
                                  // functionTab(
                                  //     title: 'Setting',
                                  //     image: 'assets/settingsIcon.png',
                                  //     discription:
                                  //         'Change email, password or access accessibility functions!',
                                  //     direction:  'settingPage',
                                  //     userid: userid),
                                ])))),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: naviBar(
                        userid: userid,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return ColorFiltered(
      // colorFilter: const ColorFilter.mode(
      //   Colors.grey,
      //   BlendMode.black,
      // ),
      child: ConstructMyPet(),
      colorFilter: ColorBlindMode(colorblindMode),
    );
  }
}

//pet class to get the data from the server
