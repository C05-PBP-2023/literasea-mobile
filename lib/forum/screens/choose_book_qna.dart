import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:literasea_mobile/Katalog/models/product.dart';
import 'package:literasea_mobile/forum/widgets/add_question_sheet.dart';
import 'package:literasea_mobile/Katalog/Screens/filter_form.dart';

class QNAChooseBook extends StatefulWidget {
  const QNAChooseBook({Key? key}) : super(key: key);

  @override
  _QNAChooseBookState createState() => _QNAChooseBookState();
}

class _QNAChooseBookState extends State<QNAChooseBook> {
  late List<Product> _allProducts;
  late List<Product> _filteredProducts;
  bool _showFilterForm = false;

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
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        title: Text(
          "Ask a Question",
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 24,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _showFilterForm = !_showFilterForm;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                _showFilterForm ? 'HIDE FILTER' : 'FILTER',
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showFilterForm)
            FilterForm(onFilter: (authorName, publisher, publishedYear) {
              _applyFilters(authorName, publisher, publishedYear);
            }),
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
        childAspectRatio: 0.58,
      ),
      itemCount: _filteredProducts.length,
      itemBuilder: (BuildContext context, int index) {
        Product product = _filteredProducts[index];
        return InkWell(
          child: Card(
            elevation: 3,
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
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
                          textStyle: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'by ${product.fields.bookAuthor}',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(color: Colors.grey.shade600),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Published: ${product.fields.yearOfPublication}',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(color: Colors.grey.shade600),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
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
                return AddQuestionForm(
                  product,
                );
              },
            );
            // ).then(
            //   (_) => setState(() {
            //     _data = fetchQuestions();
            //   }),
            // );
          },
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
