import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literasea_mobile/screens/checkout_form.dart';
import 'package:literasea_mobile/widgets/cart_card.dart';

void main() {
  runApp(const MaterialApp(
    home: Cart(),
  ));
}

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  static const color = Color(0xffE5f5ff);

  List<String> item = ["buku1", "bbuku2", "cbuku3", "dbuku1 buku4", "ebuku1", "fbuku1buku13"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
            Expanded(
              child: ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  return CartCard(itemName: item[index]);
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
                        Text("${item.length}"),
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
                        Text("${item.length*100}"),
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
