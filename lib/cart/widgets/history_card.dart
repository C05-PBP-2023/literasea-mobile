import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literasea_mobile/Katalog/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryCard extends StatefulWidget {
  final String namaPembeli;
  final String alamatPembeli;
  final String tanggal;
  final List<int> listBuku;

  const HistoryCard(
      {super.key,
      required this.namaPembeli,
      required this.alamatPembeli,
      required this.tanggal,
      required this.listBuku});

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

    getBook().then((value) {
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
    double heightFactor = widget.listBuku.length.toDouble();

    return Container(
      height: 150 + 60*heightFactor,
      margin: const EdgeInsets.fromLTRB(80, 12, 80, 12),
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      decoration: BoxDecoration(
        color: Color(0xff54a5d4),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ORDER FINISHED",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
            height: 8,
          ),
              Text(widget.namaPembeli,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ADDRESS",
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              
              Text(widget.alamatPembeli,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 0.8,
            width: 150,
            color: Colors.white,
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("BOOKS ORDERED",
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
            height: 4,
          ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.listBuku.map((buku) {
                  String title = "";

                  if (a.isNotEmpty) {
                    for (Product p in a) {
                      if (p.pk == buku) {
                        title = p.fields.bookTitle;
                      }
                    }
                  }

                  return Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.bookmark,
                          size: 18,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(
                            "$title",
                            style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w300,),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
