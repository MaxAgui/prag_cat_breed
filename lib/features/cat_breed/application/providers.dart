import 'package:prag_cat_breed/features/cat_breed/data/repositories/cat_breed_repository.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/models/breed_image.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/models/breed.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/breed_pagination_controller.dart';
import 'package:riverpod/riverpod.dart';

final catBreedsImagesProvider = FutureProvider.autoDispose<List<BreedImage>>((ref) async {
  final repository = ref.watch(catBreedRepositoryProvider);
  return repository.getImageBreeds();
});

final catBreedsPaginatedProvider = StateNotifierProvider<BreedPaginationController, AsyncValue<List<Breed>>>(
  (ref) {
    final repository = ref.watch(catBreedRepositoryProvider);
    return BreedPaginationController(repository);
  },
);

final catSearchQueryProvider = StateProvider<String>((ref) => '');

final catBreedsSearchProvider = FutureProvider.autoDispose.family<List<Breed>, String>((ref, query) async {
  final repository = ref.watch(catBreedRepositoryProvider);
  if (query.isEmpty) return [];
  return repository.searchBreeds(query: query);
});

