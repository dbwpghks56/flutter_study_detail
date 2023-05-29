import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router_study/layout/default_layout.dart';

class PopBaseScreen extends StatelessWidget {
  const PopBaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () async {
              final result = await context.push('/pop/return');

              print(result);
            },
            child: Text(
              'Push Pop Return Screen'
            ),
          )
        ],
      ),
    );
  }
}
