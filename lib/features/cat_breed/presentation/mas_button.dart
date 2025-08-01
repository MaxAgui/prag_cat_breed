import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/models/breed.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/breed_detail_screen.dart';

class MasButton extends StatelessWidget {
  const MasButton({super.key, required this.breed});
  final Breed breed;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            padding: EdgeInsets.zero,
            child: Text(
              'Más...',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (_) => BreedDetailScreen(breed: breed),
                ),
              );
            },
          )
        : TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BreedDetailScreen(breed: breed),
                ),
              );
            },
            child: Text(
              'Más...',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          );
  }
}
