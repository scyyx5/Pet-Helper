import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}
/*
late String name;

@override
void initState() {
  name = "imageFile";
  initState();
}
*/
class _RegistrationScreenState extends State<RegistrationScreen> {

  ///////////////
  late File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }
  ////////////////

  final _formKey = GlobalKey<FormState>();
  //late File imageFile;
  final breedEditingContoroller = new TextEditingController();
  final dateOfBirthEditingContoroller = new TextEditingController();
  final sexEditingContoroller = new TextEditingController();
  final nameEditingContoroller = new TextEditingController();
  final weightEditingContoroller = new TextEditingController();
  @override

  Widget build(BuildContext context) {

    final breedField = TextFormField(
        autofocus: false,
        controller: breedEditingContoroller,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value)
        {
          breedEditingContoroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText:"Breed",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final dateOfBirthlField = TextFormField(
        autofocus: false,
        controller: dateOfBirthEditingContoroller,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value)
        {
          dateOfBirthEditingContoroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText:"Date of Birth",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final sexField = TextFormField(
        autofocus: false,
        controller: sexEditingContoroller,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value)
        {
          sexEditingContoroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText:"SEX",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final nameField = TextFormField(
        autofocus: false,
        controller: nameEditingContoroller,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value)
        {
          nameEditingContoroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText:"Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final weightField = TextFormField(
        autofocus: false,
        controller: weightEditingContoroller,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value)
        {
          weightEditingContoroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText:"Weight",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final AddToMypetButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.deepOrangeAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {},
          child: Text(
            "Add to Mypet",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),

    );
    ///////////
    final FloatingActionButton = Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(30),
    color: Colors.deepOrangeAccent,
    child : MaterialButton(
    onPressed: getImage,
    child: Icon(Icons.add_a_photo, color: Colors.white),


    ));
    ////////////
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.greenAccent),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),

                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    /*
                    child: _image == null
                        ? Text('No image selected.')
                        : Image.file(_image),

                     */
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Add your pet photo "),
                            SizedBox(height: 35),
                          ]),

                      FloatingActionButton,
                      SizedBox(height: 55),
                      breedField,
                      //SizedBox(height: 45),
                      dateOfBirthlField,
                      //SizedBox(height: 45),
                      sexField,
                      //SizedBox(height: 25),
                      nameField,
                      //SizedBox(height: 35),
                      weightField,
                      SizedBox(height: 35),
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
  ////////
///////
}

