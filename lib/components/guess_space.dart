import 'package:flutter/material.dart';

class GuessSpace extends StatelessWidget {
  final double width;
  final String letter;
  const GuessSpace({super.key, required this.width, required this.letter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: width / 5,
        height: width / 5,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white54,
              width: 3.0,
            ),
          ),
        ),
        child: Center(
          child: Text(
            letter,
            style: TextStyle(color: Colors.white, fontSize: width / 2),
          ),
        ),
      ),
    );
  }
}
