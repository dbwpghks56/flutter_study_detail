import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  // 모든 위젯에 특정 기능을 넣고 싶다면 여기서 넣으면 된다.

  final Widget child;

  const DefaultLayout({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: child,
    );
  }
}
