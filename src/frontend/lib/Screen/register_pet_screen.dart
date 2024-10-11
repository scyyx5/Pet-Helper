import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pethelper/SettingSave.dart';
import 'package:http/http.dart' as http;
import 'package:pethelper/const.dart';
import '../model/pet.dart';
import '../api/petapi.dart';
import '../api/uploadforaiapi.dart';
import '../env.sample.dart';
import 'dart:convert';
import '../model/pet.dart';
import 'dart:typed_data';
//import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/sideBar.dart';

class register_pet_screen extends StatefulWidget {
  const register_pet_screen(
      {Key? key, required this.userid, required this.list})
      : super(key: key);
  final int userid;
  final List<Pet1> list;
  @override
  State<register_pet_screen> createState() =>
      _RegistrationScreenState(userid: this.userid, list: this.list);
}

////below is used for date picker
class Task {
  DateTime date = DateTime.now();

  Task({date});
}

/*
late String name;

@override
void initState() {
  name = "imageFile";
  initState();
  futurePet = fetchPets();
}
*/

class _RegistrationScreenState extends State<register_pet_screen> {
  final int userid;
  final List<Pet1> list;
  _RegistrationScreenState({
    Key? key,
    required this.userid,
    required this.list,
  });
  Future<Pet>? _futurePet;
  bool male = true;
  String gender = "M";
  String type = "null";
  late File _image;
  late String path = "null";
  //////////late String _base64;
  final picker = ImagePicker();
  ////below is used for date picker
  Task task = new Task();
  DateTime selectedDate = DateTime.now();

  // Future<List<Pet>> getPetList() async {
  //   final response = await http.get(Uri.parse(net + "/api/Pet/"));
  //   final items = json.decode(response.body).cast<Map<String, dynamic>>();
  //   List<Pet> pets = items.map<Pet>((json) {
  //     return Pet.fromJson(json);
  //   }).toList();
  //   return pets;
  // }

  //////////Future turnbase64(File image) async{
  //////////  Uint8List imagebytes = await image.readAsBytes(); //convert to bytes
  //////////  _base64 = base64.encode(imagebytes); //convert bytes to base64 string
//////////  print(_base64);
//////////  //return _base64;
  //////////}

  // Future<String> uploadImage(File file) async {
  //   Dio dio = Dio();
  //   final response;
  //   String fileName = file.path.split('/').last;
  //   FormData formData = FormData.fromMap({
  //     "file":
  //     await MultipartFile.fromFile(file.path, filename:fileName),
  //   });
  //   response = await dio.post("http://127.0.0.1:8000/Image/", data: formData);
  //   return response.data['id'];
  // }

  bool checkExist(String name) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].pet_name == name) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  AlreadyExist(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Pet name have to be unique"),
      content: Text(
          "Please change pet name or delete the existing pet with same name"),
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

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        path = pickedFile.path;
        Upload(path);
      }
    });
  }

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        path = pickedFile.path;
        Upload(path);
      }
    });
  }

  // Upload(File imageFile) async {
  //   var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  //   var length = await imageFile.length();
  //   var uri = Uri.parse("http://10.0.2.2:8000/Image/");
  //   var request = new http.MultipartRequest("POST", uri);
  //   var multipartFile = new http.MultipartFile('file', stream, length,
  //       filename: 'test.png');
  //   //contentType: new MediaType('image', 'png'));
  //
  //   request.files.add(multipartFile);
  //   var response = await request.send();
  //   print(response.statusCode);
  //   response.stream.transform(utf8.decoder).listen((value) {
  //     print(value);
  //   });
  // }

  // Upload(File imageFile) async {
  //   // open a bytestream
  //   var stream = new http.ByteStream(
  //       DelegatingStream.typed(imageFile.openRead()));
  //   // get file length
  //   var length = await imageFile.length();
  //   // string to uri
  //   var uri = Uri.parse("http://10.0.2.2:8000/Image/");
  //   // create multipart request
  //   var request = new http.MultipartRequest("POST", uri);
  //   // multipart that takes file
  //   var multipartFile = new http.MultipartFile('file', stream, length,
  //       filename: basename(imageFile.path));
  //   // add file to multipart
  //   request.files.add(multipartFile);
  //   // send
  //   var response = await request.send();
  //   print(response.statusCode);
  //   // listen for response
  //   response.stream.transform(utf8.decoder).listen((value) {
  //     print(value);
  //   });
  // }

  final _formKey = GlobalKey<FormState>();
  //late File imageFile;
  final dateOfBirthEditingContoroller = new TextEditingController();
  final nameEditingContoroller = new TextEditingController();
  final weightEditingContoroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
            style:(darkMode)? TextStyle(color: Colors.white):TextStyle(color: Colors.black) ,
        autofocus: false,
        controller: nameEditingContoroller,
        //keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          nameEditingContoroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelStyle: (darkMode)
              ? TextStyle(
                  color: Colors.white,
                )
              : TextStyle(
                  color: Colors.grey,
                ),
          labelText: "Name",
          border: OutlineInputBorder(
            borderSide: (darkMode)
                ? const BorderSide(color: Colors.white)
                : const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(1950, 8),
          lastDate: DateTime.now());
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
          var date =
              "${picked.toLocal().year}-${picked.toLocal().month}-${picked.toLocal().day}";
          dateOfBirthEditingContoroller.text = date;
        });
    }

//________________________________________________________________________________________________
    Widget displayPics() {
      if (path == 'null') {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Please upload your pet's image",
                textAlign: TextAlign.center,
               style: TextStyle(
                    fontSize: 14 * fontSize,
                    color: (darkMode) ? Colors.white : Colors.grey)),
          ],
        );
      } else {
        return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.file(
              File(path),
            ));
      }
    }
//________________________________________________________________________________________________

    final dateOfBirthlField = GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          style:(darkMode)? TextStyle(color: Colors.white):TextStyle(color: Colors.black) ,
          autofocus: false,
          controller: dateOfBirthEditingContoroller,
          //keyboardType: TextInputType.emailAddress,
          onSaved: (val) {
            task.date = selectedDate;
          },
          decoration: InputDecoration(
             labelStyle: (darkMode)
              ? TextStyle(
                  color: Colors.white,
                )
              : TextStyle(
                  color: Colors.grey,
                ),
            labelText: "Date of Birth",
            border: OutlineInputBorder(
              borderSide: (darkMode)
                ? const BorderSide(color: Colors.white)
                : const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
/*
    final sexField = TextFormField(
        autofocus: false,
        controller: sexEditingContoroller,
        //keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          sexEditingContoroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: "SEX(M/F)",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final typeField = TextFormField(
        autofocus: false,
        controller: typeEditingContoroller,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          typeEditingContoroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: "type",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
*/
    final weightField = TextFormField(
      style:(darkMode)? TextStyle(color: Colors.white):TextStyle(color: Colors.black),
        autofocus: false,
        controller: weightEditingContoroller,
        keyboardType: TextInputType.number,
        onSaved: (value) {
          weightEditingContoroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
           labelStyle: (darkMode)
              ? TextStyle(
                  color: Colors.white,
                )
              : TextStyle(
                  color: Colors.grey,
                ),
          labelText: "Weight",
          border: OutlineInputBorder(
            borderSide: (darkMode)
                ? const BorderSide(color: Colors.white)
                : const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final AddToMypetButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 130, 163, 172),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            //////////turnbase64(_image);
            if (checkExist(nameEditingContoroller.text)) {
              AlreadyExist(context);
            } else {
              setState(() {
                _futurePet = createPet(
                    nameEditingContoroller.text,
                    dateOfBirthEditingContoroller.text,
                    gender,
                    weightEditingContoroller.text,
                    path,
                    userid.toString());
              });
              print(userid.toString());
              setState(() {});
            }
            Navigator.pop(context);
          },
          child: Text(
            "Add to Mypet",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20 * fontSize,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )),
    );

    final FloatingActionButton = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Color.fromARGB(255, 130, 163, 172),
        child: MaterialButton(
          onPressed: getImage,
          child: Icon(Icons.add_a_photo, color: Colors.white),
        ));

    final FloatingActionButtonFromAlbum = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Color.fromARGB(255, 130, 163, 172),
        child: MaterialButton(
          onPressed: _getImage,
          child: Icon(Icons.image, color: Colors.white),
        ));

    Widget ConstructRegisterPet() {
      print(userid);
      return Scaffold(
        //key: petListKey,
        backgroundColor: (darkMode) ? Color.fromARGB(255, 131, 131, 131) : Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.greenAccent),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: (darkMode) ? darkxsolid : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                      /*______________________________________________________________________________________
                    child: _image == null
                        ? Text('No image selected.')
                        : Image.file(_image),
                     */
                      children: <Widget>[
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: displayPics())),
                        SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FloatingActionButton,
                            SizedBox(width: 20),
                            FloatingActionButtonFromAlbum,
                            //SizedBox(height: 55),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("Female",
                                style: darkMode
                                    ? TextStyle(
                                        fontSize: 15 * fontSize,
                                        color: Colors.white)
                                    : TextStyle(
                                        fontSize: 15 * fontSize,
                                        color: Colors.black)),
                            Container(
                              height: MediaQuery.of(context).size.width * 0.05,
                              width: MediaQuery.of(context).size.width * 0.05,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/Female.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Switch(
                              activeColor: Colors.blueAccent,
                              activeTrackColor: Colors.blueAccent,
                              inactiveTrackColor: Colors.pinkAccent,
                              inactiveThumbColor: Colors.pinkAccent,
                              value: male,
                              onChanged: (value) {
                                setState(() {
                                  male = value;
                                  (male) ? (gender = "M") : (gender = 'F');
                                });
                              },
                            ),
                            Text("Male",
                               style: darkMode
                                    ? TextStyle(
                                        fontSize: 15 * fontSize,
                                        color: Colors.white)
                                    : TextStyle(
                                        fontSize: 15 * fontSize,
                                        color: Colors.black)),
                            Container(
                              height: MediaQuery.of(context).size.width * 0.05,
                              width: MediaQuery.of(context).size.width * 0.05,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/Male.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                        //widget function here!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        SizedBox(height: 10),
                        nameField,
                        SizedBox(height: 10),
                        dateOfBirthlField,
                        SizedBox(height: 10),
                        weightField,
                        SizedBox(height: 10),
                        AddToMypetButton,
                        //SizedBox(height:35)
                      ]),
                ),
              ),
            ),
          ),
        ),
        /*
    floatingActionButton: FloatingActionButton(
    onPressed: getImage,
    child: Icon(Icons.add_a_photo
    ))*/
      );
    }

    return ColorFiltered(
      colorFilter: ColorBlindMode(colorblindMode),
      child: ConstructRegisterPet(),
    );
  }
////////
///////
}
