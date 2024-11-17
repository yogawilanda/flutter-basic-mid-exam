import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  TextFieldCustom({
    super.key,
    required this.textHint,
    this.controller,
    this.isPassword = false,
  });
  TextEditingController? controller;
  String textHint;
  bool isPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller ?? TextEditingController(),
      obscureText: isPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
        hintText: textHint,
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}
