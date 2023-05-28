import 'package:first/common/component/pagination_list_view.dart';
import 'package:first/restaurant/component/restaurant_card.dart';
import 'package:first/restaurant/provider/restaurant_provider.dart';
import 'package:first/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

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















