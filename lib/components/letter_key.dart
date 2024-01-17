import 'package:flutter/material.dart';

class LetterKey extends StatelessWidget {
  final String value;
  final bool selected;
  final void Function()? ontap;

  const LetterKey(
      {super.key,
      required this.value,
      this.selected = false,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        color: Colors.grey[900],
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
