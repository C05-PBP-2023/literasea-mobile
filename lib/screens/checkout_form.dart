import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _formKey = GlobalKey<FormState>();

class CheckoutForm extends StatelessWidget {
  const CheckoutForm({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xff00134E)
          ),
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
                    children: [
                      Text("Nama Pembeli:")
                    ],
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
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0)
                    ),
                    style: TextStyle(
                      fontSize: 14,
                    ),
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
                    children: [
                      Text("Alamat Kirim:")
                    ],
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
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0)
                    ),
                    style: TextStyle(
                      fontSize: 14,
                    ),
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
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        
                      }
                    }, 
                    child: Text("Confirm"),
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}