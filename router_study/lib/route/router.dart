import 'package:go_router/go_router.dart';
import 'package:router_study/screens/1_basic_screen.dart';
import 'package:router_study/screens/named_screen.dart';
import 'package:router_study/screens/pop_base_screen.dart';
import 'package:router_study/screens/pop_return_screen.dart';
import 'package:router_study/screens/push_screen.dart';
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
        ),
        GoRoute(
          path: "named",
          name: "named_screen",
          builder: (context, state) {
            return NamedScreen();
          }
        ),
        GoRoute(
          path: "push",
          builder: (context, state) {
            return PushScreen();
          }
        ),
        GoRoute(
          path: "pop",
          builder: (context, state) {
            return PopBaseScreen();
          },
          routes: [
            GoRoute(
              path: "return",
              builder: (context, state) {
                return PopReturnScreen();
              }
            )
          ]
        ),
      ]
    ),
  ]
);










