import 'package:flutter/material.dart';
import 'package:pethelper/SettingSave.dart';
import 'package:pethelper/const.dart';
import 'dart:ui' as ui;

class infos extends StatelessWidget {
  final String id, title, article, image;

  const infos({
    Key? key,
    required this.id,
    required this.title,
    required this.article,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            a7,
            a5,
            a3,
            a1,
          ],
        )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text(
                title,
                style: TextStyle(
                  color: darkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.07 * fontSize,
                ),
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
                    left: 0,
                    top: 0,
                    child: Hero(
                        tag: id,
                        child: Image.network(
                          net + image,
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.3,
                        ))),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.15,
                    left: MediaQuery.of(context).size.width * 0.05,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: (darkMode)
                            ? darkxsolid.withOpacity(0.9)
                            : Colors.white.withOpacity(0.9),
                      ),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          Container(
                            child: Text(
                              article,
                              style: TextStyle(
                                  color: darkMode ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15 * fontSize),
                            ),
                          ),
                        ],
                      ),
                    )),
              ])
            ])),
      ),
    );
  }
}
