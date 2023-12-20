import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:literasea_mobile/Katalog/models/product.dart';
import 'package:literasea_mobile/tracker/models/book_tracker.dart';
import 'package:literasea_mobile/main.dart';

Future<List<BookTracker>> fetchBookTracker() async {
  var url =
      Uri.parse('https://literasea.live/tracker/mobile/${UserInfo.data["id"]}');
  var response = await http.get(url, headers: {
    "Access-Control-Allow-Origin": "*",
    "Content-Type": "application/json",
  });

  print(url);

  var data = jsonDecode(utf8.decode(response.bodyBytes));

  print(data);

  List<BookTracker> listBookTracker = [];
  for (var d in data) {
    if (d != null) {
      listBookTracker.add(BookTracker.fromJson(d));
    }
  }
  return listBookTracker;
}

Future<List<Product>> fetchBook() async {
  var url = Uri.parse('https://literasea.live/tracker/book/mobile');
  var response = await http.get(url, headers: {
    "Access-Control-Allow-Origin": "*",
    "Content-Type": "application/json",
  });

  var data = jsonDecode(utf8.decode(response.bodyBytes));

  List<Product> listBook = [];
  for (var d in data) {
    if (d != null) {
      listBook.add(Product.fromJson(d));
    }
  }
  return listBook;
}
