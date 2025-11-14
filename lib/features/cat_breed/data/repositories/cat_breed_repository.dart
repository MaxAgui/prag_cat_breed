import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prag_cat_breed/api/api.dart';
import 'package:prag_cat_breed/api/api_keys.dart';
import 'package:prag_cat_breed/core/config/dio_config.dart';
import 'package:prag_cat_breed/features/cat_breed/data/models/breed_model.dart';
import 'package:prag_cat_breed/features/cat_breed/data/models/image_breed_model.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/entities/breed.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/entities/image_breed.dart';

class DioCatBreedRepository {
  final TheCatAPI api;
  final Dio client;

  DioCatBreedRepository({required this.api, required this.client});

  Future<List<ImageBreed>> getImageBreeds({
    int page = 0,
    int limit = 10,
  }) async {
    try {
      final response = await client.get(
        '${api.baseUrl}images/search',
        queryParameters: api.searchImagesQueryParameters(
          page: page,
          limit: limit,
        ),
        options: Options(headers: {'x-api-key': api.apiKey}),
      );
      final List<dynamic> rawData = response.data;
      return rawData
          .map<ImageBreedModel>((json) => ImageBreedModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.error is SocketException) {
        throw Exception('No internet connection');
      }
      throw Exception('Unknown Dio error');
    }
  }

  /// GET /breeds - Lista paginada de razas
  Future<List<Breed>> getBreeds({int page = 0, int limit = 10}) async {
    try {
      final response = await client.get(
        '${api.baseUrl}breeds',
        queryParameters: api.breedsQueryParameters(page: page, limit: limit),
        options: Options(headers: {'x-api-key': api.apiKey}),
      );
      final List<dynamic> rawData = response.data;
      return rawData.map<BreedModel>((json) => BreedModel.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.error is SocketException) {
        throw Exception('No internet connection');
      }
      throw Exception('Unknown Dio error: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }

  /// GET /breeds/search?q= - Buscar razas por query, opcionalmente con imagen
  Future<List<Breed>> searchBreeds({
    required String query,
    bool attachImage = true,
  }) async {
    try {
      final response = await client.get(
        '${api.baseUrl}breeds/search',
        queryParameters: api.searchBreedsQueryParameters(
          query: query,
          attachImage: attachImage,
        ),
        options: Options(headers: {'x-api-key': api.apiKey}),
      );
      final List<dynamic> rawData = response.data;
      return rawData.map<BreedModel>((json) => BreedModel.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.error is SocketException) {
        throw Exception('No internet connection');
      }
      throw Exception('Unknown Dio error');
    }
  }
}

final catBreedRepositoryProvider = Provider<DioCatBreedRepository>((ref) {
  const apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: APIKeys.catAPIKey,
  );
  final client = ref.watch(dioProvider);
  return DioCatBreedRepository(api: TheCatAPI(apiKey), client: client);
});
