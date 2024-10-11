import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pethelper/Screen/login_screen.dart';
import 'package:pethelper/notificationService.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await PlatformAssetBundle().load('certs/pethelper.bham.team+2.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  NotificationService().init();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PetHelper",
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
  //myPetScreenState createState() => myPetScreenState();
}

/*
//the code below is used to test notification function
import 'package:flutter/material.dart';
import 'package:pethelper/notificationService.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //add here
  NotificationService().init(); //add here
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.indigo.shade900,
          appBarTheme: AppBarTheme(color: Colors.indigo.shade900)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NotificationService _notificationService = NotificationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text('walk the dog'),
                    padding: const EdgeInsets.all(10),
                    onPressed: () async {
                      await _notificationService.schedulewalkdog();
                    },
                  ),
                  SizedBox(height: 3),
                  RaisedButton(
                    child: Text('Schedule Notification'),
                    padding: const EdgeInsets.all(10),
                    onPressed: () async {
                      await _notificationService.scheduleNotifications();
                    },
                  ),
                  SizedBox(height: 3),
                  RaisedButton(
                    child: Text('Feed pet'),
                    padding: const EdgeInsets.all(10),
                    onPressed: () async {
                      await _notificationService.schedulefeedpet();
                    },
                  ),
                  SizedBox(height: 3),
                  RaisedButton(
                    child: Text('Cancel All Notifications'),
                    padding: const EdgeInsets.all(10),
                    onPressed: () async {
                      await _notificationService.cancelAllNotifications();
                    },
                  ),
                  SizedBox(height: 3),
                ],
              ),
            )));
  }
}
*/
