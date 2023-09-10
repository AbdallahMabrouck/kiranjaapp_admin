import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import '../widgets/deliveryBoy/approved_boys.dart';
import '../widgets/deliveryBoy/create_deliveryboy.dart';
import '../widgets/deliveryBoy/new_boys.dart';
import '../widgets/sidebar.dart';

class DeliveryBoyScreen extends StatelessWidget {
  static const String id = "delivery-boy-screen";
  const DeliveryBoyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();
    return DefaultTabController(
      length: 2,
      child: AdminScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Kiranja - Admin Dashboard",
            style: TextStyle(color: Colors.white),
          ),
        ),
        sideBar: sideBar.sideBarMenus(context, id),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Delivery Boys",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
                ),
                const Text("Create New and Manage all Delivery boys"),
                const Divider(
                  thickness: 5,
                ),

                const CreateNewBoyWidget(),

                const Divider(
                  thickness: 5,
                ),

                // list of delivery boys
                TabBar(
                    indicatorColor: Theme.of(context).primaryColor,
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.black54,
                    tabs: const [
                      Tab(
                        text: "NEW",
                      ),
                      Tab(
                        text: "APPROVED",
                      ),
                    ]),
                Expanded(
                    child: Container(
                  child:
                      const TabBarView(children: [NewBoys(), ApprovedBoys()]),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
