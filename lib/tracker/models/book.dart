import 'dart:convert';

class Book {
  Book({
    required this.id,
    required this.isbn,
    required this.book_title,
    required this.book_author,
    required this.year_of_publication,
    required this.publisher,
    required this.image,
  });

  int id;
  String isbn;
  String book_title;
  String book_author;
  int year_of_publication;
  String publisher;
  String image;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["pk"],
        isbn: json["fields"]["ISBN"],
        book_title: json["fields"]["BookTitle"],
        book_author: json["fields"]["BookAuthor"],
        year_of_publication: json["fields"]["Year_Of_Publication"],
        publisher: json["fields"]["Publisher"],
        image: json["fields"]["Image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isbn": isbn,
        "book_title": book_title,
        "book_author": book_author,
        "year_of_publication": year_of_publication,
        "publisher": publisher,
        "image": image,
      };
}

List<Book> reviewFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String reviewToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
