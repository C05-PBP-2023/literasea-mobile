import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literasea_mobile/Katalog/Screens/book_details.dart';
import 'package:literasea_mobile/Katalog/Screens/reader.dart';
import 'package:literasea_mobile/cart/screens/cart.dart';
import 'package:literasea_mobile/forum/screens/forum.dart';
import 'package:literasea_mobile/Katalog/Screens/writer.dart';
import 'package:literasea_mobile/json/const.dart';
import 'package:literasea_mobile/review/screens/review.dart';
import 'package:literasea_mobile/main.dart';
import 'package:literasea_mobile/Katalog/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Product> _allProducts;

  @override
  void initState() {
    super.initState();
    _allProducts = [];
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
      setState(() {});
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 60, 0, 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, ${UserInfo.data["fullname"]}!",
                        style: GoogleFonts.inter(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: Colors.white
                        ),
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet, \nconsectetur",
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: Colors.white
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const CartPage()
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.shopping_cart,
                              size: 15,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "My Cart",
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        )
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset('assets/images/buku_homepage.png', width: 140, height: 140,),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 60, bottom: 30),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(80))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    3,
                    (index) {
                      return Container(
                        padding: const EdgeInsets.only(
                            right: 20.0, left: 20.0, bottom: 15.0),
                        height: 130,
                        width: double.infinity,
                        child: Material(
                          child: InkWell(
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 20),
                              width: 65,
                              height: 25,
                              decoration: BoxDecoration(
                                  color: homePageButtons[index]["color"],
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 32.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          homePageButtons[index]["name"],
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 22,
                                              color: Colors.white
                                            ),
                                          ),
                                        ),
                                        Text(
                                          homePageButtons[index]["desc"],
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 11,
                                              color: Colors.white
                                            )
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0, bottom: 10),
                                    child: Stack(
                                      children: [
                                        RotationTransition(
                                          turns:  const AlwaysStoppedAnimation(330 / 360),
                                          child: Container(
                                            height: 45,
                                            width: 60,
                                            margin: const EdgeInsets.only(top: 40, left: 40, right: 40),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.3),
                                              borderRadius: const BorderRadius.all(Radius.elliptical(90, 70)),
                                            ),
                                            child: const Text(''),
                                          ),
                                        ),
                                        Positioned(
                                          top: 24,
                                          left: 55,
                                          child: Icon(
                                            homePageButtons[index]["icon"],
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              if (homePageButtons[index]["name"] == "Catalogue") {
                                if (UserInfo.data["type"] == "writer") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const WriterPage()));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const ProductPage()));
                                }
                              } else if (homePageButtons[index]["name"] ==
                                  "Reviews") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const ReviewPage()));
                              } else if (homePageButtons[index]["name"] == "Q & A") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const QNAPage()));
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,10,0,20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "New Book",
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          3,
                          (index){
                            String? imageLink = "";
                            Product? book;
                  
                            if(_allProducts.isNotEmpty){
                              book = _allProducts[Random().nextInt(_allProducts.length)];
                              imageLink = book.fields.image;
                            }
                  
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => BookDetailsPage(product: book!,))
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.only(left: 10, right: 10),
                                height: 200,
                                width: MediaQuery.of(context).size.width * 0.27,
                                decoration: BoxDecoration(
                                  color: const Color(0xffd7e9f4),
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(13), bottom: Radius.circular(13)
                                    ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 5,
                                      offset: const Offset(0, 2)
                                    )
                                  ]
                                ),
                                child: Image.network(
                                  imageLink, 
                                  errorBuilder:
                                    ((context, error, stackTrace) {
                                    return Image.network(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                                    width: 64,
                                    );
                                  }),
                                ),
                              ),
                            );
                          }
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
    );
  }

}
