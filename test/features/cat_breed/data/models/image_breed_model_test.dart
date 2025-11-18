import 'package:flutter_test/flutter_test.dart';
import 'package:prag_cat_breed/features/cat_breed/data/models/image_breed_model.dart';

void main() {
  group('ImageBreedModel', () {

    final mockJson = {
      "id": "abc123",
      "width": 800,
      "height": 600,
      "url": "https://example.com/cat.png",
    };

    test('fromJson crea ImageBreedModel correctamente', () {
      final model = ImageBreedModel.fromJson(mockJson);

      expect(model.id, "abc123");
      expect(model.width, 800);
      expect(model.height, 600);
      expect(model.url, "https://example.com/cat.png");
    });

    test('toJson devuelve un mapa correcto', () {
      final model = ImageBreedModel(
        id: "abc123",
        width: 800,
        height: 600,
        url: "https://example.com/cat.png",
      );

      final json = model.toJson();

      expect(json, mockJson);
    });

    test('fromJson seguido de toJson mantiene los datos', () {
      final model = ImageBreedModel.fromJson(mockJson);
      final resultJson = model.toJson();

      expect(resultJson, mockJson);
    });
  });
}
