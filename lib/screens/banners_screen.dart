import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../widgets/banners/banner_widget.dart';
import '../widgets/banners/banner_upload_widget.dart';
import '../widgets/sidebar.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  static const String id = "banner-screen";

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();
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
      sideBar: sideBar.sideBarMenus(context, id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Banners Screen",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
              ),
              Text("Add/Delete Home Screen Banner Images"),
              Divider(
                thickness: 5,
              ),
              // Banners
              BannerWidget(),
              Divider(
                thickness: 5,
              ),
              BannerUploadWidget()
            ],
          ),
        ),
      ),
    );
  }
}
