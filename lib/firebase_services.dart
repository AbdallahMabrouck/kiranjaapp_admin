import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");
  CollectionReference mainCat =
      FirebaseFirestore.instance.collection("mainCategories");
  CollectionReference subCat =
      FirebaseFirestore.instance.collection("subCategories");
  /*CollectionReference vendor = FirebaseFirestore.instance.collection("vendor");*/

  Future<void> saveCategory(
      {CollectionReference? reference,
      Map<String, dynamic>? data,
      String? docName}) {
    return reference!.doc(docName).set(data);
  }

  /*Future<void> saveCategory(Map<String, Object> map,
      {CollectionReference? reference,
      Map<String, dynamic>? data,
      String? docName}) {
    return reference!.doc(docName).set(data);
  }*/

  updateData(
      {required Map<String, bool> data,
      String? docName,
      required CollectionReference<Object?> reference}) {}
}

Future<void> updateData(
    {CollectionReference? reference,
    Map<String, dynamic>? data,
    String? docName}) {
  return reference!.doc(docName).update(data!);
}
