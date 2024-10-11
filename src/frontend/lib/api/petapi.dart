import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import '../SettingSave.dart';
import '../model/pet.dart';
import 'package:pethelper/const.dart';
import 'package:http/http.dart' as http;

Future<Pet> createPet(String pet_name, String pet_birth, String pet_sex,
    String pet_weight, String pet_pic_path, String pet_owner) async {
  var request = http.MultipartRequest('POST', Uri.parse(net + '/api/v3/Pets/'));
  //var request = http.MultipartRequest('POST', Uri.parse(net +  '/v1/Pet/?format=api'));
  //var request = http.MultipartRequest('POST', Uri.parse('http://10.0.2.2:8000/Pet/'));
  print(pet_owner);
  request.headers["Authorization"] = "Token " + token;
  request.fields['pet_name'] = pet_name;
  request.fields['pet_birth'] = pet_birth;
  request.fields['pet_sex'] = pet_sex;
  request.fields['pet_weight'] = pet_weight;
  request.fields['user'] = pet_owner;
  request.files.add(await http.MultipartFile.fromPath('pet_pic', pet_pic_path));
  var response = await request.send();
  // final response = await http.post(
  //   Uri.parse('http://10.0.2.2:8000/Pet/'),
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   },
  //   body: jsonEncode(<String, String>{
  //     'pet_name': pet_name,
  //     'pet_birth': pet_birth,
  //     'pet_sex': pet_sex,
  //     'pet_weight': pet_weight,
  //     //////////'pet_pic_base64':pet_pic_base64,
  //     'pet_type': pet_type,
  //   }),
  //  );
  print(response.statusCode);
  if (response.statusCode == 201 || response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print("Congradulations!You create pet successfully!");
    return Pet.fromJson(jsonDecode(
      jsonEncode(<String, String>{
        'pet_name': pet_name,
        'pet_birth': pet_birth,
        'pet_sex': pet_sex,
        'pet_weight': pet_weight,
        'pet_owner': pet_owner,
        //////////'pet_pic_base64':pet_pic_base64,
        'pet_pic_path': pet_pic_path,
      }),
    ));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    return Future.error('Failed to create Pet.');
  }
}

Future<void> deletePet(String id) async {
  final http.Response response = await http.delete(
    Uri.parse(net + '/api/v3/Pets/' + id + "/"),
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
    print('Successfully delet pet ' + id);
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete Pet.');
  }
}

Future<http.Response> updatePetName(String id, String name) {
  return http.put(
    Uri.parse(net + '/api/v3/Pets/' + id + "/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ' + token,
    },
    body: jsonEncode(<String, String>{
      'pet_name': name,
    }),
  );
}

Future<http.Response> updatePetWeight(String id, String weight) {
  return http.put(
    Uri.parse(net + '/api/v3/Pets/' + id + "/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ' + token,
    },
    body: jsonEncode(<String, String>{
      'pet_weight': weight,
    }),
  );
}

Future<http.Response> updatePetBirth(String id, String birth) {
  return http.put(
    Uri.parse(net + '/api/v3/Pets/' + id + "/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ' + token,
    },
    body: jsonEncode(<String, String>{
      'pet_birth': birth,
    }),
  );
}

Future<http.Response> updatePetSex(String id, String sex) {
  return http.put(
    Uri.parse(net + '/api/v3/Pets/' + id + "/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ' + token,
    },
    body: jsonEncode(<String, String>{
      'pet_sex': sex,
    }),
  );
}

Future<List<Pet1>> getPets(userid) async {
  try {
    var data = await http.get(Uri.parse(net + "/api/v3/Pets/"),
        headers: {'Authorization': 'Token ' + token});
    if (data.statusCode == 200) {
      var jsonData = jsonDecode(data.body);
      List<Pet1> pets = [];
      for (var p in jsonData) {
        Pet1 pet = Pet1(
            p["id"],
            p["pet_name"],
            p["pet_birth"],
            p["pet_sex"],
            p["pet_weight"],
            p["pet_type"],
            p["pet_owner"].toString(),
            p["pet_pic"]);
        pets.add(pet);
        print(pet.pet_pic);
      }
      return pets;
    } else {
      return Future.error("SERVER ERROR");
    }
  } catch (e) {
    print(e);
    return Future.error(e);
  }
}

Future<Pet> deletePetbyowner(String userid) async {
  final http.Response response = await http.delete(
    Uri.parse("/api/v3/Pets/" + userid.toString() + "/byowner/?format=json"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ' + token,
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    print('Successfully delet pet belongs to' + userid);
    return Pet.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete Pet.');
  }
}
