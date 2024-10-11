import 'package:flutter/material.dart';
import 'package:pethelper/SettingSave.dart';
import 'package:pethelper/Miscs/InfoPageMiscs/functionTab.dart';
import 'package:pethelper/const.dart';
import 'dart:ui' as ui;
import 'package:pethelper/api/infoapi.dart';

//imports for connecting the front with back
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

final String andHost = "";
final String webHost = "http://127.0.0.1:8000";

class infoPage extends StatefulWidget {
  const infoPage({Key? key, required this.image}) : super(key: key);
  final String image;
  @override
  State<infoPage> createState() => infoPageState(image: this.image);
}

class infoPageState extends State<infoPage> {
//send request to the server and recieve response from the server

  bool catinfo = false;
  String defu = 'dog';

  final String image;

  infoPageState({
    Key? key,
    required this.image,
  });

  Widget getInfos(String defu) {
    if (defu == 'dog') {
      return FutureBuilder(
          future: getDogArticle(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                  child: Center(
                child: Text("Loading...",
                    style: TextStyle(
                      color: (darkMode) ? Colors.white : Colors.black,
                      fontSize: 20 * fontSize,
                    )),
              ));
            }
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return functionTab(
                    heroid: snapshot.data[index].heroid,
                    title: snapshot.data[index].title,
                    article: snapshot.data[index].article,
                    image: snapshot.data[index].article_image.toString(),
                  );
                });
          });
    } else {
      return FutureBuilder(
          future: getCatArticle(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                  child: Center(
                child: Text("Loading...",
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.black,
                      fontSize: 20 * fontSize,
                    )),
              ));
            }
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return functionTab(
                    heroid: snapshot.data[index].heroid,
                    title: snapshot.data[index].title,
                    article: snapshot.data[index].article,
                    image: snapshot.data[index].article_image,
                  );
                });
          });
    }
  }

  Widget ConstructInfo() {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [
          0.0,
          0.3,
        ],
        colors: [
          Color.fromARGB(255, 247, 58, 140),
          Color.fromARGB(255, 255, 124, 183),
        ],
      )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
            ),
            title: Text(
              'Information',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.07 * fontSize,
                  foreground: Paint()),
            ),
            centerTitle: true,
          ),
          body: ListView(children: [
            Stack(children: [
              Container(
                  height: MediaQuery.of(context).size.height - 82.0,
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
                  right: (MediaQuery.of(context).size.width / 2),
                  child: Hero(
                      tag: image,
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(image), fit: BoxFit.cover)),
                          height: 200.0,
                          width: 200.0))),

              //the scrolling thing
              Positioned(
                  left: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.height * 0.26,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: getInfos(defu),
                      ))),

              Positioned(
                  top: MediaQuery.of(context).size.height * 0.16,
                  left: MediaQuery.of(context).size.width * 0.5,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.05,
                    //color: Colors.black,
                    child: Row(
                      children: [
                        Text("Dog",
                            style: TextStyle(
                                color: darkMode ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15 * fontSize)),
                        Switch(
                          activeColor: Colors.greenAccent,
                          activeTrackColor: Colors.greenAccent,
                          inactiveTrackColor: Colors.orangeAccent,
                          inactiveThumbColor: Colors.orangeAccent,
                          value: catinfo,
                          onChanged: (value) {
                            setState(() {
                              catinfo = value;
                              (catinfo) ? (defu = 'cat') : (defu = 'dog');
                            });
                          },
                        ),
                        Text("Cat",
                            style: TextStyle(
                              color: darkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15 * fontSize,
                            ))
                      ],
                    ),
                  )),
            ])
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorBlindMode(colorblindMode),
      child: ConstructInfo(),
    );
  }
}

// model info for cat