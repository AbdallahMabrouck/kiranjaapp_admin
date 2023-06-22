import 'package:flutter/material.dart';

import '../widgets/vendors_list.dart';

class VendorScreen extends StatefulWidget {
  static const String id = "vendors-screen";
  const VendorScreen({super.key});

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  Widget _rowHeader({int? flex, String? text}) {
    return Expanded(
      flex: flex!,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade500),
            color: Colors.grey.shade400),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  bool? selectedButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Registered Vendors",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              Container(
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            selectedButton == true
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade500),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedButton == true;
                        });
                      },
                      child: const Text("Approved"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            selectedButton == false
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade500),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedButton == false;
                        });
                      },
                      child: const Text("Not Approved"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            selectedButton == null
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade500),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedButton == null;
                        });
                      },
                      child: const Text("All"),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              _rowHeader(flex: 1, text: "LOGO"),
              _rowHeader(flex: 3, text: "BUSINESS NAME"),
              _rowHeader(flex: 2, text: "CITY"),
              _rowHeader(flex: 2, text: "STATE"),
              _rowHeader(flex: 1, text: "ACTION"),
              _rowHeader(flex: 1, text: "VIEW MORE"),
            ],
          ),
          VendorsList(
            approveStatus: selectedButton,
          )
        ],
      ),
    );
  }
}
