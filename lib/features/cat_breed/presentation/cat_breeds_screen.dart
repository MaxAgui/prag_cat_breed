import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prag_cat_breed/features/cat_breed/application/providers.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/cat_card.dart';

class CatBreedsScreen extends StatelessWidget {
  const CatBreedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catbreeds'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Search bar
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Buscar raza en inglés...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Example Card List
            Expanded(child: ListaCatCards()),
          ],
        ),
      ),
    );
  }
}

class ListaCatCards extends ConsumerWidget {
  const ListaCatCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catBreedsAsync = ref.watch(catBreedsPaginatedProvider);

    return catBreedsAsync.when(
      data: (catBreeds) {
        return ListView.builder(
          itemCount: catBreeds.length,
          itemBuilder: (context, index) {
            final breed = catBreeds[index];
            return CatCard(
              name: breed.name,
              imageUrl: breed.image.url,
              origin: breed.origin,
              intelligence: breed.intelligence,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, __) => Center(child: Text('Hubo un error.')),
    );
  }
}
