import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reverpodtest/layout/default_layout.dart';
import 'package:reverpodtest/riverpod/autodispose_modifer_provider.dart';

class AutodisposeModifierScreen extends ConsumerWidget {
  const AutodisposeModifierScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(autoDisposeModifierProvider);

    return DefaultLayout(
      title: "autodispose",
      body: Center(
        child: state.when(
            data: (data) {
              return Text(
                data.toString()
              );
            },
            error: (error, stack ) {},
            loading: () => CircularProgressIndicator()
        )
      ),
    );
  }
}
