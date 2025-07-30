import 'package:prag_cat_breed/features/cat_breed/data/repositories/cat_breed_repository.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/models/breed_image.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/models/breed.dart';
import 'package:riverpod/riverpod.dart';

final catBreedsImagesProvider = FutureProvider.autoDispose<List<BreedImage>>((ref) async {
  final repository = ref.watch(catBreedRepositoryProvider);
  return repository.getImageBreeds();
});

final catBreedsPaginatedProvider = FutureProvider.autoDispose<List<Breed>>((ref) async {
  final repository = ref.watch(catBreedRepositoryProvider);
  return repository.getBreeds();
});

final catBreedsSearchProvider = FutureProvider.autoDispose<List<Breed>>((ref) async {
  final repository = ref.watch(catBreedRepositoryProvider);
  return repository.searchBreeds(query: 'a');
});