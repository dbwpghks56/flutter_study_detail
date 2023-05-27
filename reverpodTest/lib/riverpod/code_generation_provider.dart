import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_generation_provider.g.dart';

// 1) 어떤 provider를 사용할지 결정할 고민 할 필요 없도록 만들어준다.


final _testProvider = Provider<String>((ref) => "Hello CodeGeneration");


@riverpod
String gState(GStateRef ref) {
  return "hello code Generation";
}


// 2) Parameter > Family 파라미터를 그대로 일반 함수처럼 사용할 수 있도록