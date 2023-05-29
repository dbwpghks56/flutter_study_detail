import 'package:go_router/go_router.dart';
import 'package:router_study/screens/1_basic_screen.dart';
import 'package:router_study/screens/root_screen.dart';

// https://blog.codefactory.ai -> / -> path
final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) {
          return RootScreen();
      },
      routes: [
        GoRoute(
          path: "basic",
          builder: (context, state) {
            return BasicScreen();
          }
        )
      ]
    ),
  ]
);










