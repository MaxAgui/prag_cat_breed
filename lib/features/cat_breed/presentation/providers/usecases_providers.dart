import 'package:prag_cat_breed/features/cat_breed/domain/use_cases/get_breeds_use_case.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/use_cases/search_breeds_use_case.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/providers/cat_breed_providers.dart';
import 'package:riverpod/riverpod.dart';

final getBreedsUseCaseProvider =
    Provider<GetBreedsUseCase>((ref) {
  final repo = ref.watch(catBreedRepositoryProvider);
  return GetBreedsUseCase(repo);
});

final searchBreedsUseCaseProvider =
    Provider<SearchBreedsUseCase>((ref) {
  final repo = ref.watch(catBreedRepositoryProvider);
  return SearchBreedsUseCase(repo);
});