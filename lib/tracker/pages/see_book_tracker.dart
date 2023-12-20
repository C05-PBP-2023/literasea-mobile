import 'package:flutter/material.dart';
import 'package:literasea_mobile/tracker/models/book_tracker.dart';
import 'package:literasea_mobile/main.dart';
import 'package:literasea_mobile/Katalog/models/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:literasea_mobile/tracker/models/book.dart';

class SeeBookTracker extends StatefulWidget {
  const SeeBookTracker({Key? key}) : super(key: key);

  @override
  State<SeeBookTracker> createState() => _SeeBookTrackerState();
}

class _SeeBookTrackerState extends State<SeeBookTracker> {
  bool value = false;
  Future<List<BookTracker>> fetchBookTracker() async {
    var url = Uri.parse(
        'https://literasea.live/tracker/mobile/' + UserInfo.data["id"]);
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    print(url);
    print(response);

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => BookTracker.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("yono");
    print(fetchBookTracker());
    return Scaffold(
        // backgroundColor: Colors.green[100],
        appBar: AppBar(
          title: Text("See Reading History"),
        ),
        // drawer: BookTrackerDrawer(context),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.greenAccent, Colors.blueGrey])),
          child: FutureBuilder(
              future: fetchBookTracker(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return Column(
                      children: const [
                        Text(
                          "Tidak ada buku terdeteksi",
                          style:
                              TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => InkWell(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.0),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black, blurRadius: 2.0)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: Image.network(
                                        snapshot.data![index].book_image,
                                        height: 200,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      "${snapshot.data![index].book_title}",
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "${snapshot.data![index].last_page}",
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          " ${snapshot.data![index].last_read_timestamp}",
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ));
                  }
                }
              }),
        ));
  }
}
