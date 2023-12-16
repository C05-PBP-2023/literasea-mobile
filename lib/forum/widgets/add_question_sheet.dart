import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literasea_mobile/Katalog/models/product.dart';
import 'package:literasea_mobile/main.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AddQuestionForm extends StatefulWidget {
  const AddQuestionForm(this.product, {super.key});

  final Product product;

  @override
  State<AddQuestionForm> createState() => _AddQuestionFormState();
}

class _AddQuestionFormState extends State<AddQuestionForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _question = "";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 4,
            left: 24,
            right: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(32),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add a Question",
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.product.fields.image,
                  fit: BoxFit.cover,
                  width: 64,
                  errorBuilder: ((context, error, stackTrace) {
                    return Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                      width: 64,
                    );
                  }),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Book Title",
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.product.fields.bookTitle,
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Book Author",
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.product.fields.bookAuthor,
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            !_isLoading
                ? Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: "Question Title",
                            filled: true,
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xff3992C6)),
                            ),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16.0),
                            errorStyle: GoogleFonts.inter(
                              textStyle: const TextStyle(fontSize: 11),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          validator: (String? val) {
                            if (val == null || val.isEmpty) {
                              return "Title can't be empty!";
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              _title = val;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          decoration: InputDecoration(
                            hintText: "Write your question here...",
                            filled: true,
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xff3992C6)),
                            ),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16.0),
                            errorStyle: GoogleFonts.inter(
                              textStyle: const TextStyle(fontSize: 11),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          validator: (String? val) {
                            if (val == null || val.isEmpty) {
                              return "Question can't be empty!";
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              _question = val;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        MaterialButton(
                          elevation: 0.0,
                          color: const Color(0xff3992C6),
                          height: 48,
                          minWidth: double.infinity,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              final navigator = Navigator.of(context);
                              String title = _title;
                              String question = _question;
                              setState(() {
                                _isLoading = true;
                              });
                              final response = await request.postJson(
                                "https://literasea.live/forum/add-question-mobile/",
                                jsonEncode(<String, dynamic>{
                                  'title': title,
                                  'question': question,
                                  'user_id': UserInfo.data["id"],
                                  'book_id': widget.product.pk,
                                }),
                              );
                              await Future.delayed(
                                  const Duration(milliseconds: 1), () {
                                if (response['status'] == true) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(response["message"]),
                                  ));
                                  int count = 0;
                                  navigator.popUntil((_) => count++ >= 2);
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title:
                                          const Text('Adding question failed'),
                                      content: Text(response['message']),
                                      actions: [
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            navigator.pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              });
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Add Question",
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
