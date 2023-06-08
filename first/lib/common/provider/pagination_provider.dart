import 'package:first/common/model/cursor_pagination_model.dart';
import 'package:first/common/model/model_with_id.dart';
import 'package:first/common/repository/base_pagination_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:debounce_throttle/debounce_throttle.dart';
import '../model/pagination_params.dart';

class _PaginationInfo{
  final int fetchCount;
  final bool fetchMore;
  // 강제 다시 로딩
  final bool forceRefetch;

  _PaginationInfo({this.fetchCount = 20,
    this.fetchMore=false,
    this.forceRefetch=false});
}


class PaginationProvider<
  T extends IModelWithId,
  U extends IBasePaginationRepository<T>> extends StateNotifier<CursorPaginationBase> {
  final U repository;

  final paginationThrottle = Throttle(
    Duration(seconds: 3),
    initialValue: _PaginationInfo(),
    checkEquality: false
  );

  PaginationProvider({required this.repository}) : super(CursorPaginationLoading()) {
    paginate();

    paginationThrottle.values.listen((event) {
      _throttledPagination(event);
    });
  }


  Future<void> paginate({
    int fetchCount = 20,
    bool fetchMore = false,
    // 강제 다시 로딩
    bool forceRefetch = false,
  }) async {
    paginationThrottle.setValue(_PaginationInfo(
      fetchMore: fetchMore,
      fetchCount: fetchCount,
      forceRefetch: forceRefetch
    ));
  }

  _throttledPagination(_PaginationInfo info) async {
    final fetchCount = info.fetchCount;
    final fetchMore = info.fetchMore;
    final forceRefetch = info.forceRefetch;

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
        final pState = state as CursorPagination<T>;
        state = CursorPaginationFetchingMore(
            meta: pState.meta,
            data: pState.data
        );

        paginationParams = paginationParams.copyWith(
            after: pState.data.last.id
        );

      } else { // 데이터를 처음부터 가져오는 상황
        // 만약에 데이터 있는 상황이면 기존 데이터를 보존한 상태로 API 요청
        if(state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination<T>;
          state = CursorPaginationRefetching<T>(meta: pState.meta, data: pState.data);

        } else {
          state = CursorPaginationLoading();
        }
      }

      final resp = await repository.paginate(paginationParams: paginationParams);

      if(state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore<T>;

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
    } catch(e, stack) {
      print(e);
      print(stack);
      state = CursorPaginationError(message: "Data Error");
    }
  }


}













