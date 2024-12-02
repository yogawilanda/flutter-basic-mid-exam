import 'package:flutter/material.dart';
import 'package:flutter_mid_basic_exam/view/widgets/text_field_custom.dart';


class RegisterView extends StatelessWidget {
  final String menu;
  
  // input controller, buat nampung data dari form
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  RegisterView({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      // appBar: AppBar(title: Text("New Page: $menu")),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldCustom(textHint: "Email", controller: emailController),
            TextFieldCustom(textHint: "Username"),
            const SizedBox(height: 12),
            TextFieldCustom(
              textHint: "Password",
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
      // body: Center(
      //   child: Text("This is the new page for $menu"),
      // ),
    );
  }
}
