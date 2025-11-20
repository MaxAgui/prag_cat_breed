import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:prag_cat_breed/features/cat_breed/data/datasources/cat_breed_api_params.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/repositories/breed_repository.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/use_cases/get_breeds_use_case.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/use_cases/search_breeds_use_case.dart';

class MockDio extends Mock implements Dio {}
class MockParams extends Mock implements CatBreedApiParams {}
class MockBreedRepository extends Mock implements BreedRepository {}
class MockGetBreedsUseCase extends Mock implements GetBreedsUseCase {}
class MockSearchBreedsUseCase extends Mock implements SearchBreedsUseCase {}