import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reverpodtest/layout/default_layout.dart';
import 'package:reverpodtest/model/shopping_item_model.dart';
import 'package:reverpodtest/riverpod/state_nitofier_provider.dart';

class StateNotifierProviderScreen extends ConsumerWidget {
  const StateNotifierProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ShoppingItemModel> state = ref.watch(shoppingListProvider);

    return DefaultLayout(
      title: 'State Notifier Provider',
      body: ListView(
        children: state.map((e) =>
          CheckboxListTile(
            value: e.hasBought,
            onChanged: (value) {
              ref.read(shoppingListProvider.notifier).toggleHasBought(name: e.name);
            },
            title: Text(e.name),
          )
        ).toList(),
      ));
  }
}
