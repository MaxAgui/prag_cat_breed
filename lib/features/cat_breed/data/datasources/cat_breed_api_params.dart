class CatBreedApiParams {
  Map<String, dynamic> breeds(int page, int limit) => {
    "page": "$page",
    "limit": "$limit",
  };

  Map<String, dynamic> searchBreeds(String query, bool attachImage) => {
    "q": query,
    "attach_image": attachImage ? "1" : "0",
  };

  Map<String, dynamic> images(int page, int limit) => {
    "size": "med",
    "mime_types": "jpg",
    "page": "$page",
    "limit": "$limit",
  };
}
