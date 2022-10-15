import 'package:flutter/material.dart';

TextField reusableTextField(String label, IconData myicon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    decoration: InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide:  BorderSide(
          color: Color.fromARGB(255, 16, 3, 160),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.purple),
      ),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      prefixIcon: Icon(
        myicon,
        color: Colors.white,
      ),
    ),
  );
}
