import 'package:flutter/material.dart';

class CatCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String origin;
  final int intelligence;

  const CatCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.origin,
    required this.intelligence,
  });

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
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
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
                image: imageUrl,
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
                  "País: $origin",
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  "Inteligencia: $intelligence",
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
