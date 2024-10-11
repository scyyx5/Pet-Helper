import 'dart:convert';
import '../model/feedback.dart';
import 'package:pethelper/const.dart';
import '../SettingSave.dart';
import 'package:http/http.dart' as http;

Future<void> postFeedback(String sendfeedback) async {
    try {
      final url = Uri.parse(net + '/v1/PostFeedback/');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token ' + token,
        },
        body: jsonEncode(<String, String>{
          'feedback': sendfeedback,
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
        print("good url");
        final String responseString = response.body;

        //return userFeedbackFromJson(responseString);
      } else {
        return Future.error("SERVER Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }