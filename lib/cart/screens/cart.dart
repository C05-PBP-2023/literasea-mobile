import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literasea_mobile/cart/screens/checkout_form.dart';
import 'package:literasea_mobile/cart/screens/history.dart';
import 'package:literasea_mobile/cart/widgets/cart_card.dart';
import 'package:literasea_mobile/Katalog/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:literasea_mobile/main.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: Cart(),
//   ));
// }

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartState();
}

class _CartState extends State<CartPage> {
  void refreshCart() {
    setState(() {
      banyakBuku -= 1;
    });
  }

  //List<String> item = ["buku1", "bbuku2", "cbuku3", "dbuku1 buku4", "ebuku1", "fbuku1buku13"];
  int banyakBuku = 0;
  bool get = true;

  Future<List<Product>> fetchProduct() async {
    //var url = Uri.parse("http://127.0.0.1:8000/products/get_book/");
    var url = Uri.parse(
        "https://literasea.live/cart/get-cart-id/${UserInfo.data["id"]}");
    //var url = Uri.parse("http://127.0.0.1:8000/cart/get-history/");

    final response = await http.get(url);

    // var response = await http.get(
    //   url,
    //   headers: {
    //     "Content-Type": "application/json",
    //     },
    // );

    //print("Response:" + response.body);

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    //print(data);

    List<Product> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(Product.fromJson(d));
      }
    }

    if (get) {
      setState(() {
        banyakBuku = listProduct.length;
        get = false;
      });
    }

    return listProduct;
  }

  Widget _historySection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 12, 14, 12),
      height: 35,
      color: const Color(0xffddf3ff),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HistoryPage()));
            },
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                backgroundColor: const Color(0xff42aee8),
                elevation: 0,
                padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
                textStyle: const TextStyle(
                  color: Colors.white,
                )),
            child: Text(
              "Order History",
              style: GoogleFonts.inter(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffddf3ff),
      //backgroundColor: Colors.redAccent,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff00134E)),
        title: Text("My Cart",
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: Color(0xff00134E),
            ))),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xffddf3ff),
      ),
      body: Column(
        children: [
          // Container(
          //   margin: EdgeInsets.fromLTRB(0, 15, 70, 15),
          // height: 35,
          // color: Color(0xffddf3ff),
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     TextButton(
          //       onPressed: (){
          //         Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryPage()));
          //       },
          //       child: Text("History"),
          //     )
          //   ],
          // ),
          // ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: item.length,
          //     itemBuilder: (context, index) {
          //       return index != 0 ?
          //           CartCard(itemName: item[index], itemAuthor: item[index], itemYear: item[index],) :
          //           _historySection(context);
          //     },
          //   ),
          // ),
          Expanded(
            child: FutureBuilder(
              future: fetchProduct(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff3992c6),
                    ),
                  );
                } else {
                  if (snapshot.data.length == 0) {
                    return Center(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 12, 14, 12),
                            height: 35,
                            color: const Color(0xffddf3ff),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HistoryPage()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      backgroundColor: const Color(0xff42aee8),
                                      elevation: 0,
                                      padding: const EdgeInsets.fromLTRB(
                                          35, 8, 35, 8),
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                      )),
                                  child: Text(
                                    "Order History",
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 110),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.remove_shopping_cart_sharp,
                                  color: Colors.black.withOpacity(0.15),
                                  size: 250,
                                ),
                                const Text("Empty Cart"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    List<Product> data = snapshot.data!;

                    return ListView.builder(
                        itemCount: data.length + 1,
                        itemBuilder: (_, index) {
                          // String imageLink = data[index].fields.image;
                          // String substring = imageLink.substring(14);

                          //print(substring);
                          // return CartCard(
                          //       pk: data[index].pk,
                          //       itemName: data[index].fields.bookTitle,
                          //       itemAuthor: data[index].fields.bookAuthor,
                          //       itemYear: "${data[index].fields.yearOfPublication}",
                          //       itemImage: data[index].fields.image,
                          //       refreshCart: refreshCart,
                          //     );
                          // }
                          return index != 0
                              ? CartCard(
                                  pk: data[index - 1].pk,
                                  itemName: data[index - 1].fields.bookTitle,
                                  itemAuthor: data[index - 1].fields.bookAuthor,
                                  itemYear:
                                      "${data[index - 1].fields.yearOfPublication}",
                                  itemImage: data[index - 1].fields.image,
                                  refreshCart: refreshCart,
                                )
                              : _historySection(context);
                        });
                  }
                }
              },
            ),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 15),
              height: 190,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 0.5,
                  color: const Color(0xffababab),
                ),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Books ordered",
                          style: GoogleFonts.inter(
                              color: const Color(0xff00134e),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "$banyakBuku",
                          style: GoogleFonts.inter(
                              color: const Color(0xff00134e),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price per book",
                          style: GoogleFonts.inter(
                              color: const Color(0xff00134e),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "100",
                          style: GoogleFonts.inter(
                              color: const Color(0xff00134e),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: GoogleFonts.inter(
                              color: const Color(0xff00134e),
                              fontSize: 19,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Rp${banyakBuku * 100},00",
                          style: GoogleFonts.inter(
                              color: const Color(0xff00134e),
                              fontSize: 19,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (banyakBuku == 0) return;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CheckoutForm(total: banyakBuku * 100)));
                      },
                      style: banyakBuku == 0
                          ? ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              shape: const StadiumBorder(),
                              elevation: 0,
                              padding:
                                  const EdgeInsets.fromLTRB(80, 15, 80, 15),
                            )
                          : ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: const Color(0xff3894c8),
                              elevation: 0,
                              padding:
                                  const EdgeInsets.fromLTRB(80, 15, 80, 15),
                            ),
                      child: Text(
                        "Checkout Books",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
