import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kiranjaapp_admin/firebase_services.dart';

import '../widgets/main_category_list_widget.dart';
import '../widgets/sidebar.dart';

class MainCategoryScreen extends StatefulWidget {
  static const String id = "main-category";

  const MainCategoryScreen({super.key});

  @override
  State<MainCategoryScreen> createState() => _MainCategoryScreenState();
}

class _MainCategoryScreenState extends State<MainCategoryScreen> {
  SideBarWidget sideBar = SideBarWidget();
  final FirebaseService _service = FirebaseService();
  final TextEditingController _mainCat = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Object? _selectedValue;
  bool _noCategorySelected = false;
  QuerySnapshot? snapshot;

  Widget _dropDownButton() {
    return DropdownButton(
      value: _selectedValue,
      hint: const Text("Select Category"),
      items: snapshot!.docs.map((e) {
        return DropdownMenuItem<String>(
          value: e["catName"],
          child: Text(
            e["catName"],
          ),
        );
      }).toList(),
      onChanged: (selectedCat) {
        setState(() {
          _selectedValue = selectedCat;
          _noCategorySelected = false;
        });
      },
    );
  }

  clear() {
    setState(() {
      _selectedValue = null;
      _mainCat.clear();
    });
  }

  @override
  void initState() {
    getCatList();
    super.initState();
  }

  getCatList() {
    return _service.categories.get().then((QuerySnapshot querySnapshot) {
      setState(() {
        snapshot = querySnapshot;
      });
    });
  }

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
      sideBar: sideBar.sideBarMenus(context, MainCategoryScreen.id),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 8, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "Main Categories",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                snapshot == null ? const Text("Loading..") : _dropDownButton(),
                const SizedBox(
                  height: 8,
                ),
                if (_noCategorySelected == true)
                  const Text(
                    "No Category Selected",
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Main Category Name";
                      }
                      return null;
                    },
                    controller: _mainCat,
                    decoration: const InputDecoration(
                        label: Text("Enter Category Name"),
                        contentPadding: EdgeInsets.zero),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: clear,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        side: MaterialStateProperty.all(
                          BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_selectedValue == null) {
                          setState(() {
                            _noCategorySelected = true;
                          });
                          return;
                        }
                        if (_formKey.currentState!.validate()) {
                          EasyLoading.show();
                          _service.saveCategory(
                            data: {
                              // dropdown value
                              "category": _selectedValue,
                              // textFormFied Value
                              "mainCategory": _mainCat.text,
                              "approved": true,
                            },
                            reference: _service.mainCat,
                            docName: _mainCat.text,
                          ).then(
                            (value) {
                              clear();
                              EasyLoading.dismiss();
                            },
                          );
                        }
                      },
                      child: const Text(
                        "   Save   ",
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "Main Category List",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const MainCategoryListWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
