import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literasea_mobile/cart/screens/checkout_form.dart';
import 'package:literasea_mobile/cart/screens/history.dart';
import 'package:literasea_mobile/cart/widgets/cart_card.dart';
import 'package:literasea_mobile/cart/models/product.dart';
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
      
    });
  }

  //List<String> item = ["buku1", "bbuku2", "cbuku3", "dbuku1 buku4", "ebuku1", "fbuku1buku13"];
  int banyakBuku = 0;
  bool get = true;

  Future<List<Product>> fetchProduct() async {
    //var url = Uri.parse("http://127.0.0.1:8000/products/get_book/");
    var url = Uri.parse("https://literasea.live/cart/get-cart-id/${UserInfo.data["id"]}");
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

    Widget _historySection(BuildContext context){
    return Container(
            margin: EdgeInsets.fromLTRB(0, 15, 70, 15),
            height: 50,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryPage()));
                  },
                  child: Text("History"),
                )
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xff00134E)
          ),
          title: Text("My Cart",
              style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 25,
                color: Color(0xff00134E),
              ))),
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 15, 70, 15),
            height: 50,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryPage()));
                  },
                  child: Text("History"),
                )
              ],
            ),
            ),
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
                builder: (context, AsyncSnapshot snapshot){
                  if(snapshot.data == null){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if(snapshot.data.length == 0){
                      return const Center(
                        child:
                          Text("Empty Cart"),
                      );
                    } else {

                      List<Product> data = snapshot.data!;
                      
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (_, index){
                          // String imageLink = data[index].fields.image;
                          // String substring = imageLink.substring(14);
                  
                            //print(substring);
                          return CartCard(
                                pk: data[index].pk,
                                itemName: data[index].fields.bookTitle, 
                                itemAuthor: data[index].fields.bookAuthor, 
                                itemYear: "${data[index].fields.yearOfPublication}",
                                itemImage: data[index].fields.image,
                                refreshCart: refreshCart,
                              );
                          }
                          // return index != 0 ? 
                          //     CartCard(
                          //         pk: data[index-1].pk,
                          //         itemName: data[index-1].fields.bookTitle, 
                          //         itemAuthor: data[index-1].fields.bookAuthor, 
                          //         itemYear: "${data[index-1].fields.yearOfPublication}",
                          //         itemImage: data[index-1].fields.image,
                          //         refreshCart: refreshCart,
                          //       ) : 
                          //     _historySection(context);
                      );
                    }
                  }
                },
              ),
            ),
            Container(
              height: 130,
              color: Colors.lightBlue,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Books ordered"),
                        Text("${banyakBuku}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Price per book"),
                        Text("100"),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total"),
                        Text("${banyakBuku}"),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(banyakBuku == 0) return;
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CheckoutForm(total: banyakBuku*100)));
                      }, 
                      style: banyakBuku == 0 ? ElevatedButton.styleFrom(backgroundColor: Colors.grey) :
                              ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      child: Text("Checkout Books"),
                    )
                  ],
                ),
              )
            )
          ],
        ),
      );
  }
}
