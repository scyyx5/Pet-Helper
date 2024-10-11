import 'dart:convert';

class User {
  final int id;
  User({
    required this.id,
  });

  User copyWith({
    int? id,
  }) {
    return User(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class Login {
  final User user;
  final String token;
  Login({
    required this.user,
    required this.token,
  });

  Login copyWith({
    User? user,
    String? token,
  }) {
    return Login(
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'token': token,
    };
  }

  factory Login.fromMap(Map<String, dynamic> map) {
    return Login(
      user: User.fromMap(map['user']),
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Login.fromJson(String source) => Login.fromMap(json.decode(source));

  @override
  String toString() => 'Login(user: $user, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Login && other.user == user && other.token == token;
  }

  @override
  int get hashCode => user.hashCode ^ token.hashCode;
}

//class User {
//   final String username;
//   final int id;
//   final String first_name;
//   final String last_name;
//   final String email;
//   final String password;
//   final String ally_colourBlind;
//   final String ally_darkMode;
//   final String ally_textSize;
//   final String reminder_feed;
//   final String reminder_walk;
//   User({
//     required this.username,
//     required this.id,
//     required this.first_name,
//     required this.last_name,
//     required this.email,
//     required this.password,
//     required this.ally_colourBlind,
//     required this.ally_darkMode,
//     required this.ally_textSize,
//     required this.reminder_feed,
//     required this.reminder_walk,
//   });

//   User copyWith({
//     String? username,
//     int? id,
//     String? first_name,
//     String? last_name,
//     String? email,
//     String? user_phone,
//     String? password,
//     String? ally_colourBlind,
//     String? ally_darkMode,
//     String? ally_textSize,
//     String? reminder_feed,
//     String? reminder_walk,
//   }) {
//     return User(
//       username: username ?? this.username,
//       id: id ?? this.id,
//       first_name: first_name ?? this.first_name,
//       last_name: last_name ?? this.last_name,
//       email: email ?? this.email,
//       password: password ?? this.password,
//       ally_colourBlind: ally_colourBlind ?? this.ally_colourBlind,
//       ally_darkMode: ally_darkMode ?? this.ally_darkMode,
//       ally_textSize: ally_textSize ?? this.ally_textSize,
//       reminder_feed: reminder_feed ?? this.reminder_feed,
//       reminder_walk: reminder_walk ?? this.reminder_walk,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'username':username,
//       'id': id,
//       'first_name': first_name,
//       'last_name': last_name,
//       'email': email,
//       'password': password,
//       'ally_colourBlind': ally_colourBlind,
//       'ally_darkMode': ally_darkMode,
//       'ally_textSize': ally_textSize,
//       'reminder_feed': reminder_feed,
//       'reminder_walk': reminder_walk
//     };
//   }

//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       username: map['username'] ?? '',
//       id: map['id']?.toInt() ?? 0,
//       first_name: map['first_name'] ?? '',
//       last_name: map['last_name'] ?? '',
//       email: map['email'] ?? '',
//       password: map['password'] ?? '',
//       ally_colourBlind: map['ally_colourBlind'] ?? '',
//       ally_darkMode: map['ally_darkMode'] ?? '',
//       ally_textSize: map['ally_textSize'] ?? '',
//       reminder_feed: map['reminder_feed'] ?? '',
//       reminder_walk: map['reminder_walk'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory User.fromJson(String source) => User.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'User(username: $username, id: $id, first_name: $first_name, last_name: $last_name, email: $email, password: $password, ally_colourBlind: $ally_colourBlind, ally_darkMode: $ally_darkMode, ally_textSize: $ally_textSize, reminder_feed: $reminder_feed, reminder_walk: $reminder_walk)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is User &&
//         other.id == id &&
//         other.first_name == first_name &&
//         other.last_name == last_name &&
//         other.email == email &&
//         other.password == password &&
//         other.ally_colourBlind == ally_colourBlind &&
//         other.ally_darkMode == ally_darkMode &&
//         other.ally_textSize == ally_textSize &&
//         other.reminder_feed == reminder_feed &&
//         other.reminder_walk == reminder_walk;
//   }

//   @override
//   int get hashCode {
//     return
//         username.hashCode ^
//         id.hashCode ^
//         first_name.hashCode ^
//         last_name.hashCode ^
//         email.hashCode ^
//         password.hashCode ^
//         ally_colourBlind.hashCode ^
//         ally_darkMode.hashCode ^
//         ally_textSize.hashCode ^
//         reminder_feed.hashCode ^
//         reminder_walk.hashCode;
//   }
// }