import 'dart:html';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
// import 'package:firebase/firebase.dart' as fb;
import '../../firebase_services.dart';

class CategoryUploadWidget extends StatefulWidget {
  const CategoryUploadWidget({super.key});

  @override
  State<CategoryUploadWidget> createState() => _CategoryUploadWidgetState();
}

class _CategoryUploadWidgetState extends State<CategoryUploadWidget> {
  final FirebaseService _services = FirebaseService();
  final _fileNameTextController = TextEditingController();
  final _categoryNameTextController = TextEditingController();
  bool _visible = false;
  bool _imageSelected = true;
  String? _url;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Visibility(
              visible: _visible,
              child: Row(
                children: [
                  SizedBox(
                    width: 200,
                    height: 30,
                    child: TextField(
                      controller: _categoryNameTextController,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1)),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "No Category name given",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 20)),
                    ),
                  ),
                  AbsorbPointer(
                    absorbing: true,
                    child: SizedBox(
                      width: 200,
                      height: 30,
                      child: TextField(
                        controller: _fileNameTextController,
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1)),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "No Image Selected",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 20)),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      uploadStorage();
                    },
                    child: const Text(
                      "Upload Image",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  AbsorbPointer(
                    absorbing: _imageSelected,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_categoryNameTextController.text.isEmpty) {
                          _services.showMyDialog(
                              context: context,
                              title: "Add New Category",
                              message: "New Category Name not given");
                        }
                        _services
                            .uploadCategoryImageToDb(
                                _url, _categoryNameTextController)
                            .then((downloadUrl) {
                          _services.showMyDialog(
                              context: context,
                              title: "New Category",
                              message: "Saved New Category Successifully");
                        });
                        _categoryNameTextController.clear();
                        _fileNameTextController.clear();
                      },
                      child: const Text(
                        "Save New Category",
                        style: TextStyle(color: Colors.white),
                      ),
                      // Color: _imageselected ? Colors.black12 : Colors.black54
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _visible ? false : true,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _visible = true;
                  });
                },
                child: const Text(
                  "Add New Category",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void uploadImage({required Function(File file) onSelected}) {
    FileUploadInputElement uploadInput = FileUploadInputElement()
      ..accept = "image/*";
    // it will upload only image
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
      });
    });
    // selected image
  }

  void uploadStorage() {
    // upload selected image to firebase storage
    final dateTime = DateTime.now();
    final path = "CategoryImage/${dateTime.microsecondsSinceEpoch}";
    uploadImage(onSelected: (file) {
      setState(() {
        _fileNameTextController.text = file.name;
        _imageSelected = false;
        _url = path;
      });
      firebase_storage.FirebaseStorage.instance
          .ref(path)
          .putBlob(file)
          .then((snapshot) {
        // Get the download URL after the file is uploaded
        snapshot.ref.getDownloadURL().then((downloadUrl) {
          // Handle the download URL
        });
      });
    });
  }
}
