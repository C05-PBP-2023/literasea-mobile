import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  Future<void> _submitBook() async {
    if (_formKey.currentState!.validate()) {
      var url =
          Uri.parse('https://literasea.live/products/create_book_flutter/');
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'ISBN': _isbnController.text,
          'BookTitle': _titleController.text,
          'BookAuthor': _authorController.text,
          'Year_Of_Publication': _yearController.text,
          'Publisher': _publisherController.text,
          'Image': _imageController.text,
        }),
      );
      if (context.mounted) {
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Book added successfully!')));
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to add book')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: Text('Add New Book', style: GoogleFonts.inter(color: Colors.blue[800], fontWeight: FontWeight.bold)),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFormField(_isbnController, 'ISBN'),
                _buildTextFormField(_titleController, 'Book Title'),
                _buildTextFormField(_authorController, 'Author'),
                _buildTextFormField(_yearController, 'Year of Publication',
                    isNumber: true),
                _buildTextFormField(_publisherController, 'Publisher'),
                _buildTextFormField(_imageController, 'Image URL'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitBook,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3992C6),
                  ),
                  child: Text(
                    'Add Book',
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff3992C6),
          ),
        ),
      ),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
