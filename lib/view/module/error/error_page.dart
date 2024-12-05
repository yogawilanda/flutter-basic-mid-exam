import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorPages extends StatelessWidget {
  const ErrorPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '😢',
              style: TextStyle(fontSize: 80),
            ),
            Text(
              'Error 404',
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Page Not Found',
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.w200),
            ),
          ],
        ),
      ),
    );
  }
}
