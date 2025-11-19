import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prag_cat_breed/features/cat_breed/data/models/breed_model.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/use_cases/search_breeds_use_case.dart';

import '../../../../fixtures/breed_fixture.dart';
import '../../../../mocks.dart';

void main() {
  late SearchBreedsUseCase useCase;
  late MockBreedRepository mockRepository;

  setUp(() {
    mockRepository = MockBreedRepository();
    useCase = SearchBreedsUseCase(mockRepository);
  });

  test('Debe llamar repository.searchBreeds y retornar la lista', () async {
    // Arrange
    const query = 'siamese';
    final breed = BreedModel.fromJson(breedMockJson).toEntity();
    final breeds = [breed];

    when(
      () => mockRepository.searchBreeds(query: query),
    ).thenAnswer((_) async => breeds);

    // Act
    final result = await useCase(query);

    // Assert
    expect(result, breeds);
    verify(() => mockRepository.searchBreeds(query: query)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
