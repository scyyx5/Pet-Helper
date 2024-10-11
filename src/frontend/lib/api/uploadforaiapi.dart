import 'package:http/http.dart' as http;
import 'package:pethelper/const.dart';

Upload(String path) async {
  // var request = http.MultipartRequest("POST",Uri.parse("http://10.0.2.2:8000/Image/"));
  // request.fields['title'] = "test";
  // var picture =http.MultipartFile.fromPath('image',path);
  var request = http.MultipartRequest('POST', Uri.parse(net + '/v1/Image/'));
  request.files.add(await http.MultipartFile.fromPath('Image', path));
  var response = await request.send();
  var responseString = await response.stream.bytesToString();
  // var response = await http.Response.fromStream(streamedResponse);
  print(response.statusCode);
  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    print("Congratulations! Successfully upload the file");
    print(responseString);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to upload photo.');
  }
}
