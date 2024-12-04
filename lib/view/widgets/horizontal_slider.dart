// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HorizontalSlider extends StatelessWidget {
  const HorizontalSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
  
        // borderRadius: BorderRadius.circular(12),
      ),
      height: MediaQuery.of(context).size.height * 0.12,
      child: ListView.builder(  
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              var className = runtimeType.toString();
              debugPrint("$className: Item $index clicked");
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.height * 0.03,
                    child: Center(),
                  ),
                  Text(
                    "Item $index",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
