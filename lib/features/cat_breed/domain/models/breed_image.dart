import 'package:prag_cat_breed/features/cat_breed/domain/models/cat_breed.dart';

class BreedImage {
    final List<CatBreed> breeds;
    final String id;
    final String url;
    final int width;
    final int height;

    BreedImage({
        required this.breeds,
        required this.id,
        required this.url,
        required this.width,
        required this.height,
    });

    factory BreedImage.fromJson(Map<String, dynamic> json) => BreedImage(
        breeds: List<CatBreed>.from(json["breeds"].map((x) => CatBreed.fromJson(x))),
        id: json["id"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
    );

    Map<String, dynamic> toJson() => {
        "breeds": List<dynamic>.from(breeds.map((x) => x.toJson())),
        "id": id,
        "url": url,
        "width": width,
        "height": height,
    };
}

