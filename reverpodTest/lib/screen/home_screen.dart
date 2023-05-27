import 'package:flutter/material.dart';
import 'package:reverpodtest/layout/default_layout.dart';
import 'package:reverpodtest/screen/autodispose_modifier_screen.dart';
import 'package:reverpodtest/screen/code_generation_screen.dart';
import 'package:reverpodtest/screen/family_modifier_screen.dart';
import 'package:reverpodtest/screen/future_provider_screen.dart';
import 'package:reverpodtest/screen/listen_provider_screen.dart';
import 'package:reverpodtest/screen/provider_screen.dart';
import 'package:reverpodtest/screen/select_provider_screen.dart';
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
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => FamilyModifierScreen()));
              },
              child: Text(
                  'Family Provider Screen'
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => AutodisposeModifierScreen()));
              },
              child: Text(
                  'audo Provider Screen'
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => ListenProviderScreen()));
              },
              child: Text(
                  'listen Provider Screen'
              ),
            ),ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => SelectProviderScreen()));
              },
              child: Text(
                  'select Provider Screen'
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProviderScreen()));
              },
              child: Text(
                  'Provider Screen'
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => CodeGenerationScreen()));
              },
              child: Text(
                  'code generation Screen'
              ),
            ),
          ],
        )
    );
  }
}
