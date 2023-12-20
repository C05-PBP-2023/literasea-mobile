import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:literasea_mobile/Katalog/Screens/book_details.dart';
import 'dart:convert';
import 'package:literasea_mobile/Katalog/models/product.dart';
import 'package:literasea_mobile/main.dart';
import 'package:literasea_mobile/Katalog/Screens/filter_form.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

Future<void> addToCart(BuildContext context, int bookId) async {
  var userId = UserInfo.data["id"];
  var url = Uri.parse(
      'https://literasea.live/products/add_to_cart_flutter/$bookId/$userId/');

  var requestBody = {"user_id": userId};

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(requestBody),
  );

  if (context.mounted) {
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Book added successfully!')));
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to add book')));
    }
  }
}

class _ProductPageState extends State<ProductPage> {
  late List<Product> _allProducts;
  late List<Product> _filteredProducts;

  @override
  void initState() {
    super.initState();
    _allProducts = [];
    _filteredProducts = [];
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    var url = Uri.parse('https://literasea.live/products/get_book/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      _allProducts =
          body.map((dynamic item) => Product.fromJson(item)).toList();
      _filteredProducts = List.from(_allProducts);
      setState(() {});
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        elevation: 0.0,
        title: Text('Katalog Buku',
            style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black)),
        actions: [
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                showDragHandle: true,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return FilterForm(
                      onFilter: (authorName, publisher, publishedYear) {
                    _applyFilters(authorName, publisher, publishedYear);
                  });
                },
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
            ),
            child: Text('Filter', style: GoogleFonts.inter()),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildProductGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.60,
      ),
      itemCount: _filteredProducts.length,
      itemBuilder: (BuildContext context, int index) {
        Product product = _filteredProducts[index];
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
                      style: GoogleFonts.inter(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'by ${product.fields.bookAuthor}',
                      style: GoogleFonts.inter(color: Colors.grey.shade600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Published: ${product.fields.yearOfPublication}',
                      style: GoogleFonts.inter(color: Colors.grey.shade600),
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
                                    BookDetailsPage(product: product),
                              ),
                            );
                          },
                          child: Text('See Details',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold)),
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
  }

  void _applyFilters(
      String? authorName, String? publisher, int? publishedYear) {
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        return (authorName == null ||
                product.fields.bookAuthor.contains(authorName)) &&
            (publisher == null ||
                product.fields.publisher.contains(publisher)) &&
            (publishedYear == null ||
                product.fields.yearOfPublication == publishedYear);
      }).toList();
    });
  }
}
