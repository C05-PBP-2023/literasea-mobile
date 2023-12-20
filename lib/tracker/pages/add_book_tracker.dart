import 'dart:convert';
import 'package:literasea_mobile/Katalog/models/product.dart';
import 'package:literasea_mobile/tracker/utils/fetch.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:literasea_mobile/tracker/models/book_tracker.dart';
import 'package:literasea_mobile/main.dart';
import 'package:google_fonts/google_fonts.dart';

class AddBookTracker extends StatefulWidget {
  const AddBookTracker({Key? key}) : super(key: key);

  @override
  State<AddBookTracker> createState() => _AddBookTrackerState();
}

class _AddBookTrackerState extends State<AddBookTracker> {
  List<Product> _books = [];
  final _formKey = GlobalKey<FormState>();
  String _book_id = "";
  String _last_page = "";
  String _user_id = UserInfo.data["id"];

  final _coBookId = TextEditingController();
  final _coLastPage = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    List<Product> books = await fetchBook();
    setState(() {
      _books = books;
    });
  }

  void clearInput() {
    _coBookId.clear();
    _coLastPage.clear();
    setState(() {
      _book_id = "";
      _last_page = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Reading History'),
        backgroundColor:
            const Color.fromRGBO(255, 255, 255, 1), // Set background color
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black, // Set background color
          ),
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add Reading History",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      // ====================================== BOOK TITLE ===================================
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          hintText: "Judul buku ...",
                          labelText: "Book Title",
                          filled: true,
                        ),
                        items: _books.map((Product book) {
                          return DropdownMenuItem<String>(
                            value: book.pk.toString(),
                            child: Text(book.fields.bookTitle),
                          );
                        }).toList(),
                        value: _book_id,
                        onChanged: (String? value) {
                          setState(() {
                            _book_id = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Book cannot be empty!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      // ====================================== LAST PAGE ===================================
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "0",
                          labelText: "Last Page",
                          filled: true,
                        ),
                        controller: _coLastPage,
                        onChanged: (String? value) {
                          setState(() {
                            _last_page = value!;
                          });
                        },
                        onSaved: (String? value) {
                          setState(() {
                            _last_page = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Last page cannot be empty!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                const Spacer(),
                // ====================================== BUTTON ===================================
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 30,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          _book_id != "" &&
                          _last_page != "") {
                        final response = await request.postJson(
                          "https://literasea.live/tracker/add/mobile/$_user_id",
                          jsonEncode({
                            "book_id": _book_id,
                            "last_page": _last_page,
                          }),
                        );
                        _showToast(context, true);
                        clearInput();
                      } else {
                        _showToast(context, false);
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showToast(BuildContext context, bool isValid) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: isValid ? Colors.green : Colors.red,
        content: Text(
          isValid
              ? "Reading history successfully saved"
              : "Form is not complete yet!",
        ),
        action: SnackBarAction(
          label: 'Close',
          textColor: Colors.white,
          onPressed: () {
            scaffold.hideCurrentSnackBar;
          },
        ),
      ),
    );
  }
}
