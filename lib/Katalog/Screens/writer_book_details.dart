import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literasea_mobile/Katalog/models/product.dart';

class WriterBookDetailsPage extends StatelessWidget {
  final Product product;

  const WriterBookDetailsPage({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text('Detail Buku'),
        titleTextStyle: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), 
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.fields.image,
                width: 200, 
                height: 300, 
                fit: BoxFit.cover, 
                errorBuilder: ((context, error, stackTrace) {
                  return Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                    width: 64,
                  );
                }),
              ),const Padding(padding: EdgeInsets.only(bottom: 20.0),),
              const SizedBox(height: 12),
              Text(
                product.fields.bookTitle,
                style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
              ), const Padding(padding: EdgeInsets.only(bottom: 20.0),),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: 'ISBN: ',
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: product.fields.isbn,
                      style: GoogleFonts.inter(fontWeight: FontWeight.normal, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: 'Author: ',
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: product.fields.bookAuthor,
                      style: GoogleFonts.inter(fontWeight: FontWeight.normal, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: 'Publisher: ',
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: product.fields.publisher,
                      style: GoogleFonts.inter(fontWeight: FontWeight.normal, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: 'Year of Publication: ',
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${product.fields.yearOfPublication}',
                      style: GoogleFonts.inter(fontWeight: FontWeight.normal, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
