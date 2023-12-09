import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  List<String> item = ["a", "b", "c", "d", "e", "f"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("My Cart",
              style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 30,
                color: Color(0xff00134E),
              ))),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    color: Colors.blueGrey,
                    margin: EdgeInsets.all(5),
                  );
                },
              ),
            ),
            Container(
              height: 200,
              color: Colors.lightBlue,
              child: Row(
                children: [
                  
                ],
              ),
            )
          ],
        ),
      );
  }
}
