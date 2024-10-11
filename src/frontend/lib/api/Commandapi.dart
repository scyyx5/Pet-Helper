import 'dart:convert';
import '../model/command.dart';
import 'package:pethelper/const.dart';
import 'package:http/http.dart' as http;

/*
Future<Command> fetchCommand() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/Command/1/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Command.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Command');
  }
}
*/

Future<List<command>> getCommandList() async {
  try {
    var data = await http.get(Uri.parse(net + "/v1/Command/?format=json"));
    //var data = await http.get(Uri.parse("http://10.0.2.2:8000/Command/?format=json"));
    if (data.statusCode == 200) {
      var jsonData = jsonDecode(data.body);
      List<command> commandlist = [];
      for (var a in jsonData) {
        command singleCommand = command(a["title"], a["audio"]);
        commandlist.add(singleCommand);
      }
      return commandlist;
    } else {
      return Future.error("SERVER ERROR");
    }
  } catch (e) {
    print(e);
    return Future.error(e);
  }
}

class command {
  final String title;
  final String audio;

  command(this.title, this.audio);
}
