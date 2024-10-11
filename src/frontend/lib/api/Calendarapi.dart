import 'dart:convert';
import 'package:pethelper/Miscs/myPetScreenMiscs/calendarPage.dart';
import 'package:pethelper/const.dart';
import 'package:http/http.dart' as http;
import 'package:pethelper/model/Calendar.dart';
import '../SettingSave.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import '../SettingSave.dart';
import '../model/Calendar.dart';
import '../model/pet.dart';
import 'package:pethelper/const.dart';
import 'package:http/http.dart' as http;

Future<List<Calendar1>> getEvents() async {
  try {
    var data = await http.get(Uri.parse(net + "/api/v3/Calendars/"),
        headers: {'Authorization': 'Token ' + token});
    if (data.statusCode == 200) {
      var jsonData = jsonDecode(data.body);
      List<Calendar1> cals = [];
      for (var p in jsonData) {
        print(p);
        Calendar1 cal = Calendar1(
            pet: p['pet'].toString(),
            date: p['date'],
            title: p['title'],
            isChecked: p['isChecked'],
            user: p['user'].toString(),
            id: p['id'].toString());
        cals.add(cal);
      }
      return cals;
    } else {
      return Future.error("SERVER ERROR");
    }
  } catch (e) {
    print(e);
    return Future.error(e);
  }
}

Future<Calendar> createEvent(
    String pet, String date, String title, String user) async {
  var request =
      http.MultipartRequest('POST', Uri.parse(net + '/api/v3/Calendars/'));
  request.headers["Authorization"] = "Token " + token;
  request.fields['pet'] = pet;
  print(pet);
  request.fields['date'] = date;
  print(date);
  request.fields['title'] = title;
  print(title);
  request.fields['isChecked'] = "Not Done";
  request.fields['user'] = user;
  print(user);

  var response = await request.send();
  print(response.statusCode);
  if (response.statusCode == 201 || response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print("Congradulations!You create event successfully!");
    return Calendar.fromJson(jsonDecode(
      jsonEncode(<String, String>{
        'pet': pet,
        'date': date,
        'title': title,
        'isChecked': "Not Done",
        'user': user
      }),
    ));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    return Future.error('Failed to create event.');
  }
}

Future<http.Response> donetoundone(String id) {
  return http.put(
    Uri.parse(net + '/api/v3/Calendars/' + id + "/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ' + token,
    },
    body: jsonEncode(<String, String>{
      'isChecked': 'Not Done',
    }),
  );
}

Future<http.Response> undonetodone(String id) {
  return http.put(
    Uri.parse(net + '/api/v3/Calendars/' + id + "/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ' + token,
    },
    body: jsonEncode(<String, String>{
      'isChecked': 'Done',
    }),
  );
}

Future<void> deleteEvent(String id) async {
  final http.Response response = await http.delete(
    Uri.parse(net + '/api/v3/Calendars/' + id + "/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ' + token,
    },
  );

  if (response.statusCode == 204) {
    // If the server did return a 200 OK response,
    // then parse the JSON. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    print('Successfully delet event ' + id);
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete event.');
  }
}
