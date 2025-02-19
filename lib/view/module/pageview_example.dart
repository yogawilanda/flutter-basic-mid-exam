import 'package:flutter/material.dart';

class PageviewExample extends StatelessWidget {
  const PageviewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Container(
              color: Colors.red,
              child: Center(
                  child: Text(
                "Pageview Example 1",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ))),
          Container(
              color: Colors.blue,
              child: Center(
                  child: Text(
                "Pageview Example 2",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ))),
          Container(
              color: Colors.green,
              child: Center(
                  child: Text(
                "Page Example 3",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ))),
        ],
      ),
    );
  }
}
