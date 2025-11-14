import 'package:prag_cat_breed/core/config/api_keys.dart';
import 'package:prag_cat_breed/core/config/dio_config.dart';
import 'package:prag_cat_breed/features/cat_breed/data/datasources/cat_breed_api_params.dart';
import 'package:prag_cat_breed/features/cat_breed/data/repositories/cat_breed_repository.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/entities/breed.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/entities/image_breed.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/repositories/breed_repository.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/controllers/breed_pagination_controller.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/providers/usecases_providers.dart';
import 'package:riverpod/riverpod.dart';

final catBreedRepositoryProvider = Provider<BreedRepository>((ref) {
  const apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: APIKeys.catAPIKey,
  );

  final client = ref.watch(dioProvider);

  return DioCatBreedRepository(
    client: client,
    apiKey: apiKey,
    params: CatBreedApiParams(),
  );
});

final catBreedsImagesProvider = FutureProvider.autoDispose<List<ImageBreed>>((
  ref,
) async {
  final useCase = ref.watch(getBreedImagesUseCaseProvider);
  return useCase(page: 0, limit: 10);
});

final catBreedsPaginatedProvider =
    StateNotifierProvider<BreedPaginationController, AsyncValue<List<Breed>>>((
      ref,
    ) {
      final useCase = ref.watch(getBreedsUseCaseProvider);
      return BreedPaginationController(useCase);
    });

final catSearchQueryProvider = StateProvider<String>((ref) => '');

final catBreedsSearchProvider = FutureProvider.autoDispose
    .family<List<Breed>, String>((ref, query) async {
      if (query.isEmpty) return [];
      final useCase = ref.watch(searchBreedsUseCaseProvider);
      return useCase(query);
    });
