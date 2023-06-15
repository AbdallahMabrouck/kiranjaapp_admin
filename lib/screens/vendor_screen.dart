import 'package:flutter/material.dart';

class VendorScreen extends StatelessWidget {
  const VendorScreen({super.key});

  static const String id = "vendor";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(10),
      child: const Text(
        "Vendor Screen",
        style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
      ),
    );
  }
}
