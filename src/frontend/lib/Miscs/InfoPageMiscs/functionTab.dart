import 'package:flutter/material.dart';
import 'package:pethelper/Miscs/InfoPageMiscs/infos.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/calendarPage.dart';
import 'package:pethelper/SettingSave.dart';
import 'package:pethelper/const.dart';

class functionTab extends StatelessWidget {
  final String heroid, title, article, image;

  const functionTab({
    Key? key,
    required this.heroid,
    required this.title,
    required this.article,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => infos(
                      title: title,
                      article: article,
                      image: image,
                      id: heroid)));
            },
            child: Row(children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Hero(
                        tag: heroid,
                        child: Image.network(
                          net + image,
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.15,
                        )
                        /*
                      Image(
                        image: AssetImage(image),
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.width * 0.15,
                      ),
                      */
                        ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Text(
                        title,
                        style: TextStyle(
                          color: darkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width *
                              0.05 *
                              fontSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
