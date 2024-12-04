import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  void login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final email = emailController.text;
      final pass = passController.text;

      debugPrint("Email: $email");
    }
  }
}
