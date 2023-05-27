import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reverpodtest/layout/default_layout.dart';
import 'package:reverpodtest/riverpod/future_provider.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(multiplesFutureProvider);

    return DefaultLayout(
      title: 'Future Provider Screen',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          state.when(
              data: (data) {
                return Text(
                  data.toString(),
                  textAlign: TextAlign.center,
                );
              },
              error: (err, stack) {
                return Text(err.toString());
              },
              loading: () {
                return Center(
                    child: CircularProgressIndicator());
              },
          )
        ],
      ),
    );
  }
}
