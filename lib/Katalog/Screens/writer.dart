import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:literasea_mobile/Katalog/Screens/addBook_form.dart';
import 'package:literasea_mobile/Katalog/Screens/writer_book_details.dart';
import 'dart:convert';
import 'package:literasea_mobile/Katalog/models/product.dart';

class WriterPage extends StatefulWidget {
  const WriterPage({Key? key}) : super(key: key);

  @override
  _WriterPageState createState() => _WriterPageState();
}

class _WriterPageState extends State<WriterPage> {
  Future<List<Product>> fetchProduct() async {
    var url = Uri.parse('https://literasea.live/products/get_book/');
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
      appBar: AppBar(
        title: Text('Katalog Buku', style: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: Colors.black
        )),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddBookPage()),
              );
            },
            tooltip: 'Add Book',
          ),
        ],
      ),
      backgroundColor: Colors.blue[100],
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
              childAspectRatio: 0.60,
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
                      aspectRatio: 1.75,
                      child: SizedBox(
                        width: double.infinity,
                        child: Image.network(
                          product.fields.image,
                          fit: BoxFit.cover,
                          errorBuilder: ((context, error, stackTrace) {
                            return Image.network(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                              width: 64,
                            );
                          }),
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
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.inter().fontFamily,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'by ${product.fields.bookAuthor}',
                            style: TextStyle(color: Colors.grey.shade600, fontFamily: GoogleFonts.inter().fontFamily),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Published: ${product.fields.yearOfPublication}',
                            style: TextStyle(color: Colors.grey.shade600, fontFamily: GoogleFonts.inter().fontFamily),
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
                                      builder: (context) =>
                                          WriterBookDetailsPage(product: product),
                                    ),
                                  );
                                },
                                child: const Text('See Details'),
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
}