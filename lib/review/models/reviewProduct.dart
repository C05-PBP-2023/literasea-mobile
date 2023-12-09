// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

List<Review> reviewFromJson(String str) => List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
    Model model;
    int pk;
    Fields fields;

    Review({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
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
    int bookReview;
    int rating;
    String reviewMessage;

    Fields({
        required this.user,
        required this.bookReview,
        required this.rating,
        required this.reviewMessage,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        bookReview: json["book_review"],
        rating: json["rating"],
        reviewMessage: json["review_message"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "book_review": bookReview,
        "rating": rating,
        "review_message": reviewMessage,
    };
}

enum Model {
    REVIEW_REVIEW
}

final modelValues = EnumValues({
    "review.review": Model.REVIEW_REVIEW
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
