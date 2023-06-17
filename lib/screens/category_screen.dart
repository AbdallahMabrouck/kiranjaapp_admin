import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';

import '../firebase_services.dart';
import '../widgets/category_list_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  static const String id = "category";

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseService _service = FirebaseService();
  final TextEditingController _catName = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  dynamic image;
  String? fileName;

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
    var ref = storage.ref("categoryImage/$fileName");
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
      String downloadURL =
          await uploadSnapshot.ref.getDownloadURL().then((value) {
        if (value.isNotEmpty) {
          // save data to firestore
          _service.saveCategory(data: {
            "catName": _catName.text,
            "image": "$value.png",
            "active": true,
          }, docName: _catName.text, reference: _service.categories).then(
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
      _catName.clear();
      image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Category Screen",
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
                            ? const Text("Category Image")
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
                width: 20,
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Category Name";
                    }
                    return null;
                  },
                  controller: _catName,
                  decoration: const InputDecoration(
                      label: Text("Enter Category Name"),
                      contentPadding: EdgeInsets.zero),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              TextButton(
                onPressed: clear,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
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
              image == null
                  ? Container()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          saveImageToDb();
                        }
                      },
                      child: const Text(
                        "Save",
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
              "Category List",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CategoryListWidget(
            reference: _service.categories,
          )
        ],
      ),
    );
  }
}
