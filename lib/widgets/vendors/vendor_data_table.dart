import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_admin/widgets/vendors/vendor_details_box.dart';
import '../../firebase_services.dart';

class VendorDataTable extends StatefulWidget {
  const VendorDataTable({Key? key}) : super(key: key);

  @override
  State<VendorDataTable> createState() => _VendorDataTableState();
}

class _VendorDataTableState extends State<VendorDataTable> {
  final FirebaseService _services = FirebaseService();

  int tag = 0;
  List<String> options = [
    'All Vendors',
    'Active Vendors',
    'Inactive Vendors',
    'Top Picked',
    'Top Rated',
    // more can be added later
  ];

  bool? topPicked;
  bool? active;

  void filter(int val) {
    if (val == 1) {
      setState(() {
        active = true;
      });
    }
    if (val == 2) {
      setState(() {
        active = false;
      });
    }
    if (val == 3) {
      setState(() {
        topPicked = true;
      });
    }
    if (val == 0) {
      setState(() {
        topPicked = null;
        active = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChipsChoice<int>.single(
          value: tag,
          onChanged: (val) {
            setState(() {
              tag = val;
            });
            filter(val);
          },
          choiceItems: C2Choice.listFrom<int, String>(
            source: options,
            value: (i, v) => i,
            label: (i, v) => v,
          ),
        ),
        const Divider(
          thickness: 5,
        ),
        StreamBuilder(
          stream: _services.vendors
              .where("isTopPicked", isEqualTo: topPicked)
              .where("accVerified", isEqualTo: active)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                showBottomBorder: true,
                // dataRowHeight: 60,
                headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                // Table headers
                columns: const <DataColumn>[
                  DataColumn(label: Text("Active/Inactive")),
                  DataColumn(label: Text("Top Picked")),
                  DataColumn(label: Text("Shop Name")),
                  DataColumn(label: Text("Rating")),
                  DataColumn(label: Text("Total Sales")),
                  DataColumn(label: Text("Mobile")),
                  DataColumn(label: Text("Email")),
                  DataColumn(label: Text("View Details")),
                ],
                // Details
                rows: _vendorDetailsRows(snapshot.data, _services),
              ),
            );
          },
        ),
      ],
    );
  }

  /*List<DataRow> _vendorDetailsRows(
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs,
      FirebaseServices services) {
    List<DataRow> newList = docs?.map((document) {
      final data = document.data();
      return DataRow(cells: [
        DataCell(
          IconButton(
              onPressed: () {
                services.updateVendorStatus(
                    id: data["uid"],
                    status: data["accVerified"]);
              },
              icon: data["accVerified"]
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(Icons.remove_circle, color: Colors.red)),
        ),
        DataCell(
          IconButton(
              onPressed: () {
                services.updateVendorStatus(
                    id: data["uid"],
                    status: data["isTopPicked"]);
              },
              icon: data["isTopPicked"]
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(null)),
        ),
        DataCell(Text(data["shopName"])),
        DataCell(Row(
          children: const [
            Icon(Icons.star, color: Colors.grey),
            Text("3.5"),
          ],
        )),
        const DataCell(Text("20,000")),
        DataCell(Text(data["mobile"])),
        DataCell(Text(data["email"])),
        DataCell(IconButton(
            onPressed: () {
              // will pop up vendor details screen
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const VendorDetailsBox(uid: "uid");
                    // return VendorDetailsBox(data["uid"]);
                  });
            },
            icon: const Icon(Icons.info_outline))),
      ]);
    }).toList() ?? [];

    return newList;
  }
}*/

  List<DataRow> _vendorDetailsRows(
    QuerySnapshot<Object?>? snapshot,
    FirebaseService services,
  ) {
    List<DataRow> newList = (snapshot?.docs ?? []).map((document) {
      final data = document.data() as Map<String, dynamic>;
      return DataRow(cells: [
        DataCell(
          IconButton(
            onPressed: () {
              services.updateVendorStatus(
                id: data["uid"],
                status: data["accVerified"],
              );
            },
            icon: data["accVerified"]
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.remove_circle, color: Colors.red),
          ),
        ),
        DataCell(
          IconButton(
            onPressed: () {
              services.updateVendorStatus(
                id: data["uid"],
                status: data["isTopPicked"],
              );
            },
            icon: data["isTopPicked"]
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(null),
          ),
        ),
        DataCell(Text(data["shopName"])),
        const DataCell(Row(
          children: [
            Icon(Icons.star, color: Colors.grey),
            Text("3.5"),
          ],
        )),
        const DataCell(Text("20,000")),
        DataCell(Text(data["mobile"])),
        DataCell(Text(data["email"])),
        DataCell(IconButton(
          onPressed: () {
            // will pop up vendor details screen
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const VendorDetailsBox(uid: "uid");
                // return VendorDetailsBox(data["uid"]);
              },
            );
          },
          icon: const Icon(Icons.info_outline),
        )),
      ]);
    }).toList();

    return newList;
  }
}
