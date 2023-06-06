import 'package:first/common/component/custom_text_form_field.dart';
import 'package:first/common/provider/go_router.dart';
import 'package:first/common/view/splash_screen.dart';
import 'package:first/user/repository/auth_repository.dart';
import 'package:first/user/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
        child: _App()
    )
  );
}

class _App extends ConsumerWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    // goROuter 업데이트된 버전으로 쓰는 법
    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'NotoSans'
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
