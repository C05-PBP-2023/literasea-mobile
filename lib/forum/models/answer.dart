// To parse this JSON data, do
//
//     final answer = answerFromJson(jsonString);

import 'dart:convert';

List<Answer> answerFromJson(String str) =>
    List<Answer>.from(json.decode(str).map((x) => Answer.fromJson(x)));

String answerToJson(List<Answer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Answer {
  Model model;
  int pk;
  Fields fields;

  Answer({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  int question;
  String answer;

  Fields({
    required this.user,
    required this.question,
    required this.answer,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "question": question,
        "answer": answer,
      };
}

enum Model { FORUM_ANSWER }

final modelValues = EnumValues({"forum.answer": Model.FORUM_ANSWER});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
