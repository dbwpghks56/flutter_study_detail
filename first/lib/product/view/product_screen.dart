import 'package:first/common/component/pagination_list_view.dart';
import 'package:first/product/component/product_card.dart';
import 'package:first/product/model/product_list_model.dart';
import 'package:first/product/model/product_model.dart';
import 'package:first/product/provider/product_provider.dart';
import 'package:first/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductListModel>(
        provider: productProvider,
        itemBuilder: <ProductListModel>(_, index, model) {
          return GestureDetector(
            onTap: () {
              context.goNamed(RestaurantDetailScreen.routeName,
              pathParameters: {
                "rid" : model.restaurant.id,
                "rtitle" : model.restaurant.name
              });
            },
            child: ProductCard.fromProductListModel(listModel: model)
          );
        }
    );
  }
}
