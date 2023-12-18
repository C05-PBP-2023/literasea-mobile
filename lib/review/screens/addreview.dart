import 'package:flutter/material.dart';
import 'package:literasea_mobile/review/screens/review.dart';
import 'package:literasea_mobile/main.dart';
import 'dart:convert'; // Import for jsonEncode
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:literasea_mobile/Katalog/models/product.dart';



class ReviewFormPage extends StatefulWidget {
  final Product product;

  const ReviewFormPage({required this.product, Key? key}) : super(key: key);

  @override
  State<ReviewFormPage> createState() => _ShopFormPageState();
}

class _ShopFormPageState extends State<ReviewFormPage> {
  final _formKey = GlobalKey<FormState>();
  int? _rating; // Use int? to allow null, indicating no selection
  String _reviewMessage = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Review Form",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FractionallySizedBox(
                          widthFactor: 0.7,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0), // Set the border radius
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: _rating,
                                onChanged: (int? value) {
                                  setState(() {
                                    _rating = value;
                                  });
                                },
                                hint: Text("Rate (1-5)"), // Similar to hintText
                                items: List.generate(
                                  5,
                                  (index) => DropdownMenuItem<int>(
                                    value: index + 1,
                                    child: Text((index + 1).toString()),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FractionallySizedBox(
                          widthFactor: 0.7, // Adjust the width factor as needed
                          child: TextFormField(
                            decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.description,
                              size: 18,
                              color: Color(0xff3992C6),
                            ),
                              hintText: "Your review about this book",
                              labelText: "Review",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _reviewMessage = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Deskripsi tidak boleh kosong!";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final response = await request.postJson(
                                  "https://literasea.live/review/add-review-flutter/",
                                  jsonEncode(<String, String>{
                                    'username': UserInfo.data["username"],
                                    'rating': _rating.toString(),
                                    'review_message': _reviewMessage,
                                    'id':widget.product.pk.toString(),
                                  }),
                                );
                                if (response['status'] == 'success') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Your review has been published!"),
                                      backgroundColor: Color(0xFF146C94),
                                    ),
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => ReviewPage()),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Terdapat kesalahan, silakan coba lagi."),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
