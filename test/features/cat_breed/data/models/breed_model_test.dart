import 'package:flutter_test/flutter_test.dart';
import 'package:prag_cat_breed/features/cat_breed/data/models/breed_model.dart';
import 'package:prag_cat_breed/features/cat_breed/data/models/image_breed_model.dart';
import 'package:prag_cat_breed/features/cat_breed/data/models/weight_model.dart';

void main() {
  group('BreedModel', () {
    final mockJson = {
      "weight": {
        "imperial": "7 - 10",
        "metric": "3 - 5",
      },
      "id": "abys",
      "name": "Abyssinian",
      "cfa_url": "http://cfa.org",
      "vetstreet_url": null,
      "vcahospitals_url": null,
      "temperament": "Active",
      "origin": "Egypt",
      "country_codes": "EG",
      "country_code": "EG",
      "description": "A short-haired breed",
      "life_span": "14 - 15",
      "indoor": 0,
      "lap": null,
      "alt_names": null,
      "adaptability": 5,
      "affection_level": 5,
      "child_friendly": 3,
      "dog_friendly": 4,
      "energy_level": 5,
      "grooming": 1,
      "health_issues": 2,
      "intelligence": 5,
      "shedding_level": 2,
      "social_needs": 5,
      "stranger_friendly": 5,
      "vocalisation": 2,
      "experimental": 0,
      "hairless": 0,
      "natural": 1,
      "rare": 0,
      "rex": 0,
      "suppressed_tail": 0,
      "short_legs": 0,
      "wikipedia_url": "https://wikipedia.org",
      "hypoallergenic": 0,
      "reference_image_id": "img1",
      "image": {
        "id": "img1",
        "width": 800,
        "height": 600,
        "url": "https://example.com/cat.jpg",
      },
      "cat_friendly": 3,
      "bidability": 3,
    };

    test('fromJson crea BreedModel correctamente', () {
      final model = BreedModel.fromJson(mockJson);

      // Datos simples
      expect(model.id, "abys");
      expect(model.name, "Abyssinian");
      expect(model.temperament, "Active");
      expect(model.origin, "Egypt");

      // Datos anidados: WeightModel
      expect(model.weight, isA<WeightModel>());
      expect(model.weight.imperial, "7 - 10");
      expect(model.weight.metric, "3 - 5");

      // Datos anidados: ImageBreedModel
      expect(model.image, isA<ImageBreedModel>());
      expect(model.image!.id, "img1");
      expect(model.image!.width, 800);
      expect(model.image!.height, 600);

      // Valores opcionales
      expect(model.vetstreetUrl, null);
      expect(model.lap, null);

      // Campos numéricos
      expect(model.adaptability, 5);
      expect(model.healthIssues, 2);
      expect(model.hypoallergenic, 0);
    });

    test('fromJson maneja image = null', () {
      final jsonWithoutImage = {
        ...mockJson,
        "image": null,
      };

      final model = BreedModel.fromJson(jsonWithoutImage);

      expect(model.image, isNull);
    });
  });
}
