import 'package:flutter/material.dart';
import 'package:reverpodtest/layout/default_layout.dart';
import 'package:reverpodtest/screen/state_provider_screen.dart';

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
          ],
        )
    );
  }
}
