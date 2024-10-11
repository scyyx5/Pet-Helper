import 'package:pethelper/Miscs/myPetScreenMiscs/commandsPage.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/infoPage.dart';
import 'package:pethelper/SettingSave.dart';
import 'package:flutter/material.dart';
import 'package:pethelper/Screen/register_user.dart';
import 'package:pethelper/Screen/register_user_withpet.dart';
import 'package:pethelper/main.dart';
import 'package:pethelper/model/Setting.dart';
import 'package:pethelper/model/user2.dart';
import 'package:pethelper/api/userApi2.dart';
import 'myPetScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailControllerlogin =
      new TextEditingController();
  final TextEditingController passwordControllerlogin =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    noUser(BuildContext context) {
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      AlertDialog alert = AlertDialog(
        title: Text("Wrong Password or Email"),
        content: Text("Please check and re-enter your credentials"),
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

    setSettings() async {
      Setting settings = await getSettings(id);
      darkModeString = settings.ally_darkMode;
      fontSizeString = settings.ally_textSize;
      walkString = settings.reminder_walk;
      feedString = settings.reminder_feed;
      colorblindMode = settings.ally_colourBlind;
      contrastModeString = settings.ally_contrastMode;
      print("Settings Loaded");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => myPetScreen(userid: int.parse(id))));
    }

    getSignIn(String email, String pass) async {
      Login plain = await login2(email, pass);
      if (plain.token == '0') {
        noUser(context);
      } else {
        id = plain.user.id.toString();
        token = plain.token;
        setSettings();
      }
    }

    final emailField = TextFormField(
        autofocus: false,
        controller: emailControllerlogin,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          emailControllerlogin.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: "Email",
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          //enabledBorder: UnderlineInputBorder(
          //borderSide: BorderSide(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ));
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordControllerlogin,
        obscureText: true,
        onSaved: (value) {
          passwordControllerlogin.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: "Password",
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          //enabledBorder: UnderlineInputBorder(
          //borderSide: BorderSide(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 130, 163, 172),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            if (emailControllerlogin.text != "" &&
                passwordControllerlogin.text != "") {
              String email = emailControllerlogin.text;
              String pword = passwordControllerlogin.text;
              //getSignIn(email, pword);
              getSignIn(email, pword);
            } else {
              emptyWarning(context);
            }
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 255, 244, 222),
              Color.fromARGB(255, 255, 255, 255),
            ])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              height: 200,
                              child: Image.asset(
                                "assets/appLogo2.png",
                                fit: BoxFit.contain,
                              )),
                          SizedBox(height: 45),
                          emailField,
                          SizedBox(height: 25),
                          passwordField,
                          SizedBox(height: 35),
                          loginButton,
                          SizedBox(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => infoPage(
                                                  image: "assets/Info.png")));
                                    },
                                    child: Text(
                                      "Pet Articles",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 158, 131, 122),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ))
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => commandsPage(
                                                  image:
                                                      "assets/Commands.png")));
                                    },
                                    child: Text(
                                      "Voice Commands",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 158, 131, 122),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ))
                              ]),
                          SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("I dont have an account:",
                                    textAlign: TextAlign.left),
                              ]),
                          /*
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                                onTap: () {
                                  /*
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              myPetScreen(userid: 2)));
                                              */
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen1()));
                                },
                                child: Text(
                                  "Register with a pet",
                                  style: TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ))
                          ]),
                          */

                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                    key: const Key("registerwithoutpetButton"),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterScreen()));
                                    },
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ))
                              ])
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }
}
