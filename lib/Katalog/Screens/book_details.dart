import 'package:flutter/material.dart';
import 'package:literasea_mobile/Katalog/models/product.dart';

class BookDetailsPage extends StatelessWidget {
  final Product product;

  const BookDetailsPage({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Buku'),
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView( // To ensure the content is scrollable if it overflows
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add padding around the content
          child: Column(
            mainAxisSize: MainAxisSize.min, // Content takes minimum space on the main axis
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
            children: [
              Image.network(
                product.fields.image,
                width: 200, // Fixed width, adjust as needed
                height: 300, // Fixed height, adjust as needed
                fit: BoxFit.cover, // This is the default
              ),Padding(padding: const EdgeInsets.only(bottom: 20.0),),
              SizedBox(height: 12),
              Text(
                product.fields.bookTitle,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ), Padding(padding: const EdgeInsets.only(bottom: 20.0),),
              SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: 'ISBN: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: product.fields.isbn,
                      style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: 'Author: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: product.fields.bookAuthor,
                      style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: 'Publisher: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: product.fields.publisher,
                      style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: 'Year of Publication: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${product.fields.yearOfPublication}',
                      style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start, // Align buttons to the left
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Add functionality for adding to cart
                    },
                    child: Text('Add to Cart'),
                    style: TextButton.styleFrom(
                                  foregroundColor: Colors.blue[600],
                                  backgroundColor: Colors.blue[50],
                                ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
