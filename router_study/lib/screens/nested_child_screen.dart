import 'package:flutter/material.dart';

class NestedChildScreen extends StatelessWidget {
  final String routeName;

  const NestedChildScreen({required this.routeName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(routeName),
    );
  }
}
