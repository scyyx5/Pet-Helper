import 'dart:convert';

class User {
  final String refresh;
  //final int id;
  final String access;

  User({required this.access, required this.refresh});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(refresh: map['refresh'] ?? '', access: map['access'] ?? '');
  }

  /*
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'],
        id: json['id'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        email: json['email'],
        password: json['password']);
  }
  dynamic toJson() => {
    'username': username,
    'id': id,
    'first_name': first_name,
    'last_name': last_name,
    'email':email,
    'password':password
  };
   */
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
