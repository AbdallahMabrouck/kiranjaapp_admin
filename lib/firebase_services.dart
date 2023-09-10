import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

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
  CollectionReference boys = FirebaseFirestore.instance.collection("boys");

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

  Future<void> saveDeliveryBoys(email, password) async {
    boys.doc(email).set({
      "accVerified": false,
      "address": "",
      "email": email,
      "imageUrl": "",
      "location": const GeoPoint(0, 0),
      "mobile": "",
      "name": "",
      "password": password,
      'uid': "",
    });
  }

  // Updated method to show a progress indicator and handle errors
  Future<void> updateBoyStatus({id, context, status}) async {
    try {
      // Show a progress indicator
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      DocumentReference documentReference =
          FirebaseFirestore.instance.collection("boys").doc(id);

      DocumentSnapshot snapshot = await documentReference.get();

      if (!snapshot.exists) {
        throw Exception("User does not exist");
      }

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.update(documentReference, {"accVerified": status});
      });

      // Dismiss the progress indicator
      Navigator.of(context).pop();

      // Show a success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delivery boy status"),
            content: Text(status == true
                ? "Delivery boy approved status updated as Approved"
                : "Delivery boy approved status updated as Not Approved"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } catch (error) {
      // Dismiss the progress indicator
      Navigator.of(context).pop();

      // Show an error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delivery boy status"),
            content: Text("Failed to update delivery boy status $error"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}


















/*import 'package:cloud_firestore/cloud_firestore.dart';
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
       CollectionReference boys = FirebaseFirestore.instance.collection("boys");

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


  Future<void>saveDeliveryBoys(email, password) async {
     boys.doc(email).set({
      "accVerified" : false, 
      "address" : "", 
      "email" : email, 
      "imageUrl" : "", 
      "location" : const GeoPoint(0, 0), 
      "mobile" : "", 
      "name" : "",
      "password" : password, 
      'uid' : "",
     });
  }

  // update delivery oy approved status
  updateBoyStatus({id, context, status}){

    ArsProgressDialog progressDialog = ArsProgressDialog (
      context, 
      blur; 2,
      backgroundColor: Color(0xFF84C225).withOpacity(.3), 
      animationDuration: Duration(milliseconds: 500)
      );
      progressDialog.show();

    DocumentReference documentReference = FirebaseFirestore.instance
    .collection("boys")
    .doc(id);

    return FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if(!snapshot.exists){
        throw Exception("User does not exists");
      }

      transaction.update(documentReference, {"accVerified" : status});

    }).then((value) {
      progressDialog.dismiss();
      showMyDialog(
        title: "Delivery boy status", 
        message: status == true ? "Delivery boy approved status updated as  Approved" : "Delivery boy approved status updated as Not Approved",
        context: context
      );
    })
      .catchError((error) => showMyDialog(
        context: context, 
        title: "Delivery boy status", 
        message: "Failed to update delivery boy ststus $error"
        
      ));




    }
  }



  Future<void> saveCategory(Map<String, Object> map,
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




