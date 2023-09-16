import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_admin/firebase_services.dart';

class SubCategoryWidget extends StatefulWidget {
  final String categoryName;
  const SubCategoryWidget({super.key, required this.categoryName});

  @override
  State<SubCategoryWidget> createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {
  final FirebaseService _services = FirebaseService();
  final _subCatNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<DocumentSnapshot>(
          future: _services.category.doc(widget.categoryName).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(
                  child: Text("No Subcategories Added"),
                );
              }

              Map<String, dynamic>? data =
                  snapshot.data?.data() as Map<String, dynamic>?;

              if (data == null || data["subCat"] == null) {
                return const Center(
                  child: Text("No Subcategories Added"),
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text("Main Category : "),
                            Text(
                              widget.categoryName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 3,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // subcategory List
                    child: Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              child: Text("${index + 1}"),
                            ),
                            title: Text(data["subCat"][index]["name"] ?? ""),
                          );
                        },
                        itemCount:
                            data["subCat"] == null ? 0 : data["subCat"].length,
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        const Divider(
                          thickness: 4,
                        ),
                        Container(
                          color: Colors.grey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Add New sub Category",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 30,
                                      child: TextField(
                                        controller: _subCatNameTextController,
                                        decoration: const InputDecoration(
                                          hintText: "Sub Category Name",
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(),
                                          contentPadding:
                                              EdgeInsets.only(left: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_subCatNameTextController
                                          .text.isEmpty) {
                                        _services.showMyDialog(
                                          context: context,
                                          title: "Add New Sub Category",
                                          message:
                                              "Need to give Sub Category Name",
                                        );
                                      }
                                      DocumentReference doc = _services.category
                                          .doc(widget.categoryName);
                                      doc.update({
                                        "subCat": FieldValue.arrayUnion([
                                          {
                                            "name":
                                                _subCatNameTextController.text,
                                          }
                                        ]),
                                      });
                                      // if you want to see the update real time
                                      setState(() {});
                                      // after update clear edit text
                                      _subCatNameTextController.clear();
                                    },
                                    child: const Text(
                                      "Save",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}











/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_admin/firebase_services.dart';

class SubCategoryWidget extends StatefulWidget {
  final String categoryName;
  const SubCategoryWidget({super.key, required this.categoryName});

  @override
  State<SubCategoryWidget> createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {
  final FirebaseService _services = FirebaseService();
  final _subCatNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<DocumentSnapshot>(
            future: _services.category.doc(widget.categoryName).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No Subcategories Added"),
                  );
                }
                Map<String, dynamic> data = snapshot.data.data();

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text("Main Category : "),
                              Text(
                                widget.categoryName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const Divider(
                            thickness: 3,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // subcategory List
                      child: Expanded(
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                child: Text("${index + 1}"),
                              ),
                              title: Text(data["subCat"][index]["name"]),
                            );
                          },
                          itemCount: data["subCat"] == null
                              ? 0
                              : data["subCat"].length,
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          const Divider(
                            thickness: 4,
                          ),
                          Container(
                            color: Colors.grey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Add New sub Category",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 30,
                                        child: TextField(
                                          controller: _subCatNameTextController,
                                          decoration: const InputDecoration(
                                              hintText: "Sub Category Name",
                                              fillColor: Colors.white,
                                              filled: true,
                                              border: OutlineInputBorder(),
                                              focusedBorder:
                                                  OutlineInputBorder(),
                                              contentPadding:
                                                  EdgeInsets.only(left: 10)),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                        // color: Colors.black54
                                        onPressed: () {
                                          if (_subCatNameTextController
                                              .text.isEmpty) {
                                            _services.showMyDialog(
                                                context: context,
                                                title: "Add New Sub Category",
                                                message:
                                                    "Need to give Sub Category Name");
                                          }
                                          DocumentReference doc = _services
                                              .category
                                              .doc(widget.categoryName);
                                          doc.update({
                                            "subCat": FieldValue.arrayUnion([
                                              {
                                                "name":
                                                    _subCatNameTextController
                                                        .text
                                              }
                                            ])
                                          });
                                          // if you want to see the update real time
                                          setState(() {});
                                          // after update clear edit text
                                          _subCatNameTextController.clear();
                                        },
                                        child: const Text(
                                          "Save",
                                          style: TextStyle(color: Colors.white),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}*/
