import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/providers/cat_breed_providers.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/widgets/cat_card.dart';

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
    final notifier = ref.read(catBreedsPaginatedProvider.notifier);

    return catBreedsAsync.when(
      data: (breeds) {
        final showLoader = notifier.hasMore || notifier.isLoading;

        return ListView.builder(
          controller: _scrollController,
          itemCount: breeds.length + (showLoader ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < breeds.length) {
              final breed = breeds[index];
              return CatCard(breed: breed);
            } else {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
    );
  }
}
