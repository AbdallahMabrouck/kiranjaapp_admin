import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../firebase_services.dart';

class NewBoys extends StatefulWidget {
  const NewBoys({super.key});

  @override
  State<NewBoys> createState() => _NewBoysState();
}

class _NewBoysState extends State<NewBoys> {
  bool status = false;
  final FirebaseService _services = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream:
              _services.boys.where("accVerified", isEqualTo: false).snapshots(),
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
                child: Text("No new Delivery boys to list"),
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
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      print(document.data().length);
      if (document != null) {
        return DataRow(cells: [
          DataCell(
            Container(
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: document.data()["imageUrl"] == ""
                      ? const Icon(
                          Icons.person,
                          size: 40,
                        )
                      : Image.network(
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
          DataCell(document.data()["mobile"] == ""
              ? const Text("Not Registered")
              : FluterSwitch(
                  activeText: "Approved",
                  InactiveText: "Not Approved",
                  value: document.data()["accVerified"],
                  valueFontSize: 10.0,
                  width: 110,
                  boarderRadius: 30.0,
                  shoOnOff: true,
                  onToggle: (val) {
                    _services.updateBoyStatus(
                        id: document.id, context: context, status: true);
                  }))
        ]);
      }
    }).toList();
    return newList;
  }
}
