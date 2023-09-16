import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiranjaapp_admin/firebase_services.dart';

class CategoryListWidget extends StatefulWidget {
  final CollectionReference reference;
  const CategoryListWidget({super.key, required this.reference});

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  final FirebaseService _service = FirebaseService();
  Object? _selectedValue;
  QuerySnapshot? snapshot;

  Widget categoryWidget(data) {
    return SizedBox(
      height: 120,
      width: 120,
      child: Card(
        // color: Colors.grey.shade100,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: Image.network(data["image"]),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    widget.reference == _service.categories
                        ? data["catName"]
                        : data["subCatName"],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    /*Card(
      color: Colors.grey.shade400,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 80,
              width: 80,
              child: Image.network(
                data["image"],
              ),
            ),
            Text(widget.reference == _service.categories
                ? data["catName"]
                : data["subCatName"]),
          ],
        ),
      ),
    );*/
  }

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
        });
      },
    );
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (widget.reference == _service.subCat && snapshot != null)
            Row(
              children: [
                _dropDownButton(),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedValue = null;
                    });
                  },
                  child: const Text("Show All"),
                ),
              ],
            ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: widget.reference
                .where("mainCategory", isEqualTo: _selectedValue)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LinearProgressIndicator();
              }

              if (snapshot.data!.size == 0) {
                return const Text("No Categories Added");
              }

              return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                  ),
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];
                    return categoryWidget(data);
                  });
            },
          ),
        ],
      ),
    );
  }
}
