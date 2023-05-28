import 'package:dio/dio.dart';
import 'package:first/common/dio/dio.dart';
import 'package:first/common/layout/default_layout.dart';
import 'package:first/product/component/product_card.dart';
import 'package:first/product/model/product_model.dart';
import 'package:first/restaurant/component/restaurant_card.dart';
import 'package:first/restaurant/model/restaurant_detail_model.dart';
import 'package:first/restaurant/provider/restaurant_provider.dart';
import 'package:first/restaurant/repository/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/data.dart';
import '../model/restaurant_model.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String id;
  final String title;

  const RestaurantDetailScreen({
    required this.id,
    required this.title,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(restaurantDetailProvider(id));

    if(state == null) {
      return DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: title,
      child: CustomScrollView(
        slivers: [
          renderTop(state),
          // renderLabel(),
          // renderProducts(state),
        ],
      ),
    );
  }

  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }

  SliverPadding renderProducts(
      List<ProductModel> productModels
      ) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
            (contex, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ProductCard(productModel: productModels[index]),
              );
            },
          childCount: productModels.length
        )
      ),
    );
  }

  SliverToBoxAdapter renderTop(
      RestaurantModel item
      ) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: item,
        isDetail: true
      ),
    );
  }
}
