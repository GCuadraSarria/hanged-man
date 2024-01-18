import 'package:flutter/material.dart';

class LetterKey extends StatelessWidget {
  final String value;
  final void Function()? ontap;
  final bool gameFinished;

  const LetterKey(
      {super.key,
      required this.value,
      required this.ontap,
      this.gameFinished = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        color: !gameFinished ? Colors.grey[900] : Colors.grey[700],
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white54, width: 1.25),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: InkWell(
          onTap: ontap,
          child: Center(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
