import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_admin/firebase_services.dart';
import 'package:kiranjaapp_admin/widgets/category/category_card_widget.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseService _services = FirebaseService();

    return Container(
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
          stream: _services.category.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Wrap(
              direction: Axis.horizontal,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                return CategoryCard(
                  document: document,
                );
              }).toList(),
            );
          }),
    );
  }
}
