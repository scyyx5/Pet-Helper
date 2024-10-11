import 'package:pethelper/Miscs/petMiscs/edit.dart';
import 'package:pethelper/api/petapi.dart';
import 'package:pethelper/SettingSave.dart';
import 'package:flutter/material.dart';
import 'package:pethelper/const.dart';
import 'dart:ui' as ui;

//imports for connecting the front with back
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class petPage extends StatelessWidget {
  final int id;
  final String name, dob, sex, weight, type, pic;

  const petPage({
    Key? key,
    required this.id,
    required this.name,
    required this.dob,
    required this.sex,
    required this.weight,
    required this.type,
    required this.pic,
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
              actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => editPage(id: id,
                      name: name,
                      dob: dob,
                      sex: sex,
                      weight: weight,
                      type: type,
                      pic: pic)));
              },
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                deletePet(id.toString());
                Navigator.pop(context);
              },
            ),
          ],
              title: Text(
                name,
                style: TextStyle(
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
                    left: MediaQuery.of(context).size.width * 0.1 / 2,
                    top: MediaQuery.of(context).size.height * 0.01,
                    child: Hero(
                        tag: id,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              topRight: Radius.circular(50.0)),
                          child: Container(
                              child: Image.network(
                                pic,
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width * 0.3,
                              ),
                              height: MediaQuery.of(context).size.width -
                                  MediaQuery.of(context).size.width * 0.1,
                              width: MediaQuery.of(context).size.width -
                                  MediaQuery.of(context).size.width * 0.1),
                        ))),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.1 / 2,
                  top: MediaQuery.of(context).size.height * 0.5,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Name:  " + name,
                            style: TextStyle(
                                fontSize: 30 * fontSize,
                                fontWeight: FontWeight.bold)),
                        Text("DOB:  " + dob,
                            style: TextStyle(
                                fontSize: 30 * fontSize,
                                fontWeight: FontWeight.bold)),
                        Text("Sex:  " + sex,
                            style: TextStyle(
                                fontSize: 30 * fontSize,
                                fontWeight: FontWeight.bold)),
                        Text("Type:  " + type,
                            style: TextStyle(
                                fontSize: 30 * fontSize,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ])
            ])),
      ),
    );
  }
}

//pet class to get the data from the server
class Pet {
  final int id;
  final String pet_name;
  final String pet_sex;
  final String pet_type;
  final String pet_birth;
  final String pet_weight;
  final String pet_owner;
  final String pet_pic;

  Pet(this.id, this.pet_name, this.pet_sex, this.pet_type, this.pet_birth,
      this.pet_weight, this.pet_owner, this.pet_pic);
}
