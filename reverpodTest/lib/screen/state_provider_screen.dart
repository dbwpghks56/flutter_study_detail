import 'package:flutter/material.dart';
import 'package:reverpodtest/layout/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/state_provider_screen.dart';

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numberProvider);

    return DefaultLayout(
        title: 'StateProviderScreen',
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                provider.toString(),
              ),
              ElevatedButton(
                  onPressed: () {
                    ref.read(numberProvider.notifier).update((state) => state + 1);
                  },
                  child: Text(
                    'Up'
                  ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => _NextScreen()));
                },
                child: Text(
                  'Go Next'
                )
              )
            ],
          ),
        )
    );
  }
}

class _NextScreen extends ConsumerWidget {
  const _NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numberProvider);

    return DefaultLayout(
        title: 'StateProviderScreen',
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                provider.toString(),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(numberProvider.notifier).update((state) => state + 1);
                },
                child: Text(
                    'Up'
                ),
              )
            ],
          ),
        )
    );
  }
}













