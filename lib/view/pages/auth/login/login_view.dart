import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_mortgage_app/controller/auth_controller/login_controller.dart';
import 'package:user_mortgage_app/view/widgets/text_field_custom.dart';

class LoginView extends StatelessWidget {
  final String menu;
  final bool useAppBar;

  const LoginView({super.key, required this.menu, this.useAppBar = true});

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);
    return Scaffold(
      appBar: useAppBar
          ? AppBar(
              title: Text(menu),
            )
          : null,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.lightGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Decorative shapes
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: -30,
            left: -30,
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.4),
                    blurRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Login form container
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFieldCustom(
                    textHint: "Email",
                    controller: loginController.emailController,
                  ),
                  const SizedBox(height: 16),
                  TextFieldCustom(
                    textHint: "Password",
                    controller: loginController.passController,
                    isPassword: true,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          final email = loginController.emailController.text;
                          final password = loginController.passController.text;

                          if (email.isNotEmpty) {
                            debugPrint("Email: $email \n Password: $password");
                            loginController.clearForm();
                            loginController.navigateToRegister(context);
                          } else {
                            debugPrint("Email is empty");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
