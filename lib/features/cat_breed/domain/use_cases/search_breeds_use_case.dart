import 'package:prag_cat_breed/features/cat_breed/domain/entities/breed.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/repositories/breed_repository.dart';

class SearchBreedsUseCase {
  final BreedRepository repository;

  SearchBreedsUseCase(this.repository);

  Future<List<Breed>> call(String query) {
    return repository.searchBreeds(query: query);
  }
}
