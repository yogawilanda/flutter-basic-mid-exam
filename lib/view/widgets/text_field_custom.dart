import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  TextFieldCustom({
    super.key,
    this.textHint = 'No hint provided',
    this.controller,
    this.isPassword = false,
    this.maxLength,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String textHint;
  final bool isPassword;
  final int? maxLength;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    // Use the provided controller or create a new one if none is provided
    final TextEditingController effectiveController =
        controller ?? TextEditingController();

    return TextField(
      controller: effectiveController,
      obscureText: isPassword,
      maxLength: maxLength,
      onChanged: onChanged, // Pass the callback directly
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green, width: 2),
        ),
        hintText: textHint,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}