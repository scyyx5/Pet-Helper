import 'package:intl/intl.dart';

class Setting {
  final String id;
  final String ally_colourBlind;
  final String ally_darkMode;
  final String ally_textSize;
  final String reminder_feed;
  final String reminder_walk;
  final String ally_contrastMode;

  Setting(
      {required this.id,
      required this.ally_colourBlind,
      required this.ally_darkMode,
      required this.ally_textSize,
      //////////required this.pet_pic_base64,
      required this.reminder_feed,
      required this.reminder_walk,
      required this.ally_contrastMode});

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
        id: json['id'],
        ally_colourBlind: json['ally_colourBlind'],
        ally_darkMode: json['ally_darkMode'],
        ally_textSize: json['ally_textSize'],
        reminder_feed: json['reminder_feed'],
        reminder_walk: json['reminder_walk'],
        ally_contrastMode: json['ally_contrastMode']);
  }
  dynamic toJson() => {
        'id': id,
        'ally_colourBlind': ally_colourBlind,
        'ally_darkMode': ally_darkMode,
        'ally_textSize': ally_textSize,
        'reminder_feed': reminder_feed,
        'reminder_walk': reminder_walk,
        'ally_contrastMode': ally_contrastMode
      };
}
