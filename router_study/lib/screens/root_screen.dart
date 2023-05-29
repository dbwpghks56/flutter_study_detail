import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router_study/layout/default_layout.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              context.go('/basic');
            },
            child: Text("Go Basic"),
          ),
          ElevatedButton(
            onPressed: () {
              context.goNamed('named_screen');
            },
            child: Text("Go Named"),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/push');
            },
            child: Text("Go Push"),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/pop');
            },
            child: Text("Go pop"),
          ),
          ElevatedButton(
            onPressed: () {
              context.go("/path_param/123");
            },
            child: Text(
                "Go Path"
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go("/query_param");
            },
            child: Text(
                "Go Query"
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go("/nested/a");
            },
            child: Text(
                "Go Nested"
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go("/login");
            },
            child: Text(
                "Go Login"
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go("/login2");
            },
            child: Text(
                "Go Login2"
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go("/transition");
            },
            child: Text(
                "Go Transition"
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go("/error");
            },
            child: Text(
                "Go Error"
            ),
          ),
        ],
      ),
    );
  }
}
