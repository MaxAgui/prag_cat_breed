import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/models/breed.dart'
    hide Image;

class BreedDetailScreen extends StatelessWidget {
  const BreedDetailScreen({super.key, required this.breed});
  final Breed breed;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(middle: Text(breed.name)),
            child: ContentDetail(breed: breed),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(breed.name),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: ContentDetail(breed: breed),
          );
  }
}

class ContentDetail extends StatelessWidget {
  const ContentDetail({super.key, required this.breed});

  final Breed breed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Imagen del gato
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/loading_cat.gif',
            image: breed.image?.url ?? '',
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/sad_cat.png',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              );
            },
          ),
        ),

        // Scroll solo para el contenido
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Descripción
                Text(
                  'Descripción:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  breed.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),

                // Información general
                Text(
                  'Información general:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Origen: ${breed.origin}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  'Esperanza de vida: ${breed.lifeSpan} años',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  'Peso: ${breed.weight.metric} kg / ${breed.weight.imperial} lbs',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),

                // Características
                Text(
                  'Características:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 8),
                RatingRow(title: 'Inteligencia', level: breed.intelligence),
                RatingRow(title: 'Adaptabilidad', level: breed.adaptability),
                RatingRow(title: 'Nivel de energía', level: breed.energyLevel),
                RatingRow(title: 'Afecto', level: breed.affectionLevel),
                RatingRow(title: 'Con niños', level: breed.childFriendly),
                RatingRow(title: 'Con perros', level: breed.dogFriendly),
                RatingRow(
                  title: 'Con otros gatos',
                  level: breed.catFriendly ?? 0,
                ),
                RatingRow(title: 'Vocalización', level: breed.vocalisation),
                RatingRow(title: 'Nivel de muda', level: breed.sheddingLevel),
                RatingRow(
                  title: 'Necesidades sociales',
                  level: breed.socialNeeds,
                ),
                RatingRow(
                  title: 'Salud general',
                  level: 5 - breed.healthIssues,
                ),
                RatingRow(title: 'Cuidados (grooming)', level: breed.grooming),
                const SizedBox(height: 16),

                // Extras
                Text('Otros:', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (breed.hypoallergenic == 1)
                      const ChipPlatform(text: 'Hipoalergénico'),
                    if (breed.rare == 1) const ChipPlatform(text: 'Raza rara'),
                    if (breed.hairless == 1)
                      const ChipPlatform(text: 'Sin pelo'),
                    if (breed.shortLegs == 1)
                      const ChipPlatform(text: 'Patas cortas'),
                    if (breed.rex == 1) const ChipPlatform(text: 'Pelaje rex'),
                    if (breed.natural == 1)
                      const ChipPlatform(text: 'Raza natural'),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChipPlatform extends StatelessWidget {
  const ChipPlatform({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton.filled(
            padding: EdgeInsets.symmetric(horizontal: 12),
            onPressed: () {},
            child: Text(text),
          )
        : Chip(label: Text(text));
  }
}

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
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
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
