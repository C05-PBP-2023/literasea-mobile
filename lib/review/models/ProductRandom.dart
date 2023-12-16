// To parse this JSON data, do
//
//     final productR = productRFromJson(jsonString);

import 'dart:convert';

List<ProductR> productRFromJson(String str) => List<ProductR>.from(json.decode(str).map((x) => ProductR.fromJson(x)));

String productRToJson(List<ProductR> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductR {
    int id;
    String bookTitle;
    String bookAuthor;
    String image;

    ProductR({
        required this.id,
        required this.bookTitle,
        required this.bookAuthor,
        required this.image,
    });

    factory ProductR.fromJson(Map<String, dynamic> json) => ProductR(
        id: json["id"],
        bookTitle: json["BookTitle"],
        bookAuthor: json["BookAuthor"],
        image: json["Image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "BookTitle": bookTitle,
        "BookAuthor": bookAuthor,
        "Image": image,
    };
}
