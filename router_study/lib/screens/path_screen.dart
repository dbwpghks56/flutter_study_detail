import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router_study/layout/default_layout.dart';

class PathScreen extends StatelessWidget {
  const PathScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          Text(
            'Path Paran ${GoRouterState.of(context).pathParameters}'
          ),
          ElevatedButton(
            onPressed: () {
              context.go("/path_param/123/cool");
            },
            child: Text(
              "Go One More"
            ),
          )
        ],
      ),
    );
  }
}
