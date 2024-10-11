import 'dart:convert';

class User {
  final int id;
  final String user_fname;
  final String user_lname;
  final String user_email;
  final String user_password;
  final String ally_colourBlind;
  final String ally_darkMode;
  final String ally_textSize;
  final String reminder_feed;
  final String reminder_walk;
  User({
    required this.id,
    required this.user_fname,
    required this.user_lname,
    required this.user_email,
    required this.user_password,
    required this.ally_colourBlind,
    required this.ally_darkMode,
    required this.ally_textSize,
    required this.reminder_feed,
    required this.reminder_walk,
  });

  User copyWith({
    int? id,
    String? user_fname,
    String? user_lname,
    String? user_email,
    String? user_phone,
    String? user_password,
    String? ally_colourBlind,
    String? ally_darkMode,
    String? ally_textSize,
    String? reminder_feed,
    String? reminder_walk,
  }) {
    return User(
      id: id ?? this.id,
      user_fname: user_fname ?? this.user_fname,
      user_lname: user_lname ?? this.user_lname,
      user_email: user_email ?? this.user_email,
      user_password: user_password ?? this.user_password,
      ally_colourBlind: ally_colourBlind ?? this.ally_colourBlind,
      ally_darkMode: ally_darkMode ?? this.ally_darkMode,
      ally_textSize: ally_textSize ?? this.ally_textSize,
      reminder_feed: reminder_feed ?? this.reminder_feed,
      reminder_walk: reminder_walk ?? this.reminder_walk,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_fname': user_fname,
      'user_lname': user_lname,
      'user_email': user_email,
      'user_password': user_password,
      'ally_colourBlind': ally_colourBlind,
      'ally_darkMode' : ally_darkMode,
      'ally_textSize' : ally_textSize,
      'reminder_feed': reminder_feed,
      'reminder_walk': reminder_walk
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      user_fname: map['user_fname'] ?? '',
      user_lname: map['user_lname'] ?? '',
      user_email: map['user_email'] ?? '',
      user_password: map['user_password'] ?? '',
      ally_colourBlind: map['ally_colourBlind'] ?? '',
      ally_darkMode: map['ally_darkMode'] ?? '',
      ally_textSize: map['ally_textSize'] ?? '',
      reminder_feed: map['reminder_feed'] ?? '',
      reminder_walk: map['reminder_walk'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, user_fname: $user_fname, user_lname: $user_lname, user_email: $user_email, user_password: $user_password, ally_colourBlind: $ally_colourBlind, ally_darkMode: $ally_darkMode, ally_textSize: $ally_textSize, reminder_feed: $reminder_feed, reminder_walk: $reminder_walk)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.user_fname == user_fname &&
        other.user_lname == user_lname &&
        other.user_email == user_email &&
        other.user_password == user_password &&
        other.ally_colourBlind == ally_colourBlind &&
        other.ally_darkMode == ally_darkMode &&
        other.ally_textSize == ally_textSize &&
        other.reminder_feed == reminder_feed &&
        other.reminder_walk == reminder_walk;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user_fname.hashCode ^
        user_lname.hashCode ^
        user_email.hashCode ^
        user_password.hashCode ^
        ally_colourBlind.hashCode ^
        ally_darkMode.hashCode ^
        ally_textSize.hashCode ^
        reminder_feed.hashCode ^
        reminder_walk.hashCode;
  }
}
