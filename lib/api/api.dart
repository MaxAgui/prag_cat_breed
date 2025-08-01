class TheCatAPI {
  TheCatAPI(this.apiKey);
  final String apiKey;

  static const String _apiBaseUrl = "api.thecatapi.com";
  static const String _apiPath = "/v1/";

  String get baseUrl => "https://$_apiBaseUrl$_apiPath";

  Map<String, dynamic> searchImagesQueryParameters({
    String size = 'med',
    String mimeTypes = 'jpg',
    String format = 'json',
    bool hasBreeds = true,
    String order = 'ASC',
    int page = 0,
    int limit = 10,
    bool includeCategories = true,
  }) =>
      {
        "size": size,
        "mime_types": mimeTypes,
        "format": format,
        "has_breeds": hasBreeds.toString(),
        "order": order,
        "page": page.toString(),
        "limit": limit.toString(),
        "include_categories": includeCategories.toString(),
      };

  /// Query params for paginated breeds list
  Map<String, dynamic> breedsQueryParameters({
    int page = 0,
    int limit = 10,
  }) => {
        "page": page.toString(),
        "limit": limit.toString(),
      };

  /// Query params for breeds search
  Map<String, dynamic> searchBreedsQueryParameters({
    required String query,
    bool attachImage = true,
  }) => {
        "q": query,
        "attach_image": attachImage ? "1" : "0",
      };
}