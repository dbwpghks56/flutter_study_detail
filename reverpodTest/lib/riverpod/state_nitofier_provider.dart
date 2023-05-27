import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reverpodtest/model/shopping_item_model.dart';

final shoppingListProvider = StateNotifierProvider<ShoppingListNotifer, List<ShoppingItemModel>>
  ((ref) => ShoppingListNotifer());

class ShoppingListNotifer extends StateNotifier<List<ShoppingItemModel>> {
  ShoppingListNotifer() : super([
    ShoppingItemModel(name: "김치", quantity: 3, hasBought: false, isSpicy: true),
    ShoppingItemModel(name: "라면", quantity: 5, hasBought: false, isSpicy: true),
    ShoppingItemModel(name: "삼겹살", quantity: 10, hasBought: false, isSpicy: false),
    ShoppingItemModel(name: "수박", quantity: 2, hasBought: false, isSpicy: false),
    ShoppingItemModel(name: "카스테라", quantity: 5, hasBought: false, isSpicy: false),
  ]); // 빈값으로 초기화 가능

  void toggleHasBought({
    required String name
  }) {
    state = state.map((e) => e.name == name ? ShoppingItemModel(
        name: e.name,
        quantity: e.quantity,
        hasBought: !e.hasBought,
        isSpicy: e.isSpicy
      ) : e
    ).toList();
  }

}