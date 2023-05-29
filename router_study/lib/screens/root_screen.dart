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
        ],
      ),
    );
  }
}
