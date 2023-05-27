import 'package:flutter_riverpod/flutter_riverpod.dart';

// 해당 값을 쓰는 곳으로 들어갈 때마다 매번 새로 시작한다. 캐시를 계속 자동으로 삭제한다는 뜻.
final autoDisposeModifierProvider = FutureProvider.autoDispose<List<int>>((ref) async {
  await Future.delayed(Duration(seconds: 2));

  return [1,2,3,4,5];
});