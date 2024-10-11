import 'dart:convert';

Feedback userFeedbackFromJson(String str) =>
    Feedback.fromJson(json.decode(str));
String userFeedbackToJson(Feedback data) => json.encode(data.toJson());

class Feedback {
  final int id;
  final String feedback;
  Feedback(
    this.id,
    this.feedback,
  );

  Feedback copyWith({
    int? id,
    String? feedback,
  }) {
    return Feedback(
      id ?? this.id,
      feedback ?? this.feedback,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'feedback': feedback,
    };
  }

  factory Feedback.fromMap(Map<String, dynamic> map) {
    return Feedback(
      map['id']?.toInt() ?? 0,
      map['feedback'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Feedback.fromJson(String source) =>
      Feedback.fromMap(json.decode(source));

  @override
  String toString() => 'Feedback(id: $id, feedback: $feedback)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Feedback && other.id == id && other.feedback == feedback;
  }

  @override
  int get hashCode => id.hashCode ^ feedback.hashCode;
}
