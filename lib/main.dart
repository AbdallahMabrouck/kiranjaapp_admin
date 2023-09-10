import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kiranjaapp_admin/screens/banners_screen.dart';
import 'package:kiranjaapp_admin/screens/category_screen.dart';
import 'package:kiranjaapp_admin/screens/delivery_boy_screen.dart';
import 'package:kiranjaapp_admin/screens/home_screen.dart';
import 'package:kiranjaapp_admin/screens/login_screen.dart';
import 'package:kiranjaapp_admin/screens/notification_screen.dart';
import 'package:kiranjaapp_admin/screens/orders_screen.dart';
import 'package:kiranjaapp_admin/screens/splash_screen.dart';
import 'package:kiranjaapp_admin/screens/vendor_screen.dart';
import 'package:kiranjaapp_admin/widgets/admin_users.dart';
import 'package:kiranjaapp_admin/widgets/settings.dart';
import 'package:kiranjaapp_admin/widgets/side_menu.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kiranja - Admin',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(
              title: 'Kiranja - Admin',
            ),
        SideMenu.id: (context) => const SideMenu(),
        BannersScreen.id: (context) => const BannersScreen(),
        VendorsScreen.id: (context) => const VendorsScreen(),
        CategoryScreen.id: (context) => const CategoryScreen(),
        OrdersScreen.id: (context) => const OrdersScreen(),
        NotificationsScreen.id: (context) => const NotificationsScreen(),
        AdminUsers.id: (context) => const AdminUsers(),
        Settings.id: (context) => const Settings(),
        DeliveryBoyScreen.id: (context) => const DeliveryBoyScreen(),
      },
      builder: EasyLoading.init(),
    );
  }
}
