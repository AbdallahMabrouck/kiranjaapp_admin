import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:kiranjaapp_admin/widgets/sidebar.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  static const String id = "notifications-screen";

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  SideBarWidget sideBar = SideBarWidget();
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Kiranja - Admin Dashboard",
          style: TextStyle(color: Colors.white),
        ),
      ),
      sideBar: sideBar.sideBarMenus(context, NotificationsScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            "Notifications Manage Screen",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
