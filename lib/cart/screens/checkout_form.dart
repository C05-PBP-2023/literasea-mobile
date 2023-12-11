import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:literasea_mobile/cart/screens/cart.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CheckoutForm extends StatefulWidget {
  const CheckoutForm({super.key});

  @override
  State<CheckoutForm> createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  final _formKey = GlobalKey<FormState>();

  String _nama = "";
  String _alamat = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xff00134E)),
          title: Text("Checkout",
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
            SizedBox(
              height: 75,
            ),
            Container(
              width: 100,
              color: Colors.white,
              child: Text("Checkout Data"),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text("Nama Pembeli:")],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      cursorOpacityAnimates: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF0F0F0),
                          focusColor: Colors.white,
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _nama = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field must not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text("Alamat Kirim:")],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      cursorOpacityAnimates: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF0F0F0),
                          focusColor: Colors.white,
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _alamat = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field must not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 75,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Grand Total:"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Rp300,00"),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final response = await request.postJson(
                              "http://127.0.0.1:8000/cart/checkout-flutter/",
                              jsonEncode(<String, String>{
                                "nama": _nama,
                                "alamat": _alamat,
                              }));

                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Produk baru berhasil disimpan!"),
                            ));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartPage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  "Terdapat kesalahan, silakan coba lagi."),
                            ));
                          }
                        }
                      },
                      child: Text("Confirm"),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
