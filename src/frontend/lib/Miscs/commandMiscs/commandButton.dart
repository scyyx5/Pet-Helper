import 'package:flutter/material.dart';
import 'package:pethelper/Miscs/InfoPageMiscs/infos.dart';
import 'package:pethelper/Miscs/myPetScreenMiscs/calendarPage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:pethelper/SettingSave.dart';

class commandButton extends StatefulWidget {
  const commandButton({Key? key, required this.title, required this.url})
      : super(key: key);
  final String title, url;
  @override
  State<commandButton> createState() =>
      commandButtonState(title: this.title, url: this.url);
}

//working sites
//https://audio.code.org/start1.mp3
//https://www2.cs.uic.edu/~i101/SoundFiles/Fanfare60.wav

class commandButtonState extends State<commandButton> {
  final String title, url;
  commandButtonState({
    Key? key,
    required this.title,
    required this.url,
  });
  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    play() async {
      print("pressed");
      int result = await audioPlayer.play(url);
      if (result == 1) {
        print("played");
      } else {
        print("fail");
      }
    }

    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {
              play();
            },
            child: Row(children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.symmetric(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: darkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            MediaQuery.of(context).size.width * 0.05 * fontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
