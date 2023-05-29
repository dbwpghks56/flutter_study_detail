import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router_study/layout/default_layout.dart';

class PushScreen extends StatelessWidget {
  const PushScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              context.push("/basic");
            },
            child: Text(
              "push Basic"
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go("/basic");
            },
            child: Text(
                "go Basic"
            ),
          )
        ],
      ),
    );
  }
}
