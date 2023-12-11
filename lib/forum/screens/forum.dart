import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:literasea_mobile/forum/models/question.dart';
import 'package:http/http.dart' as http;

class QNAPage extends StatefulWidget {
  const QNAPage({Key? key}) : super(key: key);

  @override
  State<QNAPage> createState() => _QNAPageState();
}

class _QNAPageState extends State<QNAPage> {
  Future<List<Question>> fetchQuestions() async {
    var url = Uri.parse('http://127.0.0.1:8000/forum/get-questions-mobile/');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      body: FutureBuilder(
        future: fetchQuestions(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "There are no question datas.",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${snapshot.data![index].fullName}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("${snapshot.data![index].title}"),
                      const SizedBox(height: 10),
                      Text("${snapshot.data![index].question}"),
                      const SizedBox(height: 10),
                      Text("${snapshot.data![index].bookTitle}"),
                      const SizedBox(height: 10),
                      Text("${snapshot.data![index].bookAuthor}"),
                      const SizedBox(height: 10),
                      Image.network(
                        "${snapshot.data![index].image}",
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
