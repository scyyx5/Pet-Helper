import 'package:flutter/material.dart';
import 'package:pethelper/model/pet.dart';
import 'package:pethelper/const.dart';
import 'package:pethelper/Screen/myPetScreen.dart';
import 'package:pethelper/SettingSave.dart';
import 'dart:ui' as ui;

class foodCalculatorPage extends StatefulWidget {
  const foodCalculatorPage({Key? key, required this.image, required this.list})
      : super(key: key);
  final String image;
  final List<Pet1> list;
  @override
  State<foodCalculatorPage> createState() =>
      foodCalculatorState(image: image, list: list);
}

class foodCalculatorState extends State<foodCalculatorPage> {
  final String image;
  final List<Pet1> list;
  foodCalculatorState({
    Key? key,
    required this.image,
    required this.list,
  });

  String listChoice = "None pet selected";
  String choiceType = "Unknown";
  String activityChoice = "None activity level selected";
  double sliderValue = 3000;

//_______________functions
  int dogFoodEquation(double weight, double foodcalories, String activity) {
    if (activity == "Low activity") {
      return ((weight * 95) * 1000) ~/ foodcalories;
    } else if (activity == "Moderate activity (1-3 hour low impact)") {
      return ((weight * 110) * 1000) ~/ foodcalories;
    } else if (activity == "Moderate activity (1-3 hour high impact)") {
      return ((weight * 125) * 1000) ~/ foodcalories;
    } else if (activity == "High activity (3-6 hour)") {
      return ((weight * 162.5) * 1000) ~/ foodcalories;
    } else {
      //High activity under extreme conditions
      return ((weight * 1050) * 1000) ~/ foodcalories;
    }
  }

  int catFoodEquation(double weight, double foodcalories, String activity) {
    if (activity == "Neutered or indoor cats") {
      return ((weight * 63.5) * 1000) ~/ foodcalories;
    } else {
      //Active cats
      return ((weight * 100) * 1000) ~/ foodcalories;
    }
  }

  Widget Calculator(String type, String name, double weight, String activity) {
    if (listChoice == "None pet selected") {
      return Container();
    } else {
      if (activity == "None activity level selected") {
        return Container();
      } else {
        if (type == "Dog") {
          return Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                  "Calories of Food (Per KG): ",
                  style: TextStyle(fontSize: 30,
                    color: darkMode ? Colors.white : Colors.black,
                  )),
                Container(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      sliderValue.toStringAsFixed(2),
                  style: TextStyle(fontSize: 30,
                    color: darkMode ? Colors.white : Colors.black,
                  )),
                    Container(
      height: 40.0,
      width: 40.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/fire.png'),
          fit: BoxFit.fill,
        ),
      ),
    )
                  ],
                ),),
                Text(
                      " Kcal",
                  style: TextStyle(fontSize: 30,
                    color: darkMode ? Colors.white : Colors.black,
                  )),
              Slider(
                value: sliderValue,
                min: 1000,
                max: 5000,
                label: sliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    sliderValue = value;
                  });
                },
              ),
              Text(name +
                  " needs to eat " +
                  dogFoodEquation(weight, sliderValue, activity).toString() +
                  " grams of food per day",style: TextStyle(
                color: darkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                //foreground: Paint(),
              ),),
            ],
          ));
        } else if (type == "Cat") {
          return Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                  "Calories of Food (Per KG): ",
                  style: TextStyle(color: darkMode ? Colors.white : Colors.black,
                      fontSize: 30)),
                Container(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      sliderValue.toStringAsFixed(2),
                  style: TextStyle(color: darkMode ? Colors.white : Colors.black,
                      fontSize: 30)),
                    Container(
      height: 40.0,
      width: 40.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/fire.png'),
          fit: BoxFit.fill,
        ),
      ),
    )
                  ],
                ),),
                Text(
                      " Kcal",
                  style: TextStyle(color: darkMode ? Colors.white : Colors.black,
                      fontSize: 30)),
              Slider(
                value: sliderValue,
                min: 1000,
                max: 5000,
                label: sliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    sliderValue = value;
                  });
                },
              ),
              Text(name +
                  " needs to eat " +
                  dogFoodEquation(weight, sliderValue, activity).toString() +
                  " grams of food per day",style: TextStyle(
                color: darkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                //foreground: Paint(),
              ),),
            ],
          ));
        } else {
          return Container();
        }
      }
    }
  }

  Widget constructChoice(String type) {
    if (listChoice == "None pet selected") {
      return Container(
        child: Column(
          children: [
            SizedBox(height: 40),
            Text("Please select a pet to continue",style: TextStyle(
              color: darkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                //foreground: Paint(),
              ),),
            ],
        ),
      );
    } else {
      if (type == "Dog") {
        return Container(
          child: Column(
            children: [
              SizedBox(height: 30),
              Text("Choose activity level (Per Day):",style: TextStyle(
                color: darkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                // foreground: Paint(),
              ),),
              DropdownButton<String>(
          value: activityChoice,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.blueGrey),
          underline: Container(
            height: 2,
            color: b9,
          ),
          onChanged: (String? newValue) {
            setState(() {
              activityChoice = newValue!;
            });
          },
          items: <String>[
            "None activity level selected",
            "Low activity",
            "Moderate activity (1-3 hour low impact)",
            "Moderate activity (1-3 hour high impact)",
            "High activity (3-6 hour)",
            "High activity (3-6 hour extreme condition)"
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          ),
            ],
          ),
        );
      } else if (type == "Cat") {
        return Container(
          child: Column(
            children: [
              SizedBox(height: 30),
              Text("Choose activity level (Per Day):",style: TextStyle(
                color: darkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                //foreground: Paint(),
              ),),
              DropdownButton<String>(
          value: activityChoice,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.blueGrey),
          underline: Container(
            height: 2,
            color: b9,
          ),
          onChanged: (String? newValue) {
            setState(() {
              activityChoice = newValue!;
            });
          },
          items: <String>[
            "None activity level selected",
            "Neutered or indoor cats",
            "Active cats"
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )
            ],
          ),
        );
      } else {
        return Text("Pet's type cannot be identified");
      }
    }
  }

  double getWeight(String name) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].pet_name == name) {
        return double.parse(list[i].pet_weight);
      }
    }
    return 0;
  }

  Widget ConstructFoodCalculator() {
    setState(() {});
    List<String> pet_name = ["None pet selected"];
    List<String> pet_weight = ["0"];
    List<String> pet_type = ["Unknown"];
    for (int i = 0; i < list.length; i++) {
      pet_name.add(list[i].pet_name);
      pet_weight.add(list[i].pet_weight);
      pet_type.add(list[i].pet_type);
    }

    return Container(
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
          b9,
          b5,
          b3,
          b1,
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
              'Food Calculator',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.07,
                foreground: Paint(),
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
                left: 30,
                top: 130,
                child: DropdownButton<String>(
                  value: listChoice,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style:  const TextStyle(color: Colors.blueGrey),
                  underline: Container(
                    height: 2,
                    color: b9,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      listChoice = newValue!;
                      for (int i = 0; i < list.length; i++) {
                        if (list[i].pet_name == newValue) {
                          choiceType = list[i].pet_type;
                        }
                      }
                      activityChoice = "None activity level selected";
                    });
                  },
                  items: pet_name.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Positioned(
                  left: 30,
                  top: 200,
                  child: Container(
                    child: constructChoice(choiceType),
                  )),
              Positioned(
                  top: 300,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Calculator(choiceType, listChoice,
                        getWeight(listChoice), activityChoice),
                  )),
            ])
          ])),
    );
  }

//_______________________

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorBlindMode(colorblindMode),
      child: ConstructFoodCalculator(),
    );
  }
}
