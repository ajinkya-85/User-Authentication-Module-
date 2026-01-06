import 'package:flutter/material.dart';

// function to create a reusable text field widget
// acccepts label text, icon, password flag, and controller as parameters

TextField reusableTextField(
  String text,
  IconData icon,
  bool isPasswordType,
  TextEditingController controller, {
  int maxLines = 1,
}) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style: TextStyle(color: const Color.fromARGB(255, 13, 12, 12)),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: const Color.fromARGB(179, 0, 0, 0)),
      labelText: text,
      labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: const Color.fromARGB(255, 238, 233, 233),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
    maxLines: isPasswordType ? 1 : maxLines,
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : (maxLines > 1 ? TextInputType.multiline : TextInputType.emailAddress),
  );
}
