import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:prag_cat_breed/features/cat_breed/data/datasources/cat_breed_api_params.dart';

class MockDio extends Mock implements Dio {}
class MockParams extends Mock implements CatBreedApiParams {}
