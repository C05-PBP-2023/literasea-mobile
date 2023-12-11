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
  //List<String> item = ["buku1", "bbuku2", "cbuku3", "dbuku1 buku4", "ebuku1", "fbuku1buku13"];
  int banyakBuku = 0;

  Future<List<Product>> fetchProduct() async {
    //var url = Uri.parse("http://127.0.0.1:8000/products/get_book/");
    var url = Uri.parse("http://127.0.0.1:8000/cart/get-cart-id/${UserInfo.data["id"]}");
    //var url = Uri.parse("http://127.0.0.1:8000/cart/get-history/");

    final response = await http.get(url);

    // var response = await http.get(
    //   url,
    //   headers: {
    //     "Content-Type": "application/json",
    //     },
    // );
    

    // var response = await http.post(
    //   url,
    //   headers: {
    //     "Content-Type": "application/json",
    //   },
    //   body: jsonEncode({
    //     "username": "ethan2",
    //     "password": "plsletme1n"
    //   })
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
                    if(!snapshot.hasData){
                      return const Column(
                        children: [
                          Text("Empty Cart")
                        ],
                      );
                    } else {

                      List<Product> data = snapshot.data!;
                      banyakBuku = data.length;
                      
                      return ListView.builder(
                        itemCount: data.length+1,
                        itemBuilder: (_, index){
                          return index != 0 ? 
                              CartCard(
                                  itemName: data[index-1].fields.bookTitle, 
                                  itemAuthor: data[index-1].fields.bookAuthor, 
                                  itemYear: "${data[index-1].fields.yearOfPublication}",
                                  itemImage: data[index-1].fields.image,
                                ) : 
                              _historySection(context);
                        },
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckoutForm()));
                      }, 
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
