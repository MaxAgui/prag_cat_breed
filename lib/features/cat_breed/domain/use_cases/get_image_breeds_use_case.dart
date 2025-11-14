import 'package:prag_cat_breed/features/cat_breed/domain/entities/image_breed.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/repositories/breed_repository.dart';

class GetImageBreedsUseCase {
  final BreedRepository repository;

  GetImageBreedsUseCase(this.repository);

  Future<List<ImageBreed>> call({int page = 0, int limit = 10}) {
    return repository.getImageBreeds(page: page, limit: limit);
  }
}
