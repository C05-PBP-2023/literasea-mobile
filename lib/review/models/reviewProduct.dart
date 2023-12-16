// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

List<Review> reviewFromJson(String str) => List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
    String image;
    String fullname;
    String bookTitle;
    String bookAuthor;
    String reviewMessage;
    int rating;

    Review({
        required this.image,
        required this.fullname,
        required this.bookTitle,
        required this.bookAuthor,
        required this.reviewMessage,
        required this.rating,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        image: json["image"],
        fullname: json["fullname"],
        bookTitle: json["BookTitle"],
        bookAuthor: json["BookAuthor"],
        reviewMessage: json["reviewMessage"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "fullname": fullname,
        "BookTitle": bookTitle,
        "BookAuthor": bookAuthor,
        "reviewMessage": reviewMessage,
        "rating": rating,
    };
}
