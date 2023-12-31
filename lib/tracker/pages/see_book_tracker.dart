import 'package:flutter/material.dart';
import 'package:literasea_mobile/tracker/models/book_tracker.dart';
import 'package:literasea_mobile/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:literasea_mobile/tracker/pages/add_book_tracker.dart';

class SeeBookTracker extends StatefulWidget {
  const SeeBookTracker({Key? key}) : super(key: key);

  @override
  State<SeeBookTracker> createState() => _SeeBookTrackerState();
}

class _SeeBookTrackerState extends State<SeeBookTracker> {
  Future<List<BookTracker>> fetchBookTracker() async {
    var url = Uri.parse(
        'https://literasea.live/tracker/mobile/${UserInfo.data["id"]}');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => BookTracker.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff00134E)),
        title: Text(
          "Here is your reading history",
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: Color(0xff00134E),
            ),
          ),
        ),
        centerTitle: false,
        backgroundColor: const Color(0xffddf3ff),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Don't miss out on tracking your reading journey with Literasea!",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddBookTracker(),
                        ),
                      );
                    },
                    child: Text(
                      "Add Reading History",
                      style: GoogleFonts.inter(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: fetchBookTracker(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (!snapshot.hasData) {
                      return const Column(
                        children: [
                          Text(
                            "Tidak ada buku terdeteksi",
                            style: TextStyle(
                              color: Color(0xff59A5D8),
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 12),
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade200,
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: const [
                              BoxShadow(color: Colors.black, blurRadius: 2.0),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: Image.network(
                                  snapshot.data![index].bookImage,
                                  height: 200,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                "${snapshot.data![index].bookTitle}",
                                style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Last page: ${snapshot.data![index].lastPage}",
                                style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Timestamp: ${snapshot.data![index].lastReadTimestamp}",
                                style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
