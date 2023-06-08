import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:first/product/model/basket_item_model.dart';
import 'package:first/product/model/patch_basket_body.dart';
import 'package:first/product/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

import '../../product/model/product_list_model.dart';
import '../repository/user_me_repository.dart';

final basketProvider = StateNotifierProvider<BasketProvider, List<BasketItemModel>>
  ((ref) {
    final repository = ref.watch(userMeRepositoryProvider);
    return BasketProvider(
      repository: repository
    );
});

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  final UserMeRepository repository;
  final updateBasketDebounce = Debouncer(
    Duration(seconds: 1),
    initialValue: null,
    checkEquality: false
  );

  BasketProvider({required this.repository}) : super([]) {
    updateBasketDebounce.values.listen((event) {
      patchBasket();
    });
  }

  Future<void> patchBasket() async {
    repository.patchBasket(
      body: BasketBody(
        basketBodyBasket: state.map((e) {
          return PathBasketBodyBasket(
              productId: e.productModel.id,
              count: e.count
          );
        }).toList()
      )
    );
  }

  Future<void> addToBasket({
    required ProductListModel productModel,
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

    // Optimistic Response (긍정적 응답)
    // 응답이 성공할 것이라고 가정하고 상태를 먼저 업데이트한다.
    // await patchBasket();
    updateBasketDebounce.setValue(null);
  }

  Future<void> removeFromBasket({
    required ProductListModel productModel,
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
              e.copyWith(count: e.count - 1): e).toList();
    } else if(existsProduct.count == 1 || isDelete) {
      state = state.where((element) => element.productModel.id != productModel.id).toList();
    }

    // await patchBasket();
    updateBasketDebounce.setValue(null);
  }
}












