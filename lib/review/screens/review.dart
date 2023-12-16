import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:literasea_mobile/review/models/reviewProduct.dart';
import 'package:literasea_mobile/review/screens/choose_book.dart';
import 'package:literasea_mobile/review/screens/addreview.dart';
import 'package:literasea_mobile/Katalog/models/product.dart';
import 'package:http/http.dart' as http;

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<Review> list_review = [];
  List<Product> list_product = [];
  List<Review> latest_review = [];
  Future<List<Review>> fetchReview() async {
    var url = Uri.parse('http://127.0.0.1:8000/review/show-review-flutter/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    @override
    void initState() {
      fetchProduct();
      fetchReview();
    }

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    list_review.clear();

    for (var d in data) {
      if (d != null) {
        list_review.add(Review.fromJson(d));
      }
    }
    return list_review;
  }
  Future<List<Product>> fetchProduct() async {
    var url = Uri.parse('http://127.0.0.1:8000/products/get_book/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    list_product.clear();

    for (var d in data) {
      if (d != null) {
        list_product.add(Product.fromJson(d));
      }
    }
    return list_product;
  }

    Future<List<Review>> fetchLatestReview() async {
    var url = Uri.parse('http://127.0.0.1:8000/review/get-latest-reviews/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    latest_review.clear();

    for (var d in data) {
      if (d != null) {
        latest_review.add(Review.fromJson(d));
      }
    }
    return latest_review;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              Container(
                width: 425,
                child: const Text(
                  "Join our vibrant community of book lovers and share your unique insights and opinions by adding your book reviews!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFF146C94),
                      fontSize: 15),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showRedirectingSnackbar(context); // Show snackbar
                  // Uncomment the next line if you want to navigate to another page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ReviewProductPage())); // ReviewFormPage()
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(80, 40),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "Review Books Now!",
                  style: TextStyle(
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Latest Review",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              FutureBuilder(
                future: fetchLatestReview(),
                builder: (context, snapshot) {
                  return Container(
                    height: 175,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: latest_review.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 30),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        itemBuilder: (context, index) {
                          Review lastReview = latest_review[index];
                          return Container(
                            width: 325,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 36, 79, 114)
                                    .withOpacity(0.35),
                                borderRadius: BorderRadius.circular(20)),
                            child : Row(
                              children: [
                                Text(
                                  lastReview.reviewMessage,
                                  style: TextStyle(
                                    color:  Colors.white,
                                    fontFamily: 'Inter',
                                    fontSize: 10
                                  ),
                                )
                              ],)
                          );
                        }),
                  );
                }
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Top 3 Books",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 125,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3, //ini nyoba dulu
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 30),
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    itemBuilder: (context, index) {
                      List<Color> backgroundJuara = [
                        Color(0xFFBB5C),
                        Color(0xB6BBC4),
                        Color(0x994D1C)
                      ];
                      return Container(
                        width: 125,
                        height: 125,
                        decoration: BoxDecoration(
                            color: backgroundJuara[index].withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                          'BOOK ${index + 1}',
                          style: const TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold),
                        )),
                      );
                    }),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Our Reader Review",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              FutureBuilder(
                future: fetchReview(),
                builder: (context, AsyncSnapshot snapshot) {
                  return Container(
                    height: 175,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: list_review.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 30),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        itemBuilder: (context, index) {
                          Review review = list_review[index];
                          return Container(
                            width: 350,
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.35),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6.0),
                                  child: Image.network(
                                    review.image,
                                    width: 65,
                                    height: 130,
                                    fit: BoxFit.cover,    
                                  ),
                                ),
                                const SizedBox(width: 25),
                                Container(
                                  width: 230,
                                  height: 150,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: 
                                        Text(
                                          "${review.bookTitle}",
                                          maxLines: 2,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15
                                            ),
                                        ), 
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: 
                                        Text(
                                          "'${review.reviewMessage}'",
                                          maxLines: 2,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Inter',
                                            fontStyle: FontStyle.italic,
                                            fontSize: 13
                                            ),
                                        ), 
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: 
                                        Text(
                                          "Rate: ${review.rating} / 5",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Inter',
                                            fontSize: 13
                                            ),
                                        ), 
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: 
                                        Text(
                                          "Author : ${review.bookAuthor}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Inter',
                                            fontSize: 13
                                            ),
                                        ), 
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                }
              ),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        'Review Your Book!',
        style: TextStyle(
          color: Color(0xFF005B9C),
          fontFamily: 'Inter',
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0.0,
    );
  }

  void showRedirectingSnackbar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Directing to our catalog...'),
      backgroundColor: Color(0xFF0C356A),
      duration: Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
