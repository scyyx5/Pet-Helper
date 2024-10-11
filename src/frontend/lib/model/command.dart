class Command {
  String title;
  String teach;
  String filepath;

  Command({required this.title, required this.teach, required this.filepath});

  factory Command.fromJson(Map<String, dynamic> json) {
    return Command(
        title: json['title'], teach: json['teach'], filepath: json['filepath']);
  }
}
