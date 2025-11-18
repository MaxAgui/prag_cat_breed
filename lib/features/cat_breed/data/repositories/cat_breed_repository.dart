import 'dart:io';
import 'package:dio/dio.dart';
import 'package:prag_cat_breed/core/config/api_config.dart';
import 'package:prag_cat_breed/features/cat_breed/data/datasources/cat_breed_api_params.dart';
import 'package:prag_cat_breed/features/cat_breed/data/models/breed_model.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/entities/breed.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/repositories/breed_repository.dart';

class DioCatBreedRepository implements BreedRepository {
  final Dio client;
  final String apiKey;
  final CatBreedApiParams params;

  DioCatBreedRepository({
    required this.client,
    required this.apiKey,
    required this.params,
  });

  /// GET /breeds - Lista paginada de razas
  @override
  Future<List<Breed>> getBreeds({int page = 0, int limit = 10}) async {
    try {
      final response = await client.get(
        '${ApiConfig.baseUrl}breeds',
        queryParameters: params.breeds(page, limit),
        options: Options(headers: {'x-api-key': apiKey}),
      );
      final List<dynamic> rawData = response.data;
      return rawData
          .map<BreedModel>((json) => BreedModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.error is SocketException) {
        throw Exception('No internet connection');
      }
      throw Exception('Ocurrió un error');
    } catch (e) {
      throw Exception('Ocurrió un error');
    }
  }

  /// GET /breeds/search?q= - Buscar razas por query, opcionalmente con imagen
  @override
  Future<List<Breed>> searchBreeds({
    required String query,
    bool attachImage = true,
  }) async {
    try {
      final response = await client.get(
        '${ApiConfig.baseUrl}breeds/search',
        queryParameters: params.searchBreeds(query, attachImage),
        options: Options(headers: {'x-api-key': apiKey}),
      );
      final List<dynamic> rawData = response.data;
      return rawData
          .map<BreedModel>((json) => BreedModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.error is SocketException) {
        throw Exception('No internet connection');
      }
      throw Exception('Ocurrió un error');
    } catch (e) {
      throw Exception('Ocurrió un error');
    }
  }
}
