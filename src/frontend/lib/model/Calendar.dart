class Calendar {
  final String pet;
  final String date;
  final String title;
  final String isChecked;
  final String user;

  Calendar(
      {required this.pet,
      required this.date,
      required this.title,
      required this.isChecked,
      required this.user});

  factory Calendar.fromJson(Map<String, dynamic> json) {
    return Calendar(
        pet: json['pet'],
        date: json['date'],
        title: json['title'],
        isChecked: json['isChecked'],
        user: json['user']);
  }

  dynamic toJson() => {
        'pet': pet,
        'date': date,
        'title': title,
        'isChecked': isChecked,
        'user': user
      };
}

class Calendar1 {
  final String pet;
  final String date;
  final String title;
  final String isChecked;
  final String user;
  final String id;

  Calendar1(
      {required this.pet,
      required this.date,
      required this.title,
      required this.isChecked,
      required this.user,
      required this.id});

  factory Calendar1.fromJson(Map<String, dynamic> json) {
    return Calendar1(
        pet: json['pet'],
        date: json['date'],
        title: json['title'],
        isChecked: json['isChecked'],
        user: json['user'],
        id: json['id']);
  }

  dynamic toJson() => {
        'pet': pet,
        'date': date,
        'title': title,
        'isChecked': isChecked,
        'user': user,
        'id': id,
      };
}
