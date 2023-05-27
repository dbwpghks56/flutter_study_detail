import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reverpodtest/layout/default_layout.dart';
import 'package:reverpodtest/riverpod/provider.dart';

import '../riverpod/state_nitofier_provider.dart';

class ProviderScreen extends ConsumerWidget {
  const ProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filteredShoppingList);

    return DefaultLayout(
      title: "provider ",
      actions: [
        PopupMenuButton<FilterState>(
            itemBuilder: (_) => FilterState.values.map((e) => PopupMenuItem(
              child: Text(
                e.name
              ),
              value: e,
            )).toList(),
          onSelected: (value) {
              ref.read(filterProvider.notifier).update((state) => value);
          },
        )
      ],
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
      ),
    );
  }
}
