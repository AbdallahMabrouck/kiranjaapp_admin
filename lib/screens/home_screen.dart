import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../widgets/sidebar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String id = "home-screen";

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();

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
      sideBar: sideBar.sideBarMenus(context, HomeScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            "Dashboard",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
