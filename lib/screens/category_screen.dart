import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const String id = "category";

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Category Screen",
      style: TextStyle(fontSize: 40),
    );
  }
}
