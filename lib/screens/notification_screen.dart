import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static const routName = "/app-notification-screen";
  static Color bgColour = Colors.blue.shade200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColour,
        title: Text("Notifications"),
      ),
    );
  }
}
