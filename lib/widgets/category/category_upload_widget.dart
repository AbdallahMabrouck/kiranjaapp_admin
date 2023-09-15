import 'dart:html';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
// import 'package:firebase/firebase.dart' as fb;
import '../../firebase_services.dart';

class CategoryCreateWidget extends StatefulWidget {
  const CategoryCreateWidget({super.key});

  @override
  State<CategoryCreateWidget> createState() => _CategoryCreateWidgetState();
}

class _CategoryCreateWidgetState extends State<CategoryCreateWidget> {
  final FirebaseService _services = FirebaseService();
  final _fileNameTextController = TextEditingController();
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
                  AbsorbPointer(
                    absorbing: true,
                    child: SizedBox(
                        width: 300,
                        height: 30,
                        child: TextField(
                          controller: _fileNameTextController,
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1)),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "No Image Selected",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.only(left: 20)),
                        )),
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
                        _services
                            .uploadBannerImageToDb(_url)
                            .then((downloadUrl) {
                          _services.showMyDialog(
                              context: context,
                              title: "New Banner Image",
                              message: "Saved Banner Image Successifully");
                        });
                      },
                      child: const Text(
                        "Save Image",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _visible,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _visible = true;
                  });
                },
                child: const Text(
                  "Add New Banner",
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
    final path = "bannerImage/${dateTime.microsecondsSinceEpoch}";
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
