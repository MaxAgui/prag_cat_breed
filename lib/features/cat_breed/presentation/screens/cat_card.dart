import 'package:flutter/material.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/entities/breed.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/screens/mas_button.dart';

class CatCard extends StatelessWidget {
  const CatCard({super.key, required this.breed});
  final Breed breed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          spacing: 10,
          children: [
            // Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  breed.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MasButton(breed: breed),
              ],
            ),

            // Cat image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/loading_cat.gif',
                fadeOutDuration: Duration(milliseconds: 100),
                image: breed.image?.url ?? '',
                height: 180,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/sad_cat.png',
                    height: 180,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),

            // Origin & Intelligence
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "País: ${breed.origin}",
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  "Inteligencia: ${breed.intelligence}",
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
