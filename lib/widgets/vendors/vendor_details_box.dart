import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../firebase_services.dart';

class VendorDetailsBox extends StatefulWidget {
  const VendorDetailsBox({super.key, required this.uid});

  final String uid;

  @override
  State<VendorDetailsBox> createState() => _VendorDetailsBoxState();
}

class _VendorDetailsBoxState extends State<VendorDetailsBox> {
  final FirebaseService _services = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _services.vendors.doc(widget.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("something went wrong"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * .3,
                    child: ListView(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    snapshot.data!["imageUrl"],
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!["shopName"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                Text(snapshot.data!["dialog"]),
                              ],
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 4,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: const Text(
                                      "Contact Number",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  )),
                                  Container(
                                    child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(";")),
                                  ),
                                  Expanded(
                                      child: Container(
                                    child: Text(snapshot.data!["mobile"]),
                                  )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: const Text(
                                      "Email",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  )),
                                  Container(
                                    child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(";")),
                                  ),
                                  Expanded(
                                      child: Container(
                                    child: Text(snapshot.data!["email"]),
                                  )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: const Text(
                                      "address",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  )),
                                  Container(
                                    child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(":")),
                                  ),
                                  Expanded(
                                      child: Text(snapshot.data!["address"])),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: const Text(
                                      "Top Pick Status",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  )),
                                  Container(
                                    child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(":")),
                                  ),
                                  Expanded(
                                      child: Container(
                                          child: snapshot.data!["isTopPicked"]
                                              ? const Chip(
                                                  backgroundColor: Colors.green,
                                                  label: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        'Top Picked',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Container())),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            Wrap(
                              children: [
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              CupertinoIcons
                                                  .money_dollar_circle,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text("Total Revenues"),
                                            Text("12,000")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              CupertinoIcons.cart_fill,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text("Active Orders"),
                                            Text("12")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              CupertinoIcons.shopping_cart,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text("Total Orders"),
                                            Text("130")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.grain_outlined,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text("Products"),
                                            Text("300 products")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.list_alt_outlined,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text("Statement"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: snapshot.data!['accVerified']
                        ? const Chip(
                            backgroundColor: Colors.green,
                            label: Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Active",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ))
                        : const Chip(
                            backgroundColor: Colors.red,
                            label: Row(
                              children: [
                                Icon(
                                  Icons.remove_circle,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Inactive",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
