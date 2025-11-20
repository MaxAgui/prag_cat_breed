import 'package:flutter/material.dart';

class RatingRow extends StatelessWidget {
  final String title;
  final int level;

  const RatingRow({super.key, required this.title, required this.level});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < level ? Icons.star : Icons.star_border,
                size: 18,
                color: Colors.amber,
              );
            }),
          ),
        ],
      ),
    );
  }
}