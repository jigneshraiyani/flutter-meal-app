import 'package:flutter/material.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Text("Meal Screen"),
    );
  }
}
