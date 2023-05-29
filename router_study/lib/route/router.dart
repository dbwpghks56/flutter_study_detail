import 'package:go_router/go_router.dart';
import 'package:router_study/screens/1_basic_screen.dart';
import 'package:router_study/screens/named_screen.dart';
import 'package:router_study/screens/nested_child_screen.dart';
import 'package:router_study/screens/nested_screen.dart';
import 'package:router_study/screens/path_screen.dart';
import 'package:router_study/screens/pop_base_screen.dart';
import 'package:router_study/screens/pop_return_screen.dart';
import 'package:router_study/screens/push_screen.dart';
import 'package:router_study/screens/query_screen.dart';
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
        GoRoute(
          // 주소에 : 을 넣으면 값을 뒤에있는 값의 이름으로 변수로 받을 수 있음 ex) id변수
          path: "path_param/:id",
          builder: (context, state) {
            return PathScreen();
          },
          routes: [
            GoRoute(
              path: ":name",
              builder: (context, state) {
                return PathScreen();
              }
            )
          ]
        ),
        GoRoute(
          path: "query_param",
          builder: (context, state) {
            return QueryScreen();
          }
        ),
        ShellRoute(
          builder: (context, state, child) {
            return NestedScreen(child: child);
          },
          routes: [
            GoRoute(
              path: "nested/a",
              builder: (_, state) {
                return NestedChildScreen(routeName: "nested/a");
              }
            ),
            GoRoute(
                path: "nested/b",
                builder: (_, state) {
                  return NestedChildScreen(routeName: "nested/b");
                }
            ),
            GoRoute(
                path: "nested/c",
                builder: (_, state) {
                  return NestedChildScreen(routeName: "nested/c");
                }
            )
          ]
        )
      ]
    ),
  ]
);










