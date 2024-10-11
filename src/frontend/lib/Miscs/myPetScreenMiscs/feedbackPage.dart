import 'package:pethelper/SettingSave.dart';
import 'package:flutter/material.dart';
import 'package:pethelper/const.dart';
import 'package:pethelper/api/feedapi.dart';
import 'dart:ui' as ui;

//import for connection with the backend

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class feedbackPage extends StatefulWidget {
  const feedbackPage({Key? key, required this.image}) : super(key: key);
  final String image;
  @override
  State<feedbackPage> createState() => feedbackPageState(image: this.image);
}

class feedbackPageState extends State<feedbackPage> {
  TextEditingController userFeedback = TextEditingController();
//connection function

//end of function
  final String image;
  feedbackPageState({
    Key? key,
    required this.image,
  });

  Widget ConstructFeedback() {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
            0.1,
            0.5,
          ],
              colors: [
            Color.fromARGB(255, 162, 204, 216),
            Color.fromARGB(255, 211, 231, 233),
          ])),
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
              'Feed back',
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
              Positioned(
                top: MediaQuery.of(context).size.height * 0.25,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.621,
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: EdgeInsets.all(12),
                          child: TextField(
                              style: TextStyle(
                                  color:
                                      (darkMode) ? Colors.white : Colors.black),
                              controller: userFeedback,
                              maxLines: 18,
                              decoration: InputDecoration(
                                  hintText:
                                      "Tell us how we can improve the app!",
                                  hintStyle: TextStyle(
                                      color: (darkMode)
                                          ? Color.fromARGB(169, 255, 255, 255)
                                          : Color.fromARGB(127, 0, 0, 0)),
                                  fillColor: (darkMode)
                                      ? Color.fromARGB(255, 24, 24, 24)
                                      : Color.fromARGB(255, 218, 218, 218),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(30)))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.04,
                  left: MediaQuery.of(context).size.width * 0.5 -
                      MediaQuery.of(context).size.width * 0.2,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(255, 162, 204, 216),
                      child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            final submitFeedback = userFeedback.text;
                            final userFeed = postFeedback(submitFeedback);
                            print("submit the feedback");
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Submit",
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorBlindMode(colorblindMode),
      child: ConstructFeedback(),
    );
  }
}

//-----------------------------------------
///model feed back

String userFeedbackToJson(Feedback data) => json.encode(data.toJson());
Feedback userFeedbackFromJson(String str) =>
    Feedback.fromJson(json.decode(str));

class Feedback {
  final int id;
  final String feedback;
  Feedback(
    this.id,
    this.feedback,
  );

  Feedback copyWith({
    int? id,
    String? feedback,
  }) {
    return Feedback(
      id ?? this.id,
      feedback ?? this.feedback,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'feedback': feedback,
    };
  }

  factory Feedback.fromMap(Map<String, dynamic> map) {
    return Feedback(
      map['id']?.toInt() ?? 0,
      map['feedback'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Feedback.fromJson(String source) =>
      Feedback.fromMap(json.decode(source));

  @override
  String toString() => 'Feedback(id: $id, feedback: $feedback)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Feedback && other.id == id && other.feedback == feedback;
  }

  @override
  int get hashCode => id.hashCode ^ feedback.hashCode;
}
