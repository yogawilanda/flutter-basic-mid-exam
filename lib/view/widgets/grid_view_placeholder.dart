// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class GridViewPlaceholder extends StatelessWidget {
  const GridViewPlaceholder({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      // grid view with 2 columns
      margin: const EdgeInsets.only(top: 24, right: 24, bottom: 24),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                "Item $index",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
