import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router_study/layout/default_layout.dart';

class Transition2Screen extends StatelessWidget {
  const Transition2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Container(
        color: Colors.green,
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: Text("pop"),
            )
          ],
        ),
      ),
    );
  }
}
