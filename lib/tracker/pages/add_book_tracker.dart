import 'dart:convert';
import 'package:literasea_mobile/tracker/models/book.dart';
import 'package:literasea_mobile/tracker/utils/fetch.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:literasea_mobile/tracker/models/book_tracker.dart';
import 'package:literasea_mobile/main.dart';

class AddBookTracker extends StatefulWidget {
  const AddBookTracker({Key? key}) : super(key: key);

  @override
  State<AddBookTracker> createState() => _AddBookTrackerState();
}

class _AddBookTrackerState extends State<AddBookTracker> {
  List<Book> _books = [];
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
    List<Book> books = await fetchBook();
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
      ),
      // drawer: BookTrackerDrawer(context),
      body: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.greenAccent, Colors.blueGrey],
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
          padding: const EdgeInsets.only(
            right: 20.0,
            left: 20.0,
            top: 35.0,
            bottom: 40.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
            ),
            padding: const EdgeInsets.only(
              right: 30.0,
              left: 30.0,
              top: 40.0,
              bottom: 30.0,
            ),
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
                          color: Colors.green[900],
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
                          // prefixIcon: Icon(Icons.abc),
                        ),
                        items: _books.map((Book book) {
                          return DropdownMenuItem<String>(
                            value: book.id.toString(),
                            child: Text(book.book_title),
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
                          // prefixIcon: Icon(Icons.description)),
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
                      backgroundColor: MaterialStateProperty.all(Colors.green),
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
                        color: Colors.white,
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
