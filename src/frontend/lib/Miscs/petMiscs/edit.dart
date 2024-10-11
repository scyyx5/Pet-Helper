import 'package:pethelper/api/petapi.dart';
import 'package:pethelper/SettingSave.dart';
import 'package:flutter/material.dart';
import 'package:pethelper/const.dart';
import 'dart:ui' as ui;

//imports for connecting the front with back
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class editPage extends StatefulWidget {
  const editPage({Key? key, required this.id, required this.name, required this.dob, required this.sex, required this.weight, required this.type, required this.pic}) : super(key: key);
  final int id;
  final String name, dob, sex, weight, type, pic;
  @override
  State<editPage> createState() =>
      editPageState(id: this.id, name: this.name, dob: this.dob, sex: this.sex, weight: this.weight, type: this.type, pic: this.pic );
}

class Task {
  DateTime date = DateTime.now();

  Task({date});
}

class editPageState extends State<editPage> {
  final int id;
  final String name, dob, sex, weight, type, pic;

  editPageState({
    Key? key,
    required this.id,
    required this.name,
    required this.dob,
    required this.sex,
    required this.weight,
    required this.type,
    required this.pic,
  });

  late String gender = sex;
  late bool male = (sex=="M")? true:false;
  DateTime selectedDate = DateTime.now();
  Task task = new Task();
  final dateOfBirthEditingContoroller = new TextEditingController();
  final nameEditingContoroller = new TextEditingController();
  final weightEditingContoroller = new TextEditingController();

  _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(1950, 8),
          lastDate: DateTime.now());
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
          var date =
              "${picked.toLocal().year}-${picked.toLocal().month}-${picked.toLocal().day}";
          dateOfBirthEditingContoroller.text = date;
        });
    }

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
                "Edit",
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
                  left: 0,
                  top:MediaQuery.of(context).size.height *0.23,
                  child: Container(
                    height: MediaQuery.of(context).size.height *0.5,
                    width: MediaQuery.of(context).size.width,
                    decoration:  BoxDecoration(
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 30,right: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                        ],
                      )
                    )
                )),
                        Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.04,
                    left: MediaQuery.of(context).size.width * 0.5 -
                        MediaQuery.of(context).size.width * 0.3,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(30),
                        color: a6,
                        child: MaterialButton(
                            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {
                              updatePetSex(id.toString(), gender);
                              updatePetName(id.toString(), nameEditingContoroller.text);
                              updatePetBirth(id.toString(), dateOfBirthEditingContoroller.text);
                              updatePetWeight(id.toString(), weightEditingContoroller.text);
                              Navigator.pop(context);
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
                    Positioned(
                      top: MediaQuery.of(context).size.height*0.15,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.6,
                      decoration: BoxDecoration(
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                          children: [
                            Text("Female",
                                style: TextStyle(fontSize: 15 * fontSize)),
                            Container(
                              height: MediaQuery.of(context).size.width * 0.05,
                              width: MediaQuery.of(context).size.width * 0.05,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/Female.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Switch(
                              activeColor: Colors.blueAccent,
                              activeTrackColor: Colors.blueAccent,
                              inactiveTrackColor: Colors.pinkAccent,
                              inactiveThumbColor: Colors.pinkAccent,
                              value: male,
                              onChanged: (value) {
                                setState(() {
                                  male = value;
                                  (male) ? (gender = "M") : (gender = 'F');
                                });
                              },
                            ),
                            Text("Male",
                                style: TextStyle(fontSize: 15 * fontSize)),
                            Container(
                              height: MediaQuery.of(context).size.width * 0.05,
                              width: MediaQuery.of(context).size.width * 0.05,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/Male.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                          TextFormField(
        autofocus: false,
        controller: nameEditingContoroller,
        //keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          nameEditingContoroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: "Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )),
        GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          autofocus: false,
          controller: dateOfBirthEditingContoroller,
          //keyboardType: TextInputType.emailAddress,
          onSaved: (val) {
            task.date = selectedDate;
          },
          decoration: InputDecoration(
            labelText: "Date of Birth",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    ),
        TextFormField(
        autofocus: false,
        controller: weightEditingContoroller,
        keyboardType: TextInputType.number,
        onSaved: (value) {
          weightEditingContoroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: "Weight",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ))
                        ],
                      ),
                      )
                    ),
                      )
              ])
            ])),
      ),
    );
  }
}

//pet class to get the data from the server