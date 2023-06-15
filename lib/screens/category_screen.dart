import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const String id = "category";

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
                  child: const Center(child: Text("Category Image")),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
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
