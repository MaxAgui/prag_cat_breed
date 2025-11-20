import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/entities/breed.dart';
import 'package:riverpod/riverpod.dart';

import 'package:prag_cat_breed/features/cat_breed/data/models/breed_model.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/controllers/breed_pagination_controller.dart';

import '../../../../fixtures/breed_fixture.dart';
import '../../../../mocks.dart';

void main() {
  late MockGetBreedsUseCase mockUseCase;
  late ProviderContainer container;
  late BreedPaginationController controller;

  setUp(() {
    mockUseCase = MockGetBreedsUseCase();
    container = ProviderContainer();
  });

  test('Carga inicial (constructor) — carga la primera página', () async {
    final breed = BreedModel.fromJson(breedMockJson).toEntity();

    when(
      () => mockUseCase(page: 0, limit: 10),
    ).thenAnswer((_) async => [breed]);

    controller = BreedPaginationController(mockUseCase);

    await container.pump(); // deja completar el _fetchNextPage del constructor

    // El estado inicial debería ser AsyncData
    expect(controller.state.value, isNotNull);
    expect(controller.state.value!.length, 1);
    expect(controller.state.value!.first.id, "abys");
  });

  test('loadMore() carga la segunda página', () async {
    final breed = BreedModel.fromJson(breedMockJson).toEntity();

    // Primera página: debe ser >= limit (10 elements)
    final page1 = List.generate(10, (_) => breed);

    // Segunda página (1 element está bien)
    final page2 = [breed];

    // Primera página
    when(() => mockUseCase(page: 0, limit: 10)).thenAnswer((_) async => page1);

    // Segunda página
    when(() => mockUseCase(page: 1, limit: 10)).thenAnswer((_) async => page2);

    controller = BreedPaginationController(mockUseCase);

    await container.pump(); // carga inicial

    controller.loadMore();
    await container.pump();

    verify(() => mockUseCase(page: 0, limit: 10)).called(1);
    verify(() => mockUseCase(page: 1, limit: 10)).called(1);
    expect(controller.state.value!.length, 11);
  });

  test(
    'hasMore se vuelve false cuando la página tiene menos de _limit items',
    () async {
      final breed = BreedModel.fromJson(breedMockJson).toEntity();

      // Devuelve solo 1 item → menos del límite de 10
      when(
        () => mockUseCase(page: 0, limit: 10),
      ).thenAnswer((_) async => [breed]);

      controller = BreedPaginationController(mockUseCase);

      await container.pump();

      expect(controller.hasMore, isFalse);
    },
  );

  test('Manejo de errores — state debe ser AsyncError', () async {
    when(() => mockUseCase(page: 0, limit: 10)).thenThrow(Exception("Error"));

    controller = BreedPaginationController(mockUseCase);

    await container.pump();

    expect(controller.state, isA<AsyncError>());
  });

  test('isLoading es false después de cargar', () async {
    final breed = BreedModel.fromJson(breedMockJson).toEntity();

    // stub
    when(
      () => mockUseCase(page: 0, limit: 10),
    ).thenAnswer((_) async => [breed]);

    controller = BreedPaginationController(mockUseCase);

    await container.pump(); // deja terminar la carga async

    expect(controller.isLoading, false);
  });

  test('isLoading es true mientras se está cargando', () async {
    final completer = Completer<List<Breed>>();

    // stub que NO completa inmediatamente
    when(
      () => mockUseCase(page: 0, limit: 10),
    ).thenAnswer((_) => completer.future);

    controller = BreedPaginationController(mockUseCase);

    // Aún NO resolvimos el completer → la carga sigue en progreso
    expect(controller.isLoading, true);

    // Ahora completamos la carga
    completer.complete([]);

    // Permitimos que complete
    await container.pump();

    // Ahora debe ser false
    expect(controller.isLoading, false);
  });
}
