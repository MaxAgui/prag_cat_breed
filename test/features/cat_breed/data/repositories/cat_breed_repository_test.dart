import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prag_cat_breed/core/config/api_config.dart';
import 'package:prag_cat_breed/features/cat_breed/data/repositories/cat_breed_repository.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/entities/breed.dart';

import '../../../../mocks.dart';

void main() {
  late MockDio dio;
  late MockParams params;
  late DioCatBreedRepository repository;

  final breedMockJson = {
    "weight": {"imperial": "7 - 10", "metric": "3 - 5"},
    "id": "abys",
    "name": "Abyssinian",
    "temperament": "Active",
    "origin": "Egypt",
    "country_codes": "EG",
    "country_code": "EG",
    "description": "A short-haired breed",
    "life_span": "14 - 15",
    "indoor": 0,
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
    "hypoallergenic": 0,
    "cat_friendly": 3,
    "bidability": 3,
  };

  setUp(() {
    dio = MockDio();
    params = MockParams();
    repository = DioCatBreedRepository(
      client: dio,
      apiKey: 'test_key',
      params: params,
    );
  });

  group('get breeds paginated', () {
    test('retorna lista de breeds paginated', () async {
      // ARRANGE
      when(() => params.breeds(0, 10)).thenReturn({"page": "0", "limit": "10"});

      final mockResponse = Response(
        data: [
          breedMockJson,
          {...breedMockJson, "id": "siam", "name": "Siamese"},
        ],
        statusCode: 200,
        requestOptions: RequestOptions(),
      );

      when(
        () => dio.get(
          '${ApiConfig.baseUrl}breeds',
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => mockResponse);

      // ACT
      final result = await repository.getBreeds();

      // ASSERT
      expect(result, isA<List<Breed>>());
      expect(result.length, 2);
      expect(result.first.id, "abys");
      expect(result[1].id, "siam");

      verify(() => params.breeds(0, 10)).called(1);
      verify(
        () => dio.get(
          '${ApiConfig.baseUrl}breeds',
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      ).called(1);
    });

    test('lanza "No internet connection" cuando hay error de red', () async {
      when(() => params.breeds(0, 10)).thenReturn({"page": "0", "limit": "10"});
      when(
        () => dio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          type: DioExceptionType.connectionError,
          requestOptions: RequestOptions(),
          error: SocketException("No internet"),
        ),
      );
      expect(
        () => repository.getBreeds(),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('No internet connection'),
          ),
        ),
      );
    });

    test('lanza "Unknown Dio error" para errores inesperados', () async {
      when(() => params.breeds(0, 10)).thenReturn({"page": "0", "limit": "10"});
      when(
        () => dio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(),
        ),
      );
      expect(
        () => repository.getBreeds(),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Ocurrió un error'),
          ),
        ),
      );
    });

    test(
      'getBreeds lanza Ocurrió un error cuando ocurre excepción NO DioException',
      () async {
        // *Importante:* Lanzamos una excepción normal, no DioException
        when(
          () => dio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenThrow(FormatException("Invalid format"));

        expect(
          () => repository.getBreeds(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'mensaje',
              contains('Ocurrió un error'),
            ),
          ),
        );
      },
    );
  });

  group('searchBreeds', () {
    test('retorna lista de breeds según query', () async {
      // ARRANGE
      when(
        () => params.searchBreeds('aby', true),
      ).thenReturn({"q": "aby", "attach_image": "true"});

      final mockResponse = Response(
        data: [
          breedMockJson,
          {...breedMockJson, "id": "siam", "name": "Siamese"},
        ],
        statusCode: 200,
        requestOptions: RequestOptions(),
      );

      when(
        () => dio.get(
          '${ApiConfig.baseUrl}breeds/search',
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => mockResponse);

      // ACT
      final result = await repository.searchBreeds(query: 'aby');

      // ASSERT
      expect(result, isA<List<Breed>>());
      expect(result.length, 2);
      expect(result.first.id, "abys");
      expect(result[1].id, "siam");

      verify(() => params.searchBreeds('aby', true)).called(1);
      verify(
        () => dio.get(
          '${ApiConfig.baseUrl}breeds/search',
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      ).called(1);
    });

    test('lanza "No internet connection" cuando hay error de red', () async {
      when(
        () => params.searchBreeds('aby', true),
      ).thenReturn({"q": "aby", "attach_image": "true"});

      when(
        () => dio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          type: DioExceptionType.connectionError,
          requestOptions: RequestOptions(),
          error: SocketException("No internet"),
        ),
      );

      expect(
        () => repository.searchBreeds(query: 'aby'),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('No internet connection'),
          ),
        ),
      );
    });

    test('lanza "Ocurrió un error" para errores inesperados', () async {
      when(
        () => params.searchBreeds('aby', true),
      ).thenReturn({"q": "aby", "attach_image": "true"});

      when(
        () => dio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(),
        ),
      );

      expect(
        () => repository.searchBreeds(query: 'aby'),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Ocurrió un error'),
          ),
        ),
      );
    });

    test(
      'lanza "Ocurrió un error" para errores inesperados sin dioexception',
      () async {
        when(
          () => params.searchBreeds('aby', true),
        ).thenReturn({"q": "aby", "attach_image": "true"});

        when(
          () => dio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenThrow(FormatException("Invalid format"));

        expect(
          () => repository.searchBreeds(query: 'aby'),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Ocurrió un error'),
            ),
          ),
        );
      },
    );
  });
}
