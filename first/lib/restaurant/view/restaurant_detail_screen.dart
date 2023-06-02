import 'package:dio/dio.dart';
import 'package:first/common/dio/dio.dart';
import 'package:first/common/layout/default_layout.dart';
import 'package:first/common/model/cursor_pagination_model.dart';
import 'package:first/product/component/product_card.dart';
import 'package:first/product/model/product_model.dart';
import 'package:first/rating/component/rating_card.dart';
import 'package:first/restaurant/component/restaurant_card.dart';
import 'package:first/restaurant/model/restaurant_detail_model.dart';
import 'package:first/restaurant/provider/rating_provider.dart';
import 'package:first/restaurant/provider/restaurant_provider.dart';
import 'package:first/restaurant/repository/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

import '../../common/const/data.dart';
import '../../common/utils/pagination_utils.dart';
import '../../rating/model/rating_model.dart';
import '../model/restaurant_model.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => "restaurantDetail";

  final String id;
  final String title;

  const RestaurantDetailScreen({
    required this.id,
    required this.title,
    Key? key}) : super(key: key);

  @override
  ConsumerState<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends ConsumerState<RestaurantDetailScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    PaginationUtils.paginate(scrollController: scrollController, provider:
    ref.read(ratingProvider(widget.id).notifier));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingState = ref.watch(ratingProvider(widget.id));

    if(state == null) {
      return DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: widget.title,
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          renderTop(state),
          if (state is! RestaurantDetailModel)
            renderLoading(),
          if(state is RestaurantDetailModel)
            renderLabel(),
          if(state is RestaurantDetailModel)
            renderProducts(state.products),
          if(ratingState is CursorPagination<RatingModel>)
            renderRatings(models: ratingState.data),
        ],
      ),
    );
  }

  SliverPadding renderRatings({
    required List<RatingModel> models,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) =>
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: RatingCard.fromModel(model: models[index],),
            ),
          childCount: models.length
        ),
      )
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(3, (index) => Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: SkeletonParagraph(
              style: SkeletonParagraphStyle(
                lines: 5,
                padding: EdgeInsets.zero
              ),
            ),
          ))
        )
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
                child: ProductCard.fromProductModel(model: productModels[index]),
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
