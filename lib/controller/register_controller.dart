import 'package:flutter/material.dart';

class RegisterController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void register(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Navigator.pop(context);
      Navigator.push(context, 
        MaterialPageRoute(builder: (context) => const Scaffold(
          body: Center(
            child: Text('Register Success'),
          ),
        ))
      );
    }
  }
}