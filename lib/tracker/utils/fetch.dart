import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:literasea_mobile/tracker/models/book_tracker.dart';
import 'package:literasea_mobile/tracker/models/book.dart';

Future<List<BookTracker>> fetchBookTracker(uid) async {
  String userId = uid.toString();

  var url = Uri.parse('https://literasea.live/tracker/mobile/$userId');
  var response = await http.get(url, headers: {
    "Access-Control-Allow-Origin": "*",
    "Content-Type": "application/json",
  });

  var data = jsonDecode(utf8.decode(response.bodyBytes));

  List<BookTracker> listBookTracker = [];
  for (var d in data) {
    if (d != null) {
      listBookTracker.add(BookTracker.fromJson(d));
    }
  }
  return listBookTracker;
}

Future<List<Book>> fetchBook() async {
  var url = Uri.parse('https://literasea.live/tracker/book/mobile');
  var response = await http.get(url, headers: {
    "Access-Control-Allow-Origin": "*",
    "Content-Type": "application/json",
  });

  var data = jsonDecode(utf8.decode(response.bodyBytes));

  List<Book> listBook = [];
  for (var d in data) {
    if (d != null) {
      listBook.add(Book.fromJson(d));
    }
  }
  return listBook;
}
