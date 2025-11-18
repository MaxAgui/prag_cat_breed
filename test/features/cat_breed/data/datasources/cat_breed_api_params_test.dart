import 'package:flutter_test/flutter_test.dart';
import 'package:prag_cat_breed/features/cat_breed/data/datasources/cat_breed_api_params.dart';

void main() {
  late CatBreedApiParams params;

  setUp(() {
    params = CatBreedApiParams();
  });

  group('breeds', () {
    test('retorna page y limit como strings', () {
      final result = params.breeds(2, 15);

      expect(result, {"page": "2", "limit": "15"});
    });
  });

  group('searchBreeds', () {
    test('retorna query y attach_image=1 cuando attachImage es true', () {
      final result = params.searchBreeds("abyssinian", true);

      expect(result, {"q": "abyssinian", "attach_image": "1"});
    });

    test('retorna attach_image=0 cuando attachImage es false', () {
      final result = params.searchBreeds("siamese", false);

      expect(result, {"q": "siamese", "attach_image": "0"});
    });
  });
}
