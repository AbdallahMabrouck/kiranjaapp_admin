import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
  static const String id = "settings";

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Kiranja - Admin Dashboard",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            "Settings",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
