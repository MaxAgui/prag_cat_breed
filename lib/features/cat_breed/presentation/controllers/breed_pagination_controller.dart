import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/entities/breed.dart';
import 'package:prag_cat_breed/features/cat_breed/domain/use_cases/get_breeds_use_case.dart';

class BreedPaginationController extends StateNotifier<AsyncValue<List<Breed>>> {
  final GetBreedsUseCase _getBreeds;

  BreedPaginationController(this._getBreeds) : super(const AsyncLoading()) {
    _fetchNextPage(); // carga inicial
  }

  final List<Breed> _allBreeds = [];
  int _page = 0;
  final int _limit = 10;
  bool _hasMore = true;
  bool _isLoading = false;

  Future<void> _fetchNextPage() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    try {
      final newBreeds = await _getBreeds(page: _page, limit: _limit);
      if (newBreeds.length < _limit) _hasMore = false;
      _allBreeds.addAll(newBreeds);
      _page++;
      state = AsyncValue.data([..._allBreeds]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      _isLoading = false;
    }
  }

  void loadMore() => _fetchNextPage();

  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;
}
