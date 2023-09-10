import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../firebase_services.dart';

class ApprovedBoys extends StatefulWidget {
  const ApprovedBoys({super.key});

  @override
  State<ApprovedBoys> createState() => _ApprovedBoysState();
}

class _ApprovedBoysState extends State<ApprovedBoys> {
  final FirebaseService _services = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream:
            _services.boys.where("accVerified", isEqualTo: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          QuerySnapshot<Object?> snap = snapshot.data!;

          if (snap.size == 0) {
            return const Center(
              child: Text("No Approved boys to list"),
            );
          }

          return SingleChildScrollView(
            child: DataTable(
              showBottomBorder: true,
              headingRowColor: MaterialStateProperty.all(Colors.grey.shade200),
              columns: const <DataColumn>[
                DataColumn(
                  label: Text("Profile Pic"),
                ),
                DataColumn(
                  label: Text("Name"),
                ),
                DataColumn(
                  label: Text("Email"),
                ),
                DataColumn(
                  label: Text("Mobile"),
                ),
                DataColumn(
                  label: Text("Address"),
                ),
                DataColumn(
                  label: Text("Action"),
                ),
              ],
              rows: _boysList(snapshot.data!, context),
            ),
          );
        },
      ),
    );
  }

  List<DataRow> _boysList(QuerySnapshot snapshot, context) {
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

      return DataRow(cells: [
        DataCell(
          SizedBox(
            width: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                data["imageUrl"],
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        DataCell(
          Text(data["name"]),
        ),
        DataCell(
          Text(data["email"]),
        ),
        DataCell(
          Text(data["mobile"]),
        ),
        DataCell(
          Text(data["address"]),
        ),
        DataCell(
          FlutterSwitch(
            activeText: "Approved",
            activeColor: Colors.indigo,
            inactiveColor: Colors.grey,
            inactiveText: "Not Approved",
            value: data["accVerified"],
            valueFontSize: 10.0,
            width: 110,
            borderRadius: 30.0,
            showOnOff: true,
            onToggle: (val) {
              _services.updateBoyStatus(
                id: document.id,
                context: context,
                status: false,
              );
            },
          ),
        ),
      ]);
    }).toList();
    return newList;
  }
}































/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../firebase_services.dart';

class ApprovedBoys extends StatefulWidget {
  const ApprovedBoys({super.key});

  @override
  State<ApprovedBoys> createState() => _ApprovedBoysState();
}

class _ApprovedBoysState extends State<ApprovedBoys> {
  bool status = false;
  final FirebaseService _services = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream:
              _services.boys.where("accVerified", isEqualTo: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            QuerySnapshot snap = snapshot.data;

            if (snap.size == 0) {
              return const Center(
                child: Text("No Approved boys to list"),
              );
            }

            return SingleChildScrollView(
              child: DataTable(
                  showBottomBorder: true,
                  // dataRowHeight: 60,
                  headingRowColor:
                      MaterialStateProperty.all(Colors.grey.shade200),
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(child: Text("Profile Pic")),
                    ),
                    DataColumn(
                      label: Text("Name"),
                    ),
                    DataColumn(
                      label: Text("Email"),
                    ),
                    DataColumn(
                      label: Text("Mobile"),
                    ),
                    DataColumn(
                      label: Text("Address"),
                    ),
                    DataColumn(
                      label: Text("Action"),
                    ),
                  ],
                  rows: _boysList(snapshot.data, context)),
            );
          }),
    );
  }

  List<DataRow> _boysList(QuerySnapshot snapshot, context) {
    List<DataRow?> newList = snapshot.docs.map((DocumentSnapshot document) {
      if (document != null) {
        return DataRow(cells: [
          DataCell(
            SizedBox(
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    document.data()["imageUrl"],
                    fit: BoxFit.contain,
                  ),
                )),
          ),
          DataCell(
            Text(document.data()["name"]),
          ),
          DataCell(
            Text(document.data()["email"]),
          ),
          DataCell(
            Text(document.data()["mobile"]),
          ),
          DataCell(
            Text(document.data()["address"]),
          ),
          DataCell(
            FlutterSwitch(
              activeText: "Approved",
              activeColor: Colors.indigo,
              inactiveColor: Colors.grey,
              inactiveText: "Not Approved",
              value: document.data()["accVerified"],
              valueFontSize: 10.0,
              width: 110,
              borderRadius: 30.0,
              showOnOff: true,
              onToggle: (val) {
                _services.updateBoyStatus(
                    id: document.id, context: context, status: false);
              }))
        ]);
      }
    }).toList();
    return newList;
  }
}
*/