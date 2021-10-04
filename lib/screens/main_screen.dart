import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth/login_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = "/main-screen";
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, authSnapshot) {
          if (authSnapshot.connectionState != ConnectionState.active) {
            return Center(child: CircularProgressIndicator());
          }
          final user = authSnapshot.data;
          if (user != null) {
            debugPrint("Home Screen");
            return HomeScreen();
          } else {
            debugPrint("Login Screen");
            return LoginScreen();
          }
        });
  }
}
