import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studytest/common/view/splash_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref
  });

  List<GoRoute> get routes => [
    GoRoute(
      path: '/splash',
      name: SplashScreen.routeName,
      builder: (context, state) => SplashScreen(),
    )
  ];

  String? redirectLogic(GoRouterState state) {
    final logginIn = state.location == '/login';

    return null;
  }
}