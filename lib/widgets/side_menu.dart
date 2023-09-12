import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:kiranjaapp_admin/widgets/settings.dart';
import '../dashboard_screen.dart';
import '../screens/banners_screen.dart';
import '../screens/category_screen.dart';
import '../screens/login_screen.dart';
import '../screens/main_category_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/sub_category_screen.dart';
import '../screens/vendor_screen.dart';
import 'admin_users.dart';

class SideMenu extends StatefulWidget {
  static const String id = "side-menu";

  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  Widget _selectedScreen = const DashBoardScreen();

  screenSelector(item) {
    switch (item.route) {
      case DashBoardScreen.id:
        setState(() {
          _selectedScreen = const DashBoardScreen();
        });
        break;
      case BannersScreen.id:
        setState(() {
          _selectedScreen = const BannersScreen();
        });
        break;
      case VendorsScreen.id:
        setState(() {
          _selectedScreen = const VendorsScreen();
        });
        break;
      case CategoryScreen.id:
        setState(() {
          _selectedScreen = const CategoryScreen();
        });
        break;
      case MainCategoryScreen.id:
        setState(() {
          _selectedScreen = const MainCategoryScreen();
        });
        break;
      case SubCategoryScreen.id:
        setState(() {
          _selectedScreen = const SubCategoryScreen();
        });
        break;
      case OrdersScreen.id:
        setState(() {
          _selectedScreen = const OrdersScreen();
        });
        break;
      case AdminUsers.id:
        setState(() {
          _selectedScreen = const AdminUsers();
        });
        break;
      case NotificationsScreen.id:
        setState(() {
          _selectedScreen = const NotificationsScreen();
        });
        break;
      case Settings.id:
        setState(() {
          _selectedScreen = const Settings();
        });
        break;
      case LoginScreen.id:
        setState(() {
          _selectedScreen = const LoginScreen(
            title: "Kiranja - Admin",
          );
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Kiranja - Admin',
          style: TextStyle(letterSpacing: 1),
        ),
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: DashBoardScreen.id,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
              title: "Banners",
              route: BannersScreen.id,
              icon: CupertinoIcons.photo),
          AdminMenuItem(
            title: 'Vendors',
            route: VendorsScreen.id,
            icon: Icons.group_outlined,
          ),
          AdminMenuItem(
            title: 'Categories',
            icon: IconlyLight.category,
            children: [
              AdminMenuItem(
                  title: 'Category',
                  route: CategoryScreen.id,
                  icon: IconlyLight.category,
                  children: [
                    AdminMenuItem(
                        title: 'Main Category',
                        route: MainCategoryScreen.id,
                        icon: IconlyLight.category,
                        children: [
                          AdminMenuItem(
                            title: 'Sub Category',
                            route: SubCategoryScreen.id,
                            icon: IconlyLight.category,
                          ),
                        ]),
                  ]),
            ],
          ),
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
        selectedRoute: SideMenu.id,
        onSelected: (item) {
          screenSelector(item);
          if (item.route != null) {
            Navigator.of(context).pushNamed(item.route!);
          }
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: Center(
            child: Text(
              DateTimeFormat.format(DateTime.now(),
                  format: AmericanDateFormats.dayOfWeek),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: _selectedScreen,
      ),
    );
  }
}
