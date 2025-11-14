import 'package:prag_cat_breed/features/cat_breed/domain/entities/weight.dart';

class WeightModel extends Weight {
  WeightModel({
    required super.imperial,
    required super.metric,
  });

  factory WeightModel.fromJson(Map<String, dynamic> json) {
    return WeightModel(
      imperial: json["imperial"] ?? '',
      metric: json["metric"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "imperial": imperial,
      "metric": metric,
    };
  }
}