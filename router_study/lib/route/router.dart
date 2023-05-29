import 'package:go_router/go_router.dart';
import 'package:router_study/screens/root_screen.dart';

// https://blog.codefactory.ai -> / -> path
final router = GoRouter(
    routes: [
        GoRoute(
            path: "/",
            builder: (context, state) {
                return RootScreen();
            }
        ),
    ]
);