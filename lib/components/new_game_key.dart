import 'package:flutter/material.dart';

class NewGameKey extends StatelessWidget {
  final String value;
  final bool selected;
  final void Function()? ontap;

  const NewGameKey(
      {super.key,
      required this.value,
      this.selected = false,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        color: const Color.fromARGB(35, 75, 175, 80),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white54, width: 1.25),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: InkWell(
          onTap: ontap,
          child: const Center(
            child: Text(
              'New Game',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
