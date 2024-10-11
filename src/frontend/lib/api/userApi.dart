import 'dart:convert';
import '../model/user.dart';
import 'package:pethelper/const.dart';
import 'package:http/http.dart' as http;

Future<User> signUp(String user_fname, String user_lname, String user_email,
    String user_password) async {
  try {
    var request =
        http.MultipartRequest('POST', Uri.parse(net + '/v1/PetOwner/'));
    request.fields['user_fname'] = user_fname;
    request.fields['user_lname'] = user_lname;
    request.fields['user_email'] = user_email;
    request.fields['user_password'] = user_password;
    var streamedResponse = await request.send();
    print(streamedResponse.statusCode);
    if (streamedResponse.statusCode == 201) {
      print("NEW USER");
      var response = await http.Response.fromStream(streamedResponse);
      final String responseString = response.body;
      return User.fromJson(responseString);
    } else {
      return Future.error("SERVER Error");
    }
  } catch (e) {
    return Future.error(e);
  }
}

Future<List<User>> login(String user_email, String user_password) async {
  try {
    var data = await http.get(Uri.parse(net +
        "/v1/Petowner/" +
        user_email +
        "/" +
        user_password +
        "/login/?format=json"));
    //Uri.parse(net + "/Pet/276/?format=json"));
    if (data.statusCode == 200) {
      var jsonData = jsonDecode(data.body);
      List<User> users = [];
      for (var p in jsonData) {
        User user = User(
            id: p["id"],
            user_fname: p["user_fname"],
            user_lname: p["user_lname"],
            user_email: p["user_email"],
            user_password: p["user_password"],
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

Future<User> deletUser(String id) async {
  final http.Response response = await http.delete(
    Uri.parse(net + '/v1/PetOwner/' + id + "1"),
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

Future<http.Response> updateEmail(String id, String user_email) {
  return http.put(
    Uri.parse(net + '/v1/PetOwner/' + id + "/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'user_email': user_email,
    }),
  );
}

Future<http.Response> updatePassword(String id, String user_password) {
  return http.put(
    Uri.parse(net + '/v1/PetOwner/' + id + "/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'user_password': user_password,
    }),
  );
}

Future<http.Response> updatetextSize(String id, String textSize) {
  if ((textSize == "s") || (textSize == "m") || (textSize == "l")) {
    return http.put(
      Uri.parse(net + '/v1/PetOwner/' + id + "/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
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
      Uri.parse(net + '/v1/PetOwner/' + id + "/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'ally_darkMode': darkMode,
      }),
    );
  } else {
    throw Exception('Wrong parameter!!!');
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
      Uri.parse(net + '/v1/PetOwner/' + id + "/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
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
      Uri.parse(net + '/v1/PetOwner/' + id + "/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
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
      Uri.parse(net + '/v1/PetOwner/' + id + "/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'reminder_walk': walk,
      }),
    );
  } else {
    throw Exception('Wrong parameter!!!');
  }
}
