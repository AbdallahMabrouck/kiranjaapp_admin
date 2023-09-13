/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_admin/screens/home_screen.dart';
import 'package:kiranjaapp_admin/widgets/sidebar.dart';

import '../firebase_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});
  static const id = "login-screen";

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SideBarWidget sideBar = SideBarWidget();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final _formKey = GlobalKey<FormState>();
  final FirebaseService _service = FirebaseService();
  String? username;
  String? password;

  Future<void> _login() async {
    final credentialsQuerySnapshot = await _service
        .getAdminCredentials(); // Assuming _service.getAdminCredentials() returns a Future<QuerySnapshot>.

    for (QueryDocumentSnapshot credentialsSnapshot
        in credentialsQuerySnapshot.docs) {
      final credentialsData =
          credentialsSnapshot.data() as Map<String, dynamic>;

      final storedUsername = credentialsData["username"];
      final storedPassword = credentialsData["password"];

      if (storedUsername == username && storedPassword == password) {
        final userCredential = await FirebaseAuth.instance.signInAnonymously();
        if (userCredential.user?.uid != null) {
          _navigatorKey.currentState?.pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen(),
            ),
          );
          return;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        // initialize flutter fire
        future: _initialization,
        builder: (context, snapshot) {
          // check for errors
          if (snapshot.hasError) {
            return const Center(
              child: Text("Connection Failed"),
            );
          }

          // once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF262AAA), Colors.white],
                  stops: [1.0, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment(0.0, 0.0),
                ),
              ),
              child: Center(
                child: SizedBox(
                  width: 500,
                  height: 500,
                  child: Card(
                    elevation: 6,
                    shape: Border.all(color: const Color(0xFF262AAA), width: 2),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                      height: 200,
                                      child: Image.asset(
                                          "assets/images/kiranja-logo.png")),
                                  const Text(
                                    "Kiranja - Admin",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Username";
                                      }
                                      setState(() {
                                        username = value;
                                      });
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        labelText: "Username",
                                        prefixIcon: Icon(Icons.person),
                                        focusColor: Color(0xFF262AAA),
                                        contentPadding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF262AAA),
                                                width: 2))),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Password";
                                      }
                                      if (value.length < 6) {
                                        return "Minimum 6 characters";
                                      }
                                      setState(() {
                                        password = value;
                                      });
                                      return null;
                                    },
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        labelText: "Minimum 6 characters",
                                        prefixIcon:
                                            Icon(Icons.vpn_key_off_rounded),
                                        hintText: "Password",
                                        focusColor: Color(0xFF262AAA),
                                        contentPadding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF262AAA),
                                                width: 2))),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          _login();
                                        }
                                      },
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          // otherwise
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_admin/widgets/side_menu.dart';

import '../firebase_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});
  static const id = "login-screen";

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final _formKey = GlobalKey<FormState>();
  final FirebaseService _service = FirebaseService();
  String? username;
  String? password;

  Future<void> _login() async {
    try {
      // Get a list of admin credentials from Firebase
      final credentialsQuerySnapshot = await _service.getAdminCredentials();

      for (QueryDocumentSnapshot credentialsSnapshot
          in credentialsQuerySnapshot.docs) {
        final credentialsData =
            credentialsSnapshot.data() as Map<String, dynamic>;

        final storedUsername = credentialsData["username"];
        final storedPassword = credentialsData["password"];

        // Check if provided username and password match any admin credentials
        if (storedUsername == username && storedPassword == password) {
          // Sign in anonymously using Firebase Authentication
          final userCredential =
              await FirebaseAuth.instance.signInAnonymously();
          if (userCredential.user != null) {
            // Navigate to the home screen upon successful login
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const SideMenu(),
              ),
            );
            return;
          }
        }
      }

      // Show an error message if no matching credentials were found
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid username or password"),
        ),
      );
    } catch (e) {
      print("Error during login: $e");
      // Handle login error here, e.g., show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        // Initialize Firebase
        future: _initialization,
        builder: (context, snapshot) {
          // Check for initialization errors
          if (snapshot.hasError) {
            return const Center(
              child: Text("Connection Failed"),
            );
          }

          // Once initialization is complete, show the login form
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF262AAA), Colors.white],
                  stops: [1.0, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment(0.0, 0.0),
                ),
              ),
              child: Center(
                child: SizedBox(
                  width: 500,
                  height: 500,
                  child: Card(
                    elevation: 6,
                    shape: Border.all(color: const Color(0xFF262AAA), width: 2),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                      height: 200,
                                      child: Image.asset(
                                          "assets/images/kiranja-logo.png")),
                                  const Text(
                                    "Kiranja - Admin",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Username";
                                      }
                                      setState(() {
                                        username = value;
                                      });
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        labelText: "Username",
                                        prefixIcon: Icon(Icons.person),
                                        focusColor: Color(0xFF262AAA),
                                        contentPadding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF262AAA),
                                                width: 2))),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Password";
                                      }
                                      if (value.length < 6) {
                                        return "Minimum 6 characters";
                                      }
                                      setState(() {
                                        password = value;
                                      });
                                      return null;
                                    },
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        labelText: "Password",
                                        prefixIcon:
                                            Icon(Icons.vpn_key_off_rounded),
                                        hintText: "Minimum 6 characters",
                                        focusColor: Color(0xFF262AAA),
                                        contentPadding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF262AAA),
                                                width: 2))),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          _login();
                                        }
                                      },
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          // Show a loading indicator while initializing Firebase
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
