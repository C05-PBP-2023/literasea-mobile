// import 'package:flutter/material.dart';
// // TODO: Impor drawer yang sudah dibuat sebelumnya
// // import 'package:codashop/screens/menu.dart';
// import 'package:literasea_mobile/review/screens/review.dart';
// import 'dart:convert'; // Import for jsonEncode
// import 'package:provider/provider.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';

// class ShopFormPage extends StatefulWidget {
//     const ShopFormPage({super.key});

//     @override
//     State<ShopFormPage> createState() => _ShopFormPageState();
// }

// class _ShopFormPageState extends State<ShopFormPage> {
//     final _formKey = GlobalKey<FormState>();
//     String _name = "";
//     int _price = 0;
//     String _description = "";
//     int _amount = 0;
//     String _dateAdded = "";

//     @override
//     Widget build(BuildContext context) {
//       final request = context.watch<CookieRequest>();

//         return Scaffold(
//             appBar: AppBar(
//                 title: const Center(
//                 child: Text(
//                     'Form Tambah Produk',
//                 ),
//                 ),
//                 backgroundColor: Colors.indigo,
//                 foregroundColor: Colors.white,
//             ),
//             body: Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                             Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: TextFormField(
//                                 decoration: InputDecoration(
//                                 hintText: "Nama Produk",
//                                 labelText: "Nama Produk",
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(5.0),
//                                 ),
//                                 ),
//                                 onChanged: (String? value) {
//                                 setState(() {
//                                     _name = value!;
//                                 });
//                                 },
//                                 validator: (String? value) {
//                                 if (value == null || value.isEmpty) {
//                                     return "Nama tidak boleh kosong!";
//                                 }
//                                 return null;
//                                 },
//                             ),
//                             ),
//                             Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: TextFormField(
//                                 decoration: InputDecoration(
//                                 hintText: "Harga",
//                                 labelText: "Harga",
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(5.0),
//                                 ),
//                                 ),
//                                 // TODO: Tambahkan variabel yang sesuai
//                                 onChanged: (String? value) {
//                                 setState(() {
//                                     _price = int.parse(value!);
//                                 });
//                                 },
//                                 validator: (String? value) {
//                                 if (value == null || value.isEmpty) {
//                                     return "Harga tidak boleh kosong!";
//                                 }
//                                 if (int.tryParse(value) == null) {
//                                     return "Harga harus berupa angka!";
//                                 }
//                                 return null;
//                                 },
//                             ),
//                             ),
//                             Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: TextFormField(
//                                 decoration: InputDecoration(
//                                 hintText: "Banyak Item",
//                                 labelText: "Banyak Item",
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(5.0),
//                                 ),
//                                 ),
//                                 onChanged: (String? value) {
//                                 setState(() {
//                                     // TODO: Tambahkan variabel yang sesuai
//                                     _amount = int.parse(value!);
//                                 });
//                                 },
//                                 validator: (String? value) {
//                                 if (value == null || value.isEmpty) {
//                                     return "Banyak item tidak boleh kosong!";
//                                 }
//                                 if (int.tryParse(value) == null) {
//                                     return "Banyak item harus berupa angka!";
//                                 }
//                                 return null;
//                                 },
//                             ),
//                             ),
//                                                         Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: TextFormField(
//                                 decoration: InputDecoration(
//                                 hintText: "Deskripsi",
//                                 labelText: "Deskripsi",
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(5.0),
//                                 ),
//                                 ),
//                                 onChanged: (String? value) {
//                                 setState(() {
//                                     // TODO: Tambahkan variabel yang sesuai
//                                     _description = value!;
//                                 });
//                                 },
//                                 validator: (String? value) {
//                                 if (value == null || value.isEmpty) {
//                                     return "Deskripsi tidak boleh kosong!";
//                                 }
//                                 return null;
//                                 },
//                             ),
//                             ),
//                             Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: ElevatedButton(
//                                         style: ButtonStyle(
//                                             backgroundColor:
//                                                 MaterialStateProperty.all(Colors.indigo),
//                                         ),
//                                         onPressed: () async {
//                                           if (_formKey.currentState!.validate()) {
//                                               // Kirim ke Django dan tunggu respons
//                                               // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
//                                               final response = await request.postJson(
//                                               "http://127.0.0.1:8000/create-flutter/",
//                                               jsonEncode(<String, String>{
//                                                   'name': _name,
//                                                   'price': _price.toString(),
//                                                   'amount': _amount.toString(),
//                                                   'description': _description,
//                                                   'date_added':_dateAdded,
//                                               }));
//                                               if (response['status'] == 'success') {
//                                                   ScaffoldMessenger.of(context)
//                                                       .showSnackBar(const SnackBar(
//                                                   content: Text("Produk baru berhasil disimpan!"),
//                                                   ));
//                                                   Navigator.pushReplacement(
//                                                       context,
//                                                       MaterialPageRoute(builder: (context) => ReviewPage()), //sementara
//                                                   );
//                                               } else {
//                                                   ScaffoldMessenger.of(context)
//                                                       .showSnackBar(const SnackBar(
//                                                       content:
//                                                           Text("Terdapat kesalahan, silakan coba lagi."),
//                                                   ));
//                                               }
//                                           }
//                                       },
//                                         child: const Text(
//                                             "Save",
//                                             style: TextStyle(color: Colors.white),
//                                         ),
//                                     ),
//                                 ),
//                             ),
//                         ]
//                     )
//                 ),
//             ),
//         );
//     }
// }