import 'dart:convert';

class BookTracker {
  BookTracker({
    required this.id,
    required this.user,
    required this.book,
    required this.book_image,
    required this.book_title,
    required this.last_page,
    required this.last_read_timestamp,
  });

  int id;
  int user;
  int book;
  String book_image;
  String book_title;
  int last_page;
  DateTime last_read_timestamp;

  factory BookTracker.fromJson(Map<String, dynamic> json) => BookTracker(
        id: json["pk"],
        user: json["fields"]["user"],
        book: json["fields"]["book"],
        book_image: json["fields"]["book_image"],
        book_title: json["fields"]["book_title"],
        last_page: json["fields"]["last_page"],
        last_read_timestamp:
            DateTime.parse(json["fields"]["last_read_timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "book": book,
        "book_image": book_image,
        "book_title": book_title,
        "last_page": last_page,
        "last_read_timestamp": last_read_timestamp.toIso8601String(),
      };
}

List<BookTracker> reviewFromJson(String str) => List<BookTracker>.from(
    json.decode(str).map((x) => BookTracker.fromJson(x)));

String reviewToJson(List<BookTracker> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
