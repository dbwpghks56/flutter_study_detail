import 'package:first/common/model/cursor_pagination_model.dart';
import 'package:first/common/model/pagination_params.dart';
import 'package:first/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/provider/pagination_provider.dart';
import '../repository/restaurant_repository.dart';

final restaurantDetailProvider = Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  if(state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhere((element) => element.id == id);
});

final restaurantProvider = StateNotifierProvider <RestaurantStateNotifier, CursorPaginationBase>
  ((ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    return RestaurantStateNotifier(repository: repository);
});

class RestaurantStateNotifier extends PaginationProvider<RestaurantModel, RestaurantRepository> {

  RestaurantStateNotifier({
    required super.repository
  });

  void getDetail({
    required String id
  }) async {
    // 만약에 아직 데이터가 하나도 없는 상태라면 (CursorPagination 이 아니라면)
    // 데이터를 가져오는 시도를 한다.
    if(state is! CursorPagination) {
      await this.paginate();
    }

    // state가 CursorPagination 이 아닐 때 그냥 리턴
    if(state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;

    final resp = await repository.getRestaurantDetail(id: id);

    state = pState.copyWith(
      data: pState.data.map<RestaurantModel>((e) => e.id == id ? resp : e).toList()
    );
  }
}











