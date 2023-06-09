import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reverpodtest/layout/default_layout.dart';
import 'package:reverpodtest/riverpod/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state1 = ref.watch(gStateProvider);
    final state2 = ref.watch(gStateFutureProvider);
    final state3 = ref.watch(gStateFuture2Provider);
    final state4 = ref.watch(gStateMultiplyProvider(number1: 3, number2: 4));

    return DefaultLayout(
      title: "codegeneration",
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            state1,
            textAlign: TextAlign.center,
          ),
          state2.when(
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
          ),
          state3.when(
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
          ),
          Text(
            state4.toString(),
            textAlign: TextAlign.center,
          ),
          // 전체 위젯을 빌드 하는 것이 아니라 원하는 위젯만 부분적으로 빌드할 수 있다.
          Consumer(
              builder: (context, ref, child) {
                final state5 = ref.watch(gStateNotifierProvider);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state5.toString(),
                      textAlign: TextAlign.center,
                    ),
                    child!,
                  ],
                );
              },
              child: Text('Hello'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(gStateNotifierProvider.notifier).increment();
            },
            child: Text("up"),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(gStateNotifierProvider.notifier).decrement();
            },
            child: Text("down"),
          ),
          // invalidate 유효하지 않게 하다.
          ElevatedButton(
            onPressed: () {
              ref.invalidate(gStateNotifierProvider);
            },
            child: Text("invalidate"),
          )
        ],
      ),
    );
  }
}

class _State5Widget extends ConsumerWidget {
  const _State5Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state5 = ref.watch(gStateNotifierProvider);

    return Text(
      state5.toString(),
      textAlign: TextAlign.center,
    );
  }
}








