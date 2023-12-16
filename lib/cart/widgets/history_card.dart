import 'package:flutter/material.dart';
import 'package:literasea_mobile/Katalog/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryCard extends StatefulWidget {
  final String namaPembeli;
  final String alamatPembeli;
  final String tanggal;
  final List<int> listBuku;

  const HistoryCard({super.key, required this.namaPembeli, required this.alamatPembeli, 
  required this.tanggal, required this.listBuku});

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {

  List<Product> a = [];
  String b = "aa";

  Future<List<Product>> fetchBook() async {
    var url = Uri.parse("https://literasea.live/products/get_book/");
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Product> futureBuku = [];

    for (var d in data) {
        if (d != null) {
          futureBuku.add(Product.fromJson(d));
        }
    }
    
    return futureBuku;
  }

  getBook() async {
    List<Product> listBuku = await fetchBook();

    return listBuku;
  }

  @override
  void initState() {

    super.initState();

    getBook().then((value){
      
      setState(() {
        a = value;
        // for (Product p in value) {
        //   //print(p.fields.bookTitle);
        //   if (p.pk == 2) {
        //     b = p.fields.bookTitle;
        //   }
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 400,
      margin: const EdgeInsets.fromLTRB(80, 12, 80, 12),
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      decoration: BoxDecoration(
        color: Color(0xff3894c8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ORDER FINISHED"),
                  Text(widget.namaPembeli),
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Address"),
                  Text(widget.alamatPembeli),
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("BOOKS ORDERED"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.listBuku.map((buku) {
                      String title = "";

                      if(a.length != 0){
                        for (Product p in a) {
                          if (p.pk == buku) {
                            title = p.fields.bookTitle;
                          }
                        }
                      }

                      return Text(
                        "${title}",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.clip,
                      );
                    }).toList(),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}