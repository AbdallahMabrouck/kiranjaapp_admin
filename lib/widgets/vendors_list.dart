// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../firebase_services.dart';
import '../models/vendor_model.dart';

class VendorsList extends StatelessWidget {
  final bool? approveStatus;
  const VendorsList({
    Key? key,
    this.approveStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService _services = FirebaseService();
    Widget _vendorData({int? flex, String? text, Widget? widget}) {
      return Expanded(
        flex: flex!,
        child: Container(
          height: 66,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget ?? Text(text!),
          ),
        ),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _services.vendor
          .where("approved", isEqualTo: approveStatus)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        }
        if (snapshot.data!.size == 0) {
          return const Center(
            child: Text(
              "No Vendors to show",
              style: TextStyle(fontSize: 22),
            ),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.size,
          itemBuilder: (context, index) {
            Vendor vendor = Vendor.fromJson(
                snapshot.data!.docs[index] as Map<String, dynamic>);
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _vendorData(
                  flex: 1,
                  widget: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.network(vendor.logo!),
                  ),
                ),
                _vendorData(flex: 3, text: vendor.businessName),
                _vendorData(flex: 2, text: vendor.city),
                _vendorData(flex: 2, text: vendor.state),
                _vendorData(
                  flex: 1,
                  widget: vendor.approved == true
                      ? ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                          onPressed: () {
                            EasyLoading.show();
                            _services.updateData(
                                data: {"approve": false},
                                docName: vendor.uid,
                                reference: _services.vendor).then((value) {
                              EasyLoading.dismiss();
                            });
                          },
                          child: const FittedBox(
                            child: Text(
                              "Reject",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            EasyLoading.show();
                            _services.updateData(
                                data: {"approve": true},
                                docName: vendor.uid,
                                reference: _services.vendor).then((value) {
                              EasyLoading.dismiss();
                            });
                          },
                          child: const FittedBox(
                            child: Text(
                              "Approve",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                ),
                _vendorData(
                  flex: 1,
                  widget: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "View more",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
