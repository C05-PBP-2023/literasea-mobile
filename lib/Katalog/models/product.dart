// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    Model model;
    int pk;
    Fields fields;

    Product({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
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
    String isbn;
    String bookTitle;
    String bookAuthor;
    int yearOfPublication;
    String publisher;
    String image;

    Fields({
        required this.isbn,
        required this.bookTitle,
        required this.bookAuthor,
        required this.yearOfPublication,
        required this.publisher,
        required this.image,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        isbn: json["ISBN"],
        bookTitle: json["BookTitle"],
        bookAuthor: json["BookAuthor"],
        yearOfPublication: json["Year_Of_Publication"],
        publisher: json["Publisher"],
        image: json["Image"],
    );

    Map<String, dynamic> toJson() => {
        "ISBN": isbn,
        "BookTitle": bookTitle,
        "BookAuthor": bookAuthor,
        "Year_Of_Publication": yearOfPublication,
        "Publisher": publisher,
        "Image": image,
    };
}

enum Model {
    PRODUCTS_KATALOG
}

final modelValues = EnumValues({
    "products.katalog": Model.PRODUCTS_KATALOG
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
