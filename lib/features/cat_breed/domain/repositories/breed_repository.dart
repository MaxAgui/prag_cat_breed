import '../entities/breed.dart';
import '../entities/image_breed.dart';

abstract class BreedRepository {
  Future<List<Breed>> getBreeds({int page = 0, int limit = 10});
  Future<List<ImageBreed>> getImageBreeds({int page = 0, int limit = 10});
  Future<List<Breed>> searchBreeds({
    required String query,
    bool attachImage = true,
  });
}
