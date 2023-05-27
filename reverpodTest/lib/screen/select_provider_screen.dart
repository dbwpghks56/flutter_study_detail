import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reverpodtest/layout/default_layout.dart';
import 'package:reverpodtest/riverpod/select_provider.dart';

class SelectProviderScreen extends ConsumerWidget {
  const SelectProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("build");

    // 하나만 선택해서 가져올 수 있다.
    final state = ref.watch(selectProvider.select((value) => value.isSpicy));
    ref.listen(selectProvider.select((value) => value.hasBought), (previous, next) {
      print(next);
    });

    return DefaultLayout(
      title: "select",
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   state.name
            // ),
            // Text(
            //   state.hasBought.toString()
            // ),
            Text(
              state.toString()
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(selectProvider.notifier).toggleHasBought();
              },
              child: Text(
                'Bought toggle'
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(selectProvider.notifier).toggleIsSpicy();
              },
              child: Text(
                  'Spicy toggle'
              ),
            )
          ],
        ),
      ),
    );
  }
}
