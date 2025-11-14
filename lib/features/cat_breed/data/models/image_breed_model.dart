import 'package:prag_cat_breed/features/cat_breed/domain/entities/image_breed.dart';

class ImageBreedModel extends ImageBreed {
  ImageBreedModel({
    required super.id,
    required super.width,
    required super.height,
    required super.url,
  });

  factory ImageBreedModel.fromJson(Map<String, dynamic> json) {
    return ImageBreedModel(
      id: json["id"],
      width: json["width"],
      height: json["height"],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "width": width,
      "height": height,
      "url": url,
    };
  }
}
