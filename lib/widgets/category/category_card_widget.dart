import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final DocumentSnapshot document;
  const CategoryCard({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: Card(
        color: Colors.orangeAccent.withOpacity(.9),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: Image.network(document["image"]),
                ),
                Flexible(child: Text(document["name"]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
