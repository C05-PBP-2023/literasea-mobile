import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literasea_mobile/cart/screens/cart.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CheckoutForm extends StatefulWidget {
  final int total;

  const CheckoutForm({super.key, required this.total});

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
          iconTheme: const IconThemeData(color: Color(0xff00134E)),
          title: Text("Checkout",
              style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Color(0xff00134E),
              ))),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 75,
              ),
              Container(
                width: 132,
                color: Colors.white,
                child: Text(
                  "CHECKOUT DATA",
                  style: GoogleFonts.inter(
                    color: const Color(0xff00134e),
                    fontSize: 15,
                    fontWeight: FontWeight.w800
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text(
                          "Nama Pembeli:",
                          style: GoogleFonts.inter(
                    color: const Color(0xff00134e),
                    fontSize: 13,
                    fontWeight: FontWeight.w500
                  ),
                          )],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        cursorOpacityAnimates: true,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF0F0F0),
                            focusColor: Colors.white,
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
                        style: const TextStyle(
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
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text(
                          "Alamat Kirim:",
                          style: GoogleFonts.inter(
                    color: const Color(0xff00134e),
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
                  
                          )],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        cursorOpacityAnimates: true,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF0F0F0),
                            focusColor: Colors.white,
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
                        style: const TextStyle(
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
                      const SizedBox(
                        height: 75,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            
                            "Grand Total:",
        
                            style: GoogleFonts.inter(
                    color: const Color(0xff00134e),
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  
                            
                            ),
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Rp${widget.total},00",
                            style: GoogleFonts.inter(
                    color: const Color(0xff00134e),
                    fontSize: 24,
                    fontWeight: FontWeight.w700
                  
                            
                            ),
                            
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: const Color(0xff3894c8),
                                elevation: 0,
                                padding: const EdgeInsets.fromLTRB(140, 20, 140, 20),
                              ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final response = await request.postJson(
                                "https://literasea.live/cart/checkout-flutter/",
                                jsonEncode(<String, String>{
                                  "nama": _nama,
                                  "alamat": _alamat,
                                }));
                            if (context.mounted) {
                              if (response['status'] == 'success') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Checkout berhasil!"),
                                ));
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CartPage()),
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      "Terdapat kesalahan, silakan coba lagi."),
                                ));
                              }
                            }
                          }
                        },
                        child: const Text("Confirm"),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
