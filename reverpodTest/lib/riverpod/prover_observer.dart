import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue, Object? newValue,
      ProviderContainer container) {
    // 이 class 를 선언한 곳에서 하위의 모든 provider 들이 업데이트 된 경우 불린다.
    print('[provider updated] provider : ${provider}, pv : ${previousValue}, nv : ${newValue}');

  }

  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value, ProviderContainer container) {
    // TODO: implement didAddProvider
    print('[provider added] provider : ${provider}, value: ${value}');
  }

  @override
  void didDisposeProvider(ProviderBase<Object?> provider, ProviderContainer container) {
    // TODO: implement didDisposeProvider
    print('[provider disposed] provider : ${provider}');
  }
}