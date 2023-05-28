import 'package:dio/dio.dart';
import 'package:first/common/dio/dio.dart';
import 'package:first/common/model/cursor_pagination_model.dart';
import 'package:first/restaurant/component/restaurant_card.dart';
import 'package:first/restaurant/model/restaurant_model.dart';
import 'package:first/restaurant/provider/restaurant_provider.dart';
import 'package:first/restaurant/repository/restaurant_repository.dart';
import 'package:first/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/data.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantProvider);

    if (data is CursorPaginationLoading) {
      return Center(child: CircularProgressIndicator());
    }

    final cp = data as CursorPagination;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        itemCount: cp.data.length,
        itemBuilder: (_, index) {
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















