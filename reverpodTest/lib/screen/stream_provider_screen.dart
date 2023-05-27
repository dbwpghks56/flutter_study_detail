import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reverpodtest/layout/default_layout.dart';
import 'package:reverpodtest/riverpod/stream_provider.dart';

class StreamProviderScreen extends ConsumerWidget {
  const StreamProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(multiplesStreamProvider);

    return DefaultLayout(
      title: 'Stream Provider',
      body: Center(
        child: state.when(
            data: (data) {
              return Text(
                data.toString(),
                textAlign: TextAlign.center,
              );
            },
            error: (error, stack) {

            },
            loading: () => CircularProgressIndicator()
        ),
      )
    );
  }
}
