import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final String namaPembeli;
  final String alamatPembeli;
  final String tanggal;
  final List<int> listBuku;

  const HistoryCard({super.key, required this.namaPembeli, required this.alamatPembeli, 
  required this.tanggal, required this.listBuku});

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
                  Text(namaPembeli),
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
                  Text(alamatPembeli),
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
                    children: listBuku.map((buku) {
                      return Text("buku ${1}");
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