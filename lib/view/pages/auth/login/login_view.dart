import 'package:flutter/material.dart';
import 'package:flutter_mid_basic_exam/controller/login_controller.dart';
import 'package:flutter_mid_basic_exam/view/widgets/text_field_custom.dart';

import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  final String menu;

  const LoginView({super.key, required this.menu});


  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldCustom(
                textHint: "Email", controller: loginController.emailController),
            const SizedBox(height: 12),
            TextFieldCustom(
              textHint: "Password",
              controller: loginController.passController,
              isPassword: true,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // get the controller
                    final email = loginController.emailController.text;
                    final password = loginController.passController.text;

                    if (email.isNotEmpty) {
                      debugPrint("Email: $email \n Password: $password");
                    } else {
                      debugPrint("Email is empty");
                    }
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
