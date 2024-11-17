import 'package:flutter/material.dart';

class Leap extends StatelessWidget {
  final Widget page;
  final String? title;

  const Leap({Key? key, required this.page, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => page,
                settings: RouteSettings(name: title),
              ),
            );
          },
          child: const Text('Navigate'), // Replace with your desired child widget
        );
      },
    );
  }
}