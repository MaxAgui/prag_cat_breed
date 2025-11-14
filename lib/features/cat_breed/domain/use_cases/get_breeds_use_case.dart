import '../repositories/breed_repository.dart';
import '../entities/breed.dart';

class GetBreedsUseCase {
  final BreedRepository repository;

  GetBreedsUseCase(this.repository);

  Future<List<Breed>> call({int page = 0, int limit = 10}) {
    return repository.getBreeds(page: page, limit: limit);
  }
}
