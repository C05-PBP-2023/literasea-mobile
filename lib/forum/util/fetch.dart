import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:literasea_mobile/forum/models/question.dart';

Future<List<Question>> fetchQuestions() async {
  var url = Uri.parse('https://literasea.live/forum/get-questions-mobile/');
  var response = await http.get(
    url,
    headers: {"Content-Type": "application/json"},
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object Product
  List<Question> listQuestions = [];
  for (var d in data) {
    if (d != null) {
      listQuestions.add(Question.fromJson(d));
    }
  }
  return listQuestions;
}
