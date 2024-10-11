import 'package:pethelper/Screen/myPetScreen.dart';
import 'package:pethelper/Screen/register_pet_screen.dart';
import 'package:flutter/material.dart';
import 'package:pethelper/main.dart';
import 'package:pethelper/model/user2.dart';
import '../api/userApi2.dart';

import '../Miscs/myPetScreenMiscs/gdprScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userController = new TextEditingController();
  final TextEditingController fnameController = new TextEditingController();
  final TextEditingController lnameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPassController =
      new TextEditingController();
  @override
  bool readGDPR = false;

  bool isEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(email);
  }

  bool isStrong(String password) {
    String p = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(password);
  }

  Widget build(BuildContext context) {
    passwordStrengthWarning(BuildContext context) {
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      AlertDialog alert = AlertDialog(
        title: Text("Password too weak"),
        content: Text(
            "Please make sure password should contain uppercase, lowercase, digit, special character and atleast 8 characters"),
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

    gdprWarning(BuildContext context) {
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      AlertDialog alert = AlertDialog(
        title: Text("Please Read Our GDPR"),
        content: Text(
            "In order to continue please read our gdpr before registering"),
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

    emailFormat(BuildContext context) {
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      AlertDialog alert = AlertDialog(
        title: Text("Incorrect email format"),
        content: Text("Please register with correct email format"),
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

    duplicatedEmail(BuildContext context) {
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      AlertDialog alert = AlertDialog(
        title: Text("Account already exist"),
        content:
            Text("Please register login or register with a different email"),
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

    noNull(BuildContext context) {
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

    getSignUp(String username, fname, lname, email, pass) async {
      signUp(username, fname, lname, email, pass);
      Navigator.of(context).pop();
    }

    final userNameField = TextFormField(
        key: const Key("username"),
        autofocus: false,
        controller: userController,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          fnameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: "User Name",
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          //enabledBorder: UnderlineInputBorder(
          //borderSide: BorderSide(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ));

    final FnameField = TextFormField(
        key: const Key("firstName"),
        autofocus: false,
        controller: fnameController,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          fnameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: "First Name",
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          //enabledBorder: UnderlineInputBorder(
          //borderSide: BorderSide(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ));

    final LnameField = TextFormField(
        key: const Key("lastName"),
        autofocus: false,
        controller: lnameController,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          lnameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: "Last Name",
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          //enabledBorder: UnderlineInputBorder(
          //borderSide: BorderSide(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ));

    final emailField = TextFormField(
        key: const Key("email"),
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          emailController.text = value!;
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
        key: const Key("password"),
        autofocus: false,
        controller: passwordController,
        //delete this later
        obscureText: true,
        onSaved: (value) {
          passwordController.text = value!;
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

    final confirmPassField = TextFormField(
        key: const Key("password2"),
        autofocus: false,
        controller: confirmPassController,
        //delete this later
        obscureText: true,
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: "Confirm Password",
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          //enabledBorder: UnderlineInputBorder(
          //borderSide: BorderSide(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ));

    final loginButton = Material(
      key: const Key("signup"),
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 130, 163, 172),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            if (readGDPR == true &&
                passwordController.text == confirmPassController.text &&
                fnameController.text != "" &&
                lnameController.text != "" &&
                emailController.text != "" &&
                passwordController.text != "" &&
                confirmPassController.text != "" &&
                isEmail(emailController.text) &&
                isStrong(passwordController.text)) {
              getSignUp(
                  userController.text,
                  fnameController.text,
                  lnameController.text,
                  emailController.text,
                  passwordController.text);
            } else if (readGDPR == false) {
              gdprWarning(context);
            } else if (passwordController.text != confirmPassController.text) {
              passConfirmation(context);
            } else if (isEmail(emailController.text) == false) {
              emailFormat(context);
            } else if (isStrong(passwordController.text) == false) {
              passwordStrengthWarning(context);
            } else {
              noNull(context);
            }
          },
          child: Text(
            "Sign Up",
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
                          SizedBox(height: 20),
                          userNameField,
                          SizedBox(height: 15),
                          FnameField,
                          SizedBox(height: 15),
                          LnameField,
                          SizedBox(height: 15),
                          emailField,
                          SizedBox(height: 15),
                          passwordField,
                          SizedBox(height: 15),
                          confirmPassField,
                          SizedBox(height: 15),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("By sign up you are accepting our "),
                                GestureDetector(
                                    key: const Key("gdprButton"),
                                    onTap: () {
                                      readGDPR = true;
                                      setState(() {});
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  gdprScreen()));
                                    },
                                    child: Text(
                                      "GDPR",
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ))
                              ]),
                          SizedBox(height: 10),
                          loginButton,
                          //SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }
}
