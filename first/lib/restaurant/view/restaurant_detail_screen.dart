import 'package:dio/dio.dart';
import 'package:first/common/dio/dio.dart';
import 'package:first/common/layout/default_layout.dart';
import 'package:first/product/component/product_card.dart';
import 'package:first/product/model/product_model.dart';
import 'package:first/restaurant/component/restaurant_card.dart';
import 'package:first/restaurant/model/restaurant_detail_model.dart';
import 'package:first/restaurant/repository/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/data.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String id;
  final String title;

  const RestaurantDetailScreen({
    required this.id,
    required this.title,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: title,
      child: FutureBuilder<RestaurantDetailModel>(
        future: ref.watch(restaurantRepositoryProvider).getRestaurantDetail(id: id),
        builder: (_,AsyncSnapshot<RestaurantDetailModel> snapshot) {
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return CustomScrollView(
            slivers: [
              renderTop(snapshot.data!),
              renderLabel(),
              renderProducts(snapshot.data!.products),
            ],
          );
        },
      )
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
      RestaurantDetailModel item
      ) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: item,
        isDetail: true
      ),
    );
  }
}
