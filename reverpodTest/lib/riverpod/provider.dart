import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reverpodtest/model/shopping_item_model.dart';
import 'package:reverpodtest/riverpod/state_nitofier_provider.dart';

final filteredShoppingList = Provider<List<ShoppingItemModel>>((ref) {
  final shoppingList = ref.watch(shoppingListProvider);
  final filterState = ref.watch(filterProvider);

  if(filterState == FilterState.all) {
    return shoppingList;
  }

  return shoppingList.where((element) => filterState == FilterState.spicy ? element.isSpicy : !element.isSpicy)
      .toList();
});

enum FilterState{
  notSpicy,
  spicy,
  all,
}

final filterProvider = StateProvider<FilterState>((ref) => FilterState.all);