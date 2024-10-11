import 'dart:convert';
import '../model/user2.dart';
import 'package:pethelper/const.dart';
import 'package:http/http.dart' as http;
import '../SettingSave.dart';
import '../model/Setting.dart';

//todo: how to get id?
void signUp(String username, String first_name, String last_name, String email,
    String password) async {
  try {
    //var request = http.MultipartRequest('POST', Uri.parse(net + '/v2/User/'));
    var request =
        http.MultipartRequest('POST', Uri.parse(net + '/api/v3/Register/'));
    request.fields['username'] = username;
    request.fields['password'] = password;
    request.fields['password2'] = password;
    request.fields['email'] = email;
    request.fields['first_name'] = first_name;
    request.fields['last_name'] = last_name;
    var streamedResponse = await request.send();
    print(streamedResponse.stream.toString());
    if (streamedResponse.statusCode == 201) {
      print("NEW USER");
      var response = await http.Response.fromStream(streamedResponse);
      final String responseString = response.body;
    } else {
      return Future.error("SERVER Error");
    }
  } catch (e) {
    return Future.error(e);
  }
}

Future<Login> login2(String email, String password) async {
  // try {
  //   // var request =
  //     http.MultipartRequest('POST', Uri.parse(net + '/v2/User/login/'));
  // print(email + "  " + password);
  // request.fields['email'] = email;
  // request.fields['password'] = password;
  // var streamedResponse = await request.send();
  // print(streamedResponse.statusCode);
  // if (streamedResponse.statusCode == 200) {
  //   print("*****USER LOGGED IN*********");
  //   var response = await http.Response.fromStream(streamedResponse);
  //   final String responseString = response.body;
  //   return Login.fromJson(responseString);
  // } else {
  //   User nouser = User(id: -1);
  //   Login noUser = Login(userID: nouser, token: "0");
  //   return noUser;
  // }

  try {
    final url = Uri.parse(net + '/api/v3/login/');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      print("good url");
      var data = jsonDecode(response.body);
      print(data['user']);
      print(data['token']);
      User userid = User(id: data['user']['id']);

      Login userLogin = Login(user: userid, token: data['token']);
      print("Login information" + userLogin.toString());
      print(response.body);
      //Login.fromJson(response.body);
      return userLogin;
    } else {
      User nouser = User(id: -1);
      Login noUser = Login(user: nouser, token: "0");

      return noUser;
    }
  } catch (e) {
    return Future.error(e);
  }
}
//todo:
// Future<List<User>> login(String username, String password) async {
//   try {
//     final response = await http.post(
//         Uri.parse(net + "/api/v3/login/"),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, String>{
//           'username': username,
//           'password': password
//         })
//     );
//       print(response.statusCode);
//      if (response.statusCode == 200) {
//       var jsonData = jsonDecode(response.body);
//       List<User> users = [];
//       print(jsonData);
//       //for (var p in jsonData) {

//       var data = await http.get(Uri.parse(net +
//           "/v2/User/13/?format=json"));//use default user now
//       if (data.statusCode == 200) {
//         var jsonData2 = jsonDecode(response.body);
//         for(var p in jsonData2) {
//           User user = User(
//               username: "testexample",
//               id: 13,
//               first_name: "Yujiao",
//               last_name: "Xiao",
//               email: "yxx132@student.bham.ac.uk",
//               password: "test123456",
//               ally_colourBlind: "None",
//               ally_darkMode: "0",
//               ally_textSize: "0",
//               reminder_feed: "0",
//               reminder_walk: "0");
//           users.add(user);
//         }

//         //}
//         return users;
//       }else{
//         print("erroed1");
//         return Future.error("SERVER ERROR1");
//       }
//      }else {
//           print("erroed2");
//           return Future.error("SERVER ERROR2");
//     }
//   } catch (e) {
//     print("erroed3");
//     print(e);
//     return Future.error(e);
//   }
// }

/*
//todo:
Future<List<User>> login2(String email, String password) async {
  try {
    var data = await http.get(Uri.parse(
        net + "/v2/User/" + email + "/" + password + "/login/?format=json"));
    //Uri.parse(net + "/Pet/276/?format=json"));
    if (data.statusCode == 200) {
      var jsonData = jsonDecode(data.body);
      List<User> users = [];
      for (var p in jsonData) {
        var data = await http.get(Uri.parse(net +
            "/v2/User/" +
            email +
            "/" +
            password +
            "/login/?format=json"));

        User user = User(
            id: p["id"],
            first_name: p["first_name"],
            last_name: p["last_name"],
            email: p["email"],
            password: p["password"],
            ally_colourBlind: p["ally_colourBlind"],
            ally_darkMode: p["ally_darkMode"],
            ally_textSize: p["ally_textSize"],
            reminder_feed: p["reminder_feed"],
            reminder_walk: p["reminder_walk"]);
        users.add(user);
      }
      return users;
    } else {
      print("erroed");
      return Future.error("SERVER ERROR");
    }
  } catch (e) {
    print("erroed1");
    print(e);
    return Future.error(e);
  }
}
*/
//___________________________________________________________________________________________________
Future<User> deletUser(String id) async {
  final http.Response response = await http.delete(
    Uri.parse(net + '/api/v3/Users/' + id + "/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    print('Successfully delet user ' + id);
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete user.');
  }
}

Future<http.Response> updateEmail(String id, String email) {
  return http.put(
    Uri.parse(net + '/api/v3/Users/' + id + "/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ' + token,
    },
    body: jsonEncode(<String, String>{
      //'user':id,
      'email': email,
    }),
  );
}

Future<http.Response> updatePassword(String id, String password) {
  return http.put(
    Uri.parse(net + '/api/v3/Users/' + id + "/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ' + token,
    },
    body: jsonEncode(<String, String>{
      //'user':id,
      'password': password,
    }),
  );
}

Future<http.Response> updatetextSize(String id, String textSize) {
  if ((textSize == "s") || (textSize == "m") || (textSize == "l")) {
    return http.put(
      Uri.parse(net + '/api/v3/Settings/' + id + "/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token ' + token,
      },
      body: jsonEncode(<String, String>{
        'user': id,
        'ally_textSize': textSize,
      }),
    );
  } else {
    throw Exception('Wrong parameter!!!');
  }
}

Future<http.Response> updatedarkMode(String id, String darkMode) {
  if ((darkMode == "0") || (darkMode == "1")) {
    return http.put(
      Uri.parse(net + '/api/v3/Settings/' + id + "/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token ' + token,
      },
      body: jsonEncode(<String, String>{
        'user': id,
        'ally_darkMode': darkMode,
      }),
    );
  } else {
    throw Exception('Wrong parameter!!!');
  }
}

Future<http.Response> updateContrastMode(String id, String contrastMode) {
  if ((contrastMode == "0") || (contrastMode == "1")) {
    return http.put(
      Uri.parse(net + '/api/v3/Settings/' + id + "/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token ' + token,
      },
      body: jsonEncode(<String, String>{
        'user': id,
        'ally_contrastMode': contrastMode,
      }),
    );
  } else {
    throw Exception('Error occured');
  }
}

Future<http.Response> updatecolourBlind(String id, String colourBlind) {
  if ((colourBlind == "None") ||
      (colourBlind == "Protanopia") ||
      (colourBlind == "Protanomaly") ||
      (colourBlind == "Deuteranopia") ||
      (colourBlind == "Deuteranomaly") ||
      (colourBlind == "Tritanopia") ||
      (colourBlind == "Tritanomaly") ||
      (colourBlind == "Achromatopsia")) {
    return http.put(
      Uri.parse(net + '/api/v3/Settings/' + id + "/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token ' + token,
      },
      body: jsonEncode(<String, String>{
        'user': id,
        'ally_colourBlind': colourBlind,
      }),
    );
  } else {
    throw Exception('Wrong parameter!!!');
  }
}

Future<http.Response> updatefeed(String id, String feed) {
  if ((feed == "1") || (feed == "0")) {
    return http.put(
      Uri.parse(net + '/api/v3/Settings/' + id + "/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token ' + token,
      },
      body: jsonEncode(<String, String>{
        'user': id,
        'reminder_feed': feed,
      }),
    );
  } else {
    throw Exception('Wrong parameter!!!');
  }
}

Future<http.Response> updatewalk(String id, String walk) {
  if ((walk == "1") || (walk == "0")) {
    return http.put(
      Uri.parse(net + '/api/v3/Settings/' + id + "/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token ' + token,
      },
      body: jsonEncode(<String, String>{
        'user': id,
        'reminder_walk': walk,
      }),
    );
  } else {
    throw Exception('Wrong parameter!!!');
  }
}

Future<Setting> getSettings(
  String id,
) async {
  try {
    var data = await http.get(
      Uri.parse(net + '/api/v3/Settings/' + id + "/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token ' + token,
      },
    );
    if (data.statusCode == 200) {
      print("code: " + data.statusCode.toString());
      var jsonData = jsonDecode(data.body);
      print(jsonData.toString());
      Setting setting = Setting(
          id: jsonData["user"].toString(),
          ally_colourBlind: jsonData["ally_colourBlind"],
          ally_darkMode: jsonData["ally_darkMode"],
          ally_textSize: jsonData["ally_textSize"],
          reminder_feed: jsonData["reminder_feed"],
          reminder_walk: jsonData["reminder_walk"],
          ally_contrastMode: jsonData["ally_contrastMode"]);
      print(setting);
      return setting;
    } else {
      Setting setting = Setting(
          id: id,
          ally_colourBlind: "None",
          ally_darkMode: "0",
          ally_textSize: "m",
          reminder_feed: "0",
          reminder_walk: "0",
          ally_contrastMode: "0");
      return setting;
    }
  } catch (e) {
    return Future.error(e);
  }
}
