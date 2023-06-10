import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studytest/common/view/splash_screen.dart';

import '../../user/provider/auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final provider = ref.read(authProvider);

  return GoRouter(
    routes: provider.routes,
    initialLocation: SplashScreen.routeName,
    refreshListenable: provider,
    redirect: (context, state) {
      return provider.redirectLogic(state);
    },
  );
});