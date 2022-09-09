import 'package:flutter/material.dart';

class TextfieldInput extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final bool isPass;
  final TextInputType textInputType;

  TextfieldInput(
      {required this.hinttext,
      required this.controller,
      required this.isPass,
      required this.textInputType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      obscureText: isPass,
      controller: controller,
      decoration: InputDecoration(
          hintText: hinttext,
          filled: true,
          contentPadding: const EdgeInsets.all(8),
          border: OutlineInputBorder(
            borderSide: Divider.createBorderSide(context),
          )),
    );
  }
}
