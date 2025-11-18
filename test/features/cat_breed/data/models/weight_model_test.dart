import 'package:flutter_test/flutter_test.dart';
import 'package:prag_cat_breed/features/cat_breed/data/models/weight_model.dart';

void main() {
  group('WeightModel', () {
    final mockJson = {
      "imperial": "7 - 10",
      "metric": "3 - 5",
    };

    test('fromJson crea WeightModel correctamente', () {
      final model = WeightModel.fromJson(mockJson);

      expect(model.imperial, "7 - 10");
      expect(model.metric, "3 - 5");
    });

    test('toJson devuelve un mapa correcto', () {
      final model = WeightModel(
        imperial: "7 - 10",
        metric: "3 - 5",
      );

      final json = model.toJson();

      expect(json, mockJson);
    });

    test('fromJson seguido de toJson mantiene los datos', () {
      final model = WeightModel.fromJson(mockJson);
      final resultJson = model.toJson();

      expect(resultJson, mockJson);
    });

    test('fromJson maneja valores nulos usando strings vacíos', () {
      final json = {
        "imperial": null,
        "metric": null,
      };

      final model = WeightModel.fromJson(json);

      expect(model.imperial, "");
      expect(model.metric, "");
    });
  });
}
