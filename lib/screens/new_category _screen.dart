import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:kiranjaapp_admin/widgets/vendors/vendor_data_table.dart';
import '../widgets/sidebar.dart';

class NewCategoryScreen extends StatefulWidget {
  const NewCategoryScreen({super.key});

  static const String id = "new-category-screen";

  @override
  State<NewCategoryScreen> createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
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
        sideBar: sideBar.sideBarMenus(context, NewCategoryScreen.id),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Column(
              children: [
                Text(
                  "Categories",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
                ),
                Text(
                  "Manage Vendors",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
                ),
                Text("Manage all Vendors activities"),
                Divider(
                  thickness: 5,
                ),
                VendorDataTable(),
                Divider(
                  thickness: 5,
                ),
              ],
            ),
          ),
        ));
  }
}
