import 'package:first/product/model/basket_item_model.dart';
import 'package:first/product/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  BasketProvider() : super([]);

  Future<void> addToBasket({
    required ProductModel productModel,
  }) async {
    // 아직 장바구니에 해당되는 상품이 없다면 장바구니에 상품을 추가
    // 상품이 존재한다면 장바구니에 있는 값에 플러스를 한다.

    final exists = state.firstWhereOrNull((e) => e.productModel.id == productModel.id)
        != null;

    if(exists) {
      state = state.map((e) => e.productModel.id == productModel.id ?
        e.copyWith(count: e.count + 1) : e).toList();
    } else {
      state = [
        ...state,
        BasketItemModel(
            productModel: productModel,
            count: 1
        )
      ];
    }
  }

  Future<void> removeFromBasket({
    required ProductModel productModel,
    // true면 count 상관 없이 전부 삭제
    bool isDelete = false
  }) async {
    // 장바구니에 상품이 존재할 때 상품의 카운트가 1보다 크면 -1, 상품의 카운트가 1이면 삭제
    // 상품이 존재하지 않으면 즉시 함수를 반환 후 낫띵
    final exists = state.firstWhereOrNull((e) => e.productModel.id == productModel.id)
        != null;

    if(!exists) {
      return;
    }

    final existsProduct = state.firstWhere((element) {
      return element.productModel.id == productModel.id;
    });

    if(existsProduct.count > 1) {
      state = state.map(
              (e) => e.productModel.id == productModel.id ?
              e.copyWith(count: e.count + 1): e).toList();
    } else if(existsProduct.count == 1 || isDelete) {
      state = state.where((element) => element.productModel.id != productModel.id).toList();
    }

  }
}












