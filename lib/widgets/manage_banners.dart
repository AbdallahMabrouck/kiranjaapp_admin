import 'dart:html';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
// import 'package:kiranjaapp_admin/widgets/sidebar.dart';
import '../firebase_services.dart';
import 'banners/banner_widget.dart';

class ManageBanners extends StatefulWidget {
  const ManageBanners({super.key});
  static const String id = "banners-screen";

  @override
  State<ManageBanners> createState() => _ManageBannersState();
}

class _ManageBannersState extends State<ManageBanners> {
  // SideBarWidget sideBar = SideBarWidget();
  final FirebaseService _services = FirebaseService();
  final _fileNameTextController = TextEditingController();
  bool _visible = false;
  bool _imageSelected = true;
  String? _url;

  @override
  Widget build(BuildContext context) {
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
      // sideBar: sideBar.sideBarMenus(context, BannersScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Banners Screen",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
              ),
              const Text("Add/Delete Home Screen Banner Images"),
              const Divider(
                thickness: 5,
              ),
              // Banners
              const BannerWidget(),
              const Divider(
                thickness: 5,
              ),
              Container(
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
                                        contentPadding:
                                            EdgeInsets.only(left: 20)),
                                  )),
                            ),
                            ElevatedButton(
                              onPressed: () {},
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
                                      .then((downloadUrl) {});
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
              ),
            ],
          ),
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
    final path = "bannerImage/$dateTime";
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
