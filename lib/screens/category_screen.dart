import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  static const String id = "category";

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
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
                decoration: const InputDecoration(
                    label: Text("Enter Category Name"),
                    contentPadding: EdgeInsets.zero),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            TextButton(
              onPressed: () {},
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
            ElevatedButton(
              onPressed: () {},
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
      ],
    );
  }
}
