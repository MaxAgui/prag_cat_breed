import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prag_cat_breed/features/cat_breed/data/models/breed_model.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/use_cases/get_breeds_use_case.dart';

import '../../../../fixtures/breed_fixture.dart';
import '../../../../mocks.dart';

void main() {
  late GetBreedsUseCase useCase;
  late MockBreedRepository mockRepository;

  setUp(() {
    mockRepository = MockBreedRepository();
    useCase = GetBreedsUseCase(mockRepository);
  });

  test(
    'Debe llamar repository.getBreeds con page y limit y retornar la lista',
    () async {
      // Arrange
      const page = 1;
      const limit = 20;

      final breedModel = BreedModel.fromJson(breedMockJson);
      final breed = breedModel.toEntity(); // convertir a Breed
      final breeds = [breed];

      // Stub del mock
      when(
        () => mockRepository.getBreeds(page: page, limit: limit),
      ).thenAnswer((_) async => breeds);

      // Act
      final result = await useCase(page: page, limit: limit);

      // Assert
      expect(result, breeds);
      verify(
        () => mockRepository.getBreeds(page: page, limit: limit),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('Debe llamar al repositorio con valores por defecto', () async {
    // Arrange
    final breed = BreedModel.fromJson(breedMockJson).toEntity();
    final breeds = [breed];

    when(
      () => mockRepository.getBreeds(page: 0, limit: 10),
    ).thenAnswer((_) async => breeds);

    // Act
    final result = await useCase(); // usa los valores default

    // Assert
    expect(result, breeds);
    verify(() => mockRepository.getBreeds(page: 0, limit: 10)).called(1);
  });
}
