import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literasea_mobile/forum/models/question.dart';
import 'package:literasea_mobile/main.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AnswerForm extends StatefulWidget {
  const AnswerForm(this.question, {super.key});

  final Question question;

  @override
  State<AnswerForm> createState() => _AnswerFormState();
}

class _AnswerFormState extends State<AnswerForm> {
  final _formKey = GlobalKey<FormState>();
  String _answer = "";
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
              widget.question.answered ? "See Answer" : "Answer Question",
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
                  widget.question.image,
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
                        widget.question.bookTitle,
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
                        widget.question.bookAuthor,
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
            Text(
              widget.question.title == ""
                  ? "(No title)"
                  : widget.question.title,
              style: GoogleFonts.inter(
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Asked by ${widget.question.fullName}",
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.question.question == ""
                  ? "(Empty question)"
                  : widget.question.question,
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  height: 1.5,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 16),
            !_isLoading
                ? (!widget.question.answered)
                    ? Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 10,
                              decoration: InputDecoration(
                                hintText: "Write your answer here...",
                                filled: true,
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xff3992C6)),
                                ),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16.0),
                                errorStyle: GoogleFonts.inter(
                                  textStyle: const TextStyle(fontSize: 11),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              validator: (String? val) {
                                if (val == null || val.isEmpty) {
                                  return "Answer can't be empty!";
                                }
                                return null;
                              },
                              onChanged: (val) {
                                setState(() {
                                  _answer = val;
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
                                  String answer = _answer;
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final response = await request.postJson(
                                    "https://literasea.live/forum/add-answer-mobile/",
                                    jsonEncode(<String, dynamic>{
                                      'answer': answer,
                                      'question_id': widget.question.id,
                                      'user_id': UserInfo.data["id"],
                                    }),
                                  );
                                  await Future.delayed(
                                      const Duration(milliseconds: 1), () {
                                    if (response['status'] == true) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text("Your answer has been added!"),
                                      ));
                                      navigator.pop();
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text(
                                              'Adding answer failed'),
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
                                "Answer",
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
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              "Answered by ${widget.question.userAnswer}:",
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              widget.question.answer,
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
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
