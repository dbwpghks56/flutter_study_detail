import 'package:first/common/view/root_tab.dart';
import 'package:first/common/view/splash_screen.dart';
import 'package:first/order/view/order_done_screen.dart';
import 'package:first/restaurant/view/basket_screen.dart';
import 'package:first/restaurant/view/restaurant_detail_screen.dart';
import 'package:first/user/model/user_model.dart';
import 'package:first/user/provider/user_me_provider.dart';
import 'package:first/user/view/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
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

  List<GoRoute> get routes => [
    GoRoute(
      path: '/',
      name: RootTab.routeName,
      builder: (_,state) => RootTab(),
      routes: [
        GoRoute(
          path: 'restaurant/:rid/:rtitle',
          name: RestaurantDetailScreen.routeName,
          builder: (_, state) => RestaurantDetailScreen(
              id: state.pathParameters['rid']!,
              title: state.pathParameters['rtitle']!
          ),
        )
      ]
    ),
    GoRoute(
      path: '/basket',
      name: BasketScreen.routeName,
      builder: (_,state) => BasketScreen(),
    ),
    GoRoute(
      path: '/order_done',
      name: OrderDoneScreen.routeName,
      builder: (_,state) => OrderDoneScreen(),
    ),
    GoRoute(
      path: '/splash',
      name: SplashScreen.routeName,
      builder: (_,state) => SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: LoginScreen.routeName,
      builder: (_,state) => LoginScreen(),
    ),

  ];

  void logout() {
    ref.read(userMeProvider.notifier).logout();
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












