import 'package:first/common/model/cursor_pagination_model.dart';
import 'package:first/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/restaurant_repository.dart';

final restaurantProvider = StateNotifierProvider <RestaurantStateNotifier, CursorPaginationBase>
  ((ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    return RestaurantStateNotifier(repository: repository);
});

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository
  }) : super(CursorPaginationLoading()){
    paginate();
  }
  paginate() async {
    final resp = await repository.paginate();

    state = resp;
  }
}











