import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import '../screens/category_screen.dart';
import '../screens/delivery_boy_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/vendor_screen.dart';
import 'admin_users.dart';
import 'manage_banners.dart';
import 'settings.dart';

class SideBarWidget {
  sideBarMenus(context, selectedRoute) {
    return SideBar(
      activeBackgroundColor: Colors.black54,
      activeIconColor: Colors.white,
      activeTextStyle: const TextStyle(color: Colors.white),
      items: const [
        AdminMenuItem(
            title: "Dashboard", route: HomeScreen.id, icon: Icons.dashboard),
        AdminMenuItem(
            title: "Banners",
            route: BannersScreen.id,
            icon: CupertinoIcons.photo),
        AdminMenuItem(
            title: "Vendors",
            route: VendorsScreen.id,
            icon: CupertinoIcons.group_solid),
        AdminMenuItem(
            title: "Delivery Boy",
            route: DeliveryBoyScreen.id,
            icon: Icons.delivery_dining),
        AdminMenuItem(
            title: "Categories",
            route: CategoryScreen.id,
            icon: Icons.category),
        AdminMenuItem(
            title: "Orders",
            route: OrdersScreen.id,
            icon: CupertinoIcons.cart_fill),
        AdminMenuItem(
            title: "Admin Users",
            route: AdminUsers.id,
            icon: Icons.person_2_outlined),
        AdminMenuItem(
            title: "Send Notifications",
            route: NotificationsScreen.id,
            icon: Icons.notifications),
        AdminMenuItem(
            title: "Setting", route: Settings.id, icon: Icons.settings),
        AdminMenuItem(
            title: "Exit", route: LoginScreen.id, icon: Icons.exit_to_app),
      ],
      selectedRoute: selectedRoute,
      onSelected: (item) {
        Navigator.of(context).pushNamed(item.route!);
      },
      header: Container(
        height: 50,
        width: double.infinity,
        color: Colors.black26,
        child: const Center(
          child: Text(
            "MENU",
            style: TextStyle(
                letterSpacing: 2,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      footer: Container(
        height: 50,
        width: double.infinity,
        color: Colors.black26,
        child: Center(
          child: Image.asset(
            "assets/images/kiranja-logo.png",
            height: 30,
          ),
        ),
      ),
    );
  }
}
