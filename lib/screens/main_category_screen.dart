import 'package:flutter/material.dart';

class MainCategoryScreen extends StatelessWidget {
  const MainCategoryScreen({super.key});

  static const String id = "main-category";

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Main Category Screen",
      style: TextStyle(fontSize: 40),
    );
  }
}
