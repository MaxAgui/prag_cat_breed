import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prag_cat_breed/core/config/dio_config.dart';
import 'package:prag_cat_breed/features/cat_breed/data/models/breed_model.dart';
import 'package:prag_cat_breed/features/cat_breed/data/repositories/cat_breed_repository.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/providers/cat_breed_providers.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/providers/usecases_providers.dart';

import '../../../../fixtures/breed_fixture.dart';
import '../../../../mocks.dart';

void main() {
  test('catBreedRepositoryProvider retorna un DioCatBreedRepository', () {
    final container = ProviderContainer(
      overrides: [dioProvider.overrideWithValue(MockDio())],
    );

    final repo = container.read(catBreedRepositoryProvider);

    expect(repo, isA<DioCatBreedRepository>());
  });

  test('catBreedsPaginatedProvider carga datos correctamente', () async {
    final mockUseCase = MockGetBreedsUseCase();

    final breed = BreedModel.fromJson(breedMockJson).toEntity();

    when(
      () => mockUseCase(page: 0, limit: 10),
    ).thenAnswer((_) async => [breed]);

    final container = ProviderContainer(
      overrides: [getBreedsUseCaseProvider.overrideWithValue(mockUseCase)],
    );

    final controller = container.read(catBreedsPaginatedProvider.notifier);

    controller.loadMore();

    await container.pump();

    final state = container.read(catBreedsPaginatedProvider);

    expect(state.value, isNotNull);
    expect(state.value!.length, 1);
    expect(state.value!.first.id, "abys");
  });

  test('catBreedsSearchProvider devuelve resultados correctamente', () async {
    final mockUseCase = MockSearchBreedsUseCase();

    final breed = BreedModel.fromJson(breedMockJson).toEntity();

    when(() => mockUseCase("aby")).thenAnswer((_) async => [breed]);

    final container = ProviderContainer(
      overrides: [searchBreedsUseCaseProvider.overrideWithValue(mockUseCase)],
    );

    final result = await container.read(catBreedsSearchProvider("aby").future);

    expect(result.length, 1);
    expect(result.first.id, "abys");
  });

  test(
    'catBreedsSearchProvider retorna lista vacía si query es vacía',
    () async {
      final container = ProviderContainer();
      final result = await container.read(catBreedsSearchProvider("").future);

      expect(result, isEmpty);
    },
  );

  test('catSearchQueryProvider actualiza su estado correctamente', () {
    final container = ProviderContainer();

    expect(container.read(catSearchQueryProvider), "");

    container.read(catSearchQueryProvider.notifier).state = "aby";

    expect(container.read(catSearchQueryProvider), "aby");
  });
}
