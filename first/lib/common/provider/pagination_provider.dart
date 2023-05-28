import 'package:first/common/model/cursor_pagination_model.dart';
import 'package:first/common/repository/base_pagination_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/pagination_params.dart';

class PaginationProvider<U extends IBasePaginationRepository> extends StateNotifier<CursorPaginationBase> {
  final U repository;

  PaginationProvider({required this.repository}) : super(CursorPaginationLoading());


  Future<void> paginate({
    int fetchCount = 20,
    bool fetchMore = false,
    // 강제 다시 로딩
    bool forceRefetch = false,
  }) async {
    try{
      // 5가지 가능성
      // 1) CursorPagination - 정상적으로 데이터가 있는 상태
      // 2) CursorPaginationLoading - 로딩중
      // 3) CursorPaginationError - 에러
      // 4) CursorPaginationRefetch - 첫번쨰 페이지부터 다시 가져옴
      // 5) CursorPaginationFetchMore - 추가 데이터를 pagination 해오라는 요청을 받았을 때

      // 바로 반환 상황
      // 1) hasmore = false 더 가져올 데이터 없음
      if(state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;

        if(!pState.meta.hasMore) {
          return;
        }
      }

      // 2) 로딩중 - fetchMore: true
      //    로딩중인데 fetMore: false 면 그냥 실행, 새로고침의 의도가 있을 수 있다..
      final isLoading = state is CursorPaginationLoading;
      final isRefetch = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      if(fetchMore && (isLoading || isRefetch || isFetchingMore)) {
        return;
      }

      // PaginationParmas 생성
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );

      // fetchMore 데이터 추가로 가져오는 상황
      if (fetchMore) {
        final pState = state as CursorPagination;
        state = CursorPaginationFetchingMore(meta: pState.meta, data: pState.data);

        paginationParams = paginationParams.copyWith(after: pState.data.last.id);
      } else { // 데이터를 처음부터 가져오는 상황
        // 만약에 데이터 있는 상황이면 기존 데이터를 보존한 상태로 API 요청
        if(state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination;
          state = CursorPaginationRefetching(meta: pState.meta, data: pState.data);



        } else {
          state = CursorPaginationLoading();
        }
      }

      final resp = await repository.paginate(paginationParams: paginationParams);

      if(state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;

        // 기존 데이터에 새로운 데이터 추가
        state = resp.copyWith(
            data: [
              ...pState.data,
              ...resp.data
            ]
        );
      } else {
        state = resp;
      }
    } catch(e) {
      state = CursorPaginationError(message: "Data Error");
    }
  }

  // void getDetail({
  //   required String id
  // }) async {
  //   // 만약에 아직 데이터가 하나도 없는 상태라면 (CursorPagination 이 아니라면)
  //   // 데이터를 가져오는 시도를 한다.
  //   if(state is! CursorPagination) {
  //     await this.paginate();
  //   }
  //
  //   // state가 CursorPagination 이 아닐 때 그냥 리턴
  //   if(state is! CursorPagination) {
  //     return;
  //   }
  //
  //   final pState = state as CursorPagination;
  //
  //   final resp = await repository.getRestaurantDetail(id: id);
  //
  //   state = pState.copyWith(
  //       data: pState.data.map<RestaurantModel>((e) => e.id == id ? resp : e).toList()
  //   );
  // }


}