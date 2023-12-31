import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';
import '../firebase_services.dart';
import '../widgets/category_list_widget.dart';
import '../widgets/sidebar.dart';

class SubCategoryScreen extends StatefulWidget {
  static const String id = "sub-category";

  const SubCategoryScreen({super.key});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  SideBarWidget sideBar = SideBarWidget();
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseService _service = FirebaseService();
  final TextEditingController _subCatName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  dynamic image;
  String? fileName;
  Object? _selectedValue;
  bool _noCategorySelected = false;
  QuerySnapshot? snapshot;

  Widget _dropDownButton() {
    return DropdownButton(
      value: _selectedValue,
      hint: const Text("Select Main Category"),
      items: snapshot!.docs.map((e) {
        return DropdownMenuItem<String>(
          value: e["mainCategory"],
          child: Text(
            e["mainCategory"],
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

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null) {
      setState(() {
        image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    } else {
      // failed to pick image or user cancelled
      print("Cancelled or Failed");
    }
  }

  saveImageToDb() async {
    EasyLoading.show();
    var ref = storage.ref("subCategoryImage/$fileName");
    try {
      String? mimiType = mime(
        basename(fileName!),
      );
      await ref.putData(image);
      var metaData = firebase_storage.SettableMetadata(contentType: mimiType);
      firebase_storage.TaskSnapshot uploadSnapshot =
          await ref.putData(image, metaData);
      // image will upload to firebase storage
      // need to get the download link of that image to save in firestore
      // String downloadURL =
      await uploadSnapshot.ref.getDownloadURL().then((value) {
        if (value.isNotEmpty) {
          // save data to firestore
          _service.saveCategory(data: {
            "subCatName": _subCatName.text,
            "mainCategory": _selectedValue,
            "image": "$value.png",
            "active": true,
          }, docName: _subCatName.text, reference: _service.subCat).then(
              (value) {
            // after save clear all data from the screen
            clear();
            EasyLoading.dismiss();
          });
        }
        return value;
      });
    } on FirebaseException catch (e) {
      clear();
      EasyLoading.dismiss();
      print(e.toString());
    }
  }

  clear() {
    setState(() {
      _subCatName.clear();
      image = null;
    });
  }

  @override
  void initState() {
    getMainCatList();
    super.initState();
  }

  getMainCatList() {
    return _service.mainCat.get().then((QuerySnapshot querySnapshot) {
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
      sideBar: sideBar.sideBarMenus(context, SubCategoryScreen.id),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Sub Categories",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey.shade800),
                        ),
                        child: Center(
                            child: image == null
                                ? const Text("Sub Category Image")
                                : Image.memory(image)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: pickImage,
                        child: const Text("Upload Image"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      snapshot == null
                          ? const Text("Loading..")
                          : _dropDownButton(),
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
                              return "Enter Sub Category Name";
                            }
                            return null;
                          },
                          controller: _subCatName,
                          decoration: const InputDecoration(
                              label: Text("Enter Sub Category Name"),
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
                                BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          // save button should show only if image not equal to null after image selected
                          // its better if images are png files
                          if (image != null)
                            ElevatedButton(
                              onPressed: () {
                                if (_selectedValue == null) {
                                  setState(() {
                                    _noCategorySelected = true;
                                  });
                                  return;
                                }
                                if (_formKey.currentState!.validate()) {
                                  saveImageToDb();
                                }
                              },
                              child: const Text(
                                "   Save   ",
                              ),
                            ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const Divider(
                color: Colors.grey,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Sub Category List",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CategoryListWidget(
                reference: _service.subCat,
              )
            ],
          ),
        ),
      ),
    );
  }
}
