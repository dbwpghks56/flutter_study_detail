import 'package:dio/dio.dart';
import 'package:first/common/component/pagination_list_view.dart';
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

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: restaurantProvider,
      itemBuilder: <RestaurantModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => RestaurantDetailScreen(id: model.id,title: model.name,))
            );
          },
          child: RestaurantCard.fromModel(
            model: model,
          ),
        );
      },
    );
  }
}















