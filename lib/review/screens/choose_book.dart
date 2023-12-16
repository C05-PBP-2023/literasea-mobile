import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:literasea_mobile/Katalog/models/product.dart';
import 'package:literasea_mobile/review/screens/addreview.dart';


class ReviewProductPage extends StatefulWidget {
  const ReviewProductPage({Key? key}) : super(key: key);

  @override
  _ReviewProductPageState createState() => _ReviewProductPageState();
}

class _ReviewProductPageState extends State<ReviewProductPage> {
  Future<List<Product>> fetchProduct() async {
    var url = Uri.parse('http://127.0.0.1:8000/review/get-book-review/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: FutureBuilder<List<Product>>(
        future: fetchProduct(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No products found."));
          }

          List<Product> products = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.55,
            ),
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              Product product = products[index];
              return Card(
                color: Colors.white,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        width: double.infinity,
                        child: Image.network(
                          product.fields.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.fields.bookTitle,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'by ${product.fields.bookAuthor}',
                            style: TextStyle(color: Colors.grey.shade600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Published: ${product.fields.yearOfPublication}',
                            style: TextStyle(color: Colors.grey.shade600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.blue[600],
                                  backgroundColor: Colors.blue[50],
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  ReviewFormPage(product: product)) // BookDetailsPage(product: product)
                                  );
                                  _showReviewSnackbar();
                                },
                                child: const Text('Review this Book!'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showReviewSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Directing to our form page...'), backgroundColor: Color(0xFF0C356A),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
  AppBar appBar() {
    return AppBar(
      title: Text(
        'Choose Book to Review!',
        style: TextStyle(
          color: Color(0xFF005B9C),
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0.0,
    );
  }