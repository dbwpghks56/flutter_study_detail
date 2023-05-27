import 'package:flutter/material.dart';
import 'package:reverpodtest/screen/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: HomeScreen(),
      )
    )
  );
}



