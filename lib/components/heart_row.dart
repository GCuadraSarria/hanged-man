import 'package:flutter/material.dart';

class HeartRow extends StatelessWidget {
  final int totalHealth = 6;
  final int guesses;

  const HeartRow({super.key, required this.guesses});

  @override
  Widget build(BuildContext context) {
    int emptyHearts = guesses > 6 ? 6 : guesses;
    int fullHearts = totalHealth - emptyHearts;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
            fullHearts,
            (index) => const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 32.0,
            ),
          ) +
          List.generate(
            emptyHearts,
            (index) => const Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 32.0,
            ),
          ),
    );
  }
}
