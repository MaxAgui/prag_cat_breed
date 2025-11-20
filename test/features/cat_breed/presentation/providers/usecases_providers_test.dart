import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/providers/usecases_providers.dart';
import 'package:riverpod/riverpod.dart';

import 'package:prag_cat_breed/features/cat_breed/domain/use_cases/get_breeds_use_case.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/use_cases/search_breeds_use_case.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/providers/cat_breed_providers.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/repositories/breed_repository.dart';

class MockBreedRepository extends Mock implements BreedRepository {}

void main() {
  group("UseCase Providers", () {
    test("getBreedsUseCaseProvider devuelve un GetBreedsUseCase", () {
      final mockRepo = MockBreedRepository();

      final container = ProviderContainer(
        overrides: [
          catBreedRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );

      final usecase = container.read(getBreedsUseCaseProvider);

      expect(usecase, isA<GetBreedsUseCase>());
    });

    test("getBreedsUseCaseProvider usa el repositorio sobreescrito", () {
      final mockRepo = MockBreedRepository();

      final container = ProviderContainer(
        overrides: [
          catBreedRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );

      final usecase = container.read(getBreedsUseCaseProvider);

      // Verificamos que el usecase usa EXACTAMENTE ese repositorio
      expect(usecase.repository, equals(mockRepo));
    });

    test("searchBreedsUseCaseProvider devuelve un SearchBreedsUseCase", () {
      final mockRepo = MockBreedRepository();

      final container = ProviderContainer(
        overrides: [
          catBreedRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );

      final usecase = container.read(searchBreedsUseCaseProvider);

      expect(usecase, isA<SearchBreedsUseCase>());
    });

    test("searchBreedsUseCaseProvider usa el repositorio sobreescrito", () {
      final mockRepo = MockBreedRepository();

      final container = ProviderContainer(
        overrides: [
          catBreedRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );

      final usecase = container.read(searchBreedsUseCaseProvider);

      expect(usecase.repository, equals(mockRepo));
    });
  });
}
