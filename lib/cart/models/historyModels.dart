// To parse this JSON data, do
//
//     final history = historyFromJson(jsonString);

import 'dart:convert';

List<History> historyFromJson(String str) => List<History>.from(json.decode(str).map((x) => History.fromJson(x)));

String historyToJson(List<History> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class History {
    String model;
    int pk;
    Fields fields;

    History({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory History.fromJson(Map<String, dynamic> json) => History(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    String nama;
    String alamat;
    DateTime tanggal;
    List<int> buku;

    Fields({
        required this.user,
        required this.nama,
        required this.alamat,
        required this.tanggal,
        required this.buku,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        nama: json["nama"],
        alamat: json["alamat"],
        tanggal: DateTime.parse(json["tanggal"]),
        buku: List<int>.from(json["buku"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "nama": nama,
        "alamat": alamat,
        "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "buku": List<dynamic>.from(buku.map((x) => x)),
    };
}
