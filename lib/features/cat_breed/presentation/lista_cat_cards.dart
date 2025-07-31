import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prag_cat_breed/features/cat_breed/application/providers.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/cat_card.dart';

class ListaCatCards extends ConsumerStatefulWidget {
  const ListaCatCards({super.key});

  @override
  ConsumerState<ListaCatCards> createState() => _ListaCatCardsState();
}

class _ListaCatCardsState extends ConsumerState<ListaCatCards> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final scrollPosition = _scrollController.position;
      final nearEnd =
          scrollPosition.pixels >= scrollPosition.maxScrollExtent - 200;

      if (nearEnd) {
        ref.read(catBreedsPaginatedProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catBreedsAsync = ref.watch(catBreedsPaginatedProvider);

    return catBreedsAsync.when(
      data: (breeds) {
        return ListView.builder(
          controller: _scrollController,
          itemCount: breeds.length + 1,
          itemBuilder: (context, index) {
            if (index < breeds.length) {
              final breed = breeds[index];
              return CatCard(
                name: breed.name,
                imageUrl: breed.image.url,
                origin: breed.origin,
                intelligence: breed.intelligence,
              );
            } else {
              // loader final
              return const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}