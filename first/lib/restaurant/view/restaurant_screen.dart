import 'package:dio/dio.dart';
import 'package:first/common/dio/dio.dart';
import 'package:first/common/model/cursor_pagination_model.dart';
import 'package:first/common/utils/pagination_utils.dart';
import 'package:first/restaurant/component/restaurant_card.dart';
import 'package:first/restaurant/model/restaurant_model.dart';
import 'package:first/restaurant/provider/restaurant_provider.dart';
import 'package:first/restaurant/repository/restaurant_repository.dart';
import 'package:first/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/data.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    PaginationUtils.paginate(scrollController: scrollController, provider:
    ref.read(restaurantProvider.notifier));
    // // 현재 위치가 최대 길이보다 조금 덜 되는 위치라면 새로운 데이터 추가요청(지금은 300pixel)
    // if (scrollController.offset > scrollController.position.maxScrollExtent - 300) {
    //   ref.read(restaurantProvider.notifier).paginate(
    //       fetchMore: true
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(restaurantProvider);

    // 완전 첫 로딩
    if (data is CursorPaginationLoading) {
      return Center(child: CircularProgressIndicator());
    }

    // 에러
    if(data is CursorPaginationError) {
      return Center(
        child: Text(
          data.message
        ),
      );
    }

    final cp = data as CursorPagination;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: scrollController,
        itemCount: cp.data.length + 1,
        itemBuilder: (_, index) {
          if(index == cp.data.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Center(
                child: data is CursorPaginationFetchingMore ?
                CircularProgressIndicator() : Text("Last Data"),
              ),
            );
          }
          
          final pItem = cp.data[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => RestaurantDetailScreen(id: pItem.id,title: pItem.name,))
              );
            },
            child: RestaurantCard.fromModel(
              model: pItem,
            ),
          );
        },
        // 각 아이템 사이사이에 들어갈 것을 정의
        separatorBuilder: (_, index) {
          return SizedBox(height: 16.0,);
        },
      )
    );
  }
}















