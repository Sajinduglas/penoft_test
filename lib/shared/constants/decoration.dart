import 'package:flutter/material.dart';


class AppDecoration {
  static InputDecoration fieldDecoration(
    BuildContext context,
  ) {
    return InputDecoration(
      filled: true,
      fillColor: Color(0xFFFFFFFF),
      hintStyle: const TextStyle(fontSize: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color:Color(0xFFCBD5E1) ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xFF0F172A)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color:Color(0xFFCBD5E1) ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    );
  }
}