import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literasea_mobile/Katalog/models/product.dart';
import 'package:literasea_mobile/cart/models/historyModels.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:literasea_mobile/cart/widgets/history_card.dart';
import 'package:literasea_mobile/main.dart';

class HistoryPage extends StatefulWidget {

  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  Future<List<History>> fetchHistory() async {
    var url = Uri.parse("https://literasea.live/cart/get-history/");
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<History> listHistory = [];
    for (var d in data) {
        if (d != null) {
          //listHistory.add(History.fromJson(d));
          History history = History.fromJson(d);

          if(history.fields.user == UserInfo.data["id"]){
            listHistory.add(History.fromJson(d));
          }
        }
    }
    return listHistory;
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xff00134E)
          ),
          title: Text("History",
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
      body: FutureBuilder(
        future: fetchHistory(), 
        builder: (context, AsyncSnapshot snapshot){
          if(snapshot.data == null){
            return const Center(child: CircularProgressIndicator());
          }else{
            if (!snapshot.hasData) {
              return const Center(
                child: Text("No History"),
              );
            } else {
              List<History> data = snapshot.data!;

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, index){

                  return HistoryCard(
                    namaPembeli: data[index].fields.nama, 
                    alamatPembeli: data[index].fields.alamat, 
                    tanggal: "${data[index].fields.tanggal}", 
                    //listBuku: data[index].fields.buku,
                    listBuku: data[index].fields.buku,
                  );
                },
              );
            }
          }
        }
      )
    );
  }
}