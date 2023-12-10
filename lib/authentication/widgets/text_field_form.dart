import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      this.hintText, this.prefixIconData, this.obscureText, this.onChanged,
      {super.key});

  final String hintText;
  final IconData prefixIconData;
  final bool obscureText;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: const Color(0xff3992C6),
        ),
        hintText: hintText,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xff3992C6)),
        ),
        contentPadding: const EdgeInsets.only(top: 15.0),
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
      style: GoogleFonts.inter(
        textStyle: const TextStyle(
          fontSize: 16,
        ),
      ),
      onChanged: onChanged,
      validator: (String? val) {
        if (val == null || val.isEmpty) {
          return "$hintText can't be empty!";
        }
        return null;
      },
      obscureText: obscureText,
    );
  }
}
