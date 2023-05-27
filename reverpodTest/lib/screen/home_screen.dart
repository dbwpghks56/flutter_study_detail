import 'package:flutter/material.dart';
import 'package:reverpodtest/layout/default_layout.dart';
import 'package:reverpodtest/screen/future_provider_screen.dart';
import 'package:reverpodtest/screen/state_notifier_provider_screen.dart';
import 'package:reverpodtest/screen/state_provider_screen.dart';
import 'package:reverpodtest/screen/stream_provider_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: 'Home Screen',
        body: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => StateProviderScreen()));
              },
              child: Text(
                'StateProviderScreen'
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => StateNotifierProviderScreen()));
              },
              child: Text(
                  'StateNotifierProvider'
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => FutureProviderScreen()));
              },
              child: Text(
                  'Future Provider Screen'
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => StreamProviderScreen()));
              },
              child: Text(
                  'Stream Provider Screen'
              ),
            ),
          ],
        )
    );
  }
}
