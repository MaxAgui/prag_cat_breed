import 'package:flutter/material.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/models/breed.dart'
    hide Image;
import 'package:prag_cat_breed/features/cat_breed/presentation/breed_detail_screen.dart';

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
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BreedDetailScreen(breed: breed),
                      ),
                    );
                  },
                  child: const Text(
                    'Más...',
                    style: TextStyle(color: Color(0xFF2F81F7)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

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
            const SizedBox(height: 12),

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
