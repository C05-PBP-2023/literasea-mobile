// To parse this JSON data, do
//
//     final bookTracker = bookTrackerFromJson(jsonString);

import 'dart:convert';

List<BookTracker> bookTrackerFromJson(String str) => List<BookTracker>.from(
    json.decode(str).map((x) => BookTracker.fromJson(x)));

String bookTrackerToJson(List<BookTracker> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookTracker {
  String bookImage;
  String bookTitle;
  int lastPage;
  DateTime lastReadTimestamp;

  BookTracker({
    required this.bookImage,
    required this.bookTitle,
    required this.lastPage,
    required this.lastReadTimestamp,
  });

  factory BookTracker.fromJson(Map<String, dynamic> json) => BookTracker(
        bookImage: json["book_image"],
        bookTitle: json["book_title"],
        lastPage: json["last_page"],
        lastReadTimestamp: DateTime.parse(json["last_read_timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "book_image": bookImage,
        "book_title": bookTitle,
        "last_page": lastPage,
        "last_read_timestamp": lastReadTimestamp.toIso8601String(),
      };
}
