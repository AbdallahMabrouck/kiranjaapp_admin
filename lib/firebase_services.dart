import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");
  CollectionReference mainCat =
      FirebaseFirestore.instance.collection("mainCategories");
  CollectionReference subCat =
      FirebaseFirestore.instance.collection("subCategories");
  CollectionReference vendor = FirebaseFirestore.instance.collection("vendor");
  CollectionReference banners = FirebaseFirestore.instance.collection("slider");
  CollectionReference vendors =
      FirebaseFirestore.instance.collection("vendors");

  Future<void> saveCategory(
      {CollectionReference? reference,
      Map<String, dynamic>? data,
      String? docName}) {
    return reference!.doc(docName).set(data);
  }

  Future<void> updateData(
      {CollectionReference? reference,
      Map<String, dynamic>? data,
      String? docName}) {
    return reference!.doc(docName).update(data!);
  }

  Future<QuerySnapshot> getAdminCredentials() {
    var result = FirebaseFirestore.instance.collection("Admin").get();
    return result;
  }

  Future<String> uploadBannerImageToDb(url) async {
    String downloadUrl = await storage.ref(url).getDownloadURL();
    firestore.collection("slider").add({
      "image": downloadUrl,
    });
    return downloadUrl;
  }

  deleteBannerFromDb(id) async {
    firestore.collection("slider").doc(id).delete();
  }

  updateVendorStatus({id, status}) async {
    vendors.doc(id).update({
      "accVerified": status ? false : true,
    });
  }
}


  /*Future<void> saveCategory(Map<String, Object> map,
      {CollectionReference? reference,
      Map<String, dynamic>? data,
      String? docName}) {
    return reference!.doc(docName).set(data);
  }*/


  /* Future<void> _confirmDeleteDialog ({title, message, context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      bulder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children:<widget> [
                Text(message),

              ],
            ),
          ),
          actions: <widget> [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel")),
            TextButton(
              onPressed: () {
                deleteBannerFromDb(id);
                Navigator.of(context).pop();
              },
              child: Text("Delete")),
          ]
        );
      }
    );
  }*/

  /* Future<void> _showMyDialog ({title, message, context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      bulder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children:<widget> [
                Text(message),

              ],
            ),
          ),
          actions: <widget> [

            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK")),
          ]
        );
      }
    );
  }*/




