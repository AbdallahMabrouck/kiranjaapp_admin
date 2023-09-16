/*import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:kiranjaapp_admin/firebase_services.dart';
import 'package:kiranjaapp_admin/widgets/category/category_upload_widget.dart';
import 'package:kiranjaapp_admin/widgets/category/new_category_list_widget.dart';
import '../widgets/sidebar.dart';

class NewCategoryScreen extends StatefulWidget {
  const NewCategoryScreen({super.key});

  static const String id = "new-category-screen";

  @override
  State<NewCategoryScreen> createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  FirebaseService _services = FirebaseService();
  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();
    return AdminScaffold(
        backgroundColor: Colors.grey.shade100,
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
            child: Column(
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
                ),
                const Text("Add New Categories and Sub-Categories"),
                const Divider(
                  thickness: 5,
                ),
                const CategoryUploadWidget(),
                const Divider(
                  thickness: 5,
                ),
                NewCategoryListWidget(
                  reference: _services.category,
                )
              ],
            ),
          ),
        ));
  }
}*/
