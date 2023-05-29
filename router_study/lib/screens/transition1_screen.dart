import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router_study/layout/default_layout.dart';

class Transition1Screen extends StatelessWidget {
  const Transition1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Container(
        color: Colors.blueGrey,
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/transition/detail');
              },
              child: Text(
                "Go detail"
              ),
            )
          ],
        ),
      ),
    );
  }
}
