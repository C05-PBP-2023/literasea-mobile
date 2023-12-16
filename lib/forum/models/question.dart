// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';

List<Question> questionFromJson(String str) =>
    List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));

String questionToJson(List<Question> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Question {
  int id;
  String title;
  String question;
  String fullName;
  String bookTitle;
  String bookAuthor;
  String image;
  bool answered;
  String answer;
  String userAnswer;

  Question({
    required this.id,
    required this.title,
    required this.question,
    required this.fullName,
    required this.bookTitle,
    required this.bookAuthor,
    required this.image,
    required this.answered,
    required this.answer,
    required this.userAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        title: json["title"],
        question: json["question"],
        fullName: json["full_name"],
        bookTitle: json["BookTitle"],
        bookAuthor: json["BookAuthor"],
        image: json["Image"],
        answered: json["answered"],
        answer: json["answer"],
        userAnswer: json["user_answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "question": question,
        "full_name": fullName,
        "BookTitle": bookTitle,
        "BookAuthor": bookAuthor,
        "Image": image,
        "answered": answered,
        "answer": answer,
        "user_answer": userAnswer,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
