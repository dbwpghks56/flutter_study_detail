import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router_study/layout/default_layout.dart';

class PopReturnScreen extends StatelessWidget {
  const PopReturnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              // pop 하면서 데이터를 전송할 수 있다.
              context.pop("code Factory");
            },
            child: Text(
              "pop"
            ),
          )
        ],
      ),
    );
  }
}
