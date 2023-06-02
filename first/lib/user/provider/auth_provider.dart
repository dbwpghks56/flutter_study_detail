import 'package:first/user/model/user_model.dart';
import 'package:first/user/provider/user_me_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final uathProvier = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref
  }) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if(previous != next) {
        notifyListeners();
      }
    });
  }

  // Splash Screen
  String? redirectLogic(GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);
    final logginIn = state.location == '/login';

    if(user == null) {
      return logginIn ? null : '/login';
    }

    if(user is UserModel) {
      return logginIn || state.location == '/splash' ? "/" : null;
    }

    if(user is UserModelError) {
      return !logginIn ? '/login' : null;
    }

    return null;
  }
}












