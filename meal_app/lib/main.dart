import 'package:flutter/material.dart';
import 'package:meal_app/theme/app_theme.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main(List<String> args) {
  runApp(ProviderScope(
    child: App(),
    ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: TabsScreen(),
    );
  }
}