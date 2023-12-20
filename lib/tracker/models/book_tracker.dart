import 'dart:convert';

class BookTracker {
  BookTracker({
    required this.book_image,
    required this.book_title,
    required this.last_page,
    required this.last_read_timestamp,
  });

  String book_image;
  String book_title;
  String last_page;
  DateTime last_read_timestamp;

  factory BookTracker.fromJson(Map<String, dynamic> json) => BookTracker(
        book_image: json["book_image"],
        book_title: json["book_title"],
        last_page: json["last_page"],
        last_read_timestamp: DateTime.parse(json["last_read_timestamp"]),
      );

  Map<String, dynamic> toJson() => {
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
