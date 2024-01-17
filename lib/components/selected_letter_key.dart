import 'package:flutter/material.dart';

class SelectedLetterKey extends StatelessWidget {
  final String value;
  final bool correct;
  const SelectedLetterKey(
      {super.key, required this.value, required this.correct});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        color: correct ? const Color.fromARGB(123, 75, 175, 80) : Colors.grey[700],
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white54, width: 1.25),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
