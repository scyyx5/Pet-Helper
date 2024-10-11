import 'package:flutter/material.dart';
import 'package:pethelper/Miscs/commandMiscs/commandButton.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pethelper/SettingSave.dart';
import 'package:pethelper/api/commandapi.dart';
import 'package:pethelper/const.dart';
import 'dart:ui' as ui;

//imports for connecting the front with back
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class commandsPage extends StatefulWidget {
  const commandsPage({Key? key, required this.image}) : super(key: key);
  final String image;
  @override
  State<commandsPage> createState() => commandsPageState(image: this.image);
}

class commandsPageState extends State<commandsPage> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();
  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  final String image;

  commandsPageState({
    Key? key,
    required this.image,
  });

  Widget getCommands() {
    return FutureBuilder(
        future: getCommandList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
                child: Center(
              child: Text("Loading...",
                  style:
                      TextStyle(color: darkMode ? Colors.white : Colors.black)),
            ));
          }
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return commandButton(
                  title: snapshot.data[index].title,
                  url: snapshot.data[index].audio,
                );
              });
        });
  }

  Widget ConstructCommands() {
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
          Color.fromARGB(255, 105, 99, 212),
          Color.fromARGB(255, 145, 60, 202),
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
              'Commands',
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
                  left: (MediaQuery.of(context).size.width / 2),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: getCommands(),
                        ))
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: textEditingController,
                          ),
                          ElevatedButton(
                              child: Text("play"),
                              onPressed: () =>
                                  speak(textEditingController.text),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.purple,
                              ))
                        ],
                      ),
                    )),
              ),
            ])
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorBlindMode(colorblindMode),
      child: ConstructCommands(),
    );
  }
}
