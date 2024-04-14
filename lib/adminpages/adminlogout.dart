import 'package:flutter/material.dart';
import 'package:game/auth/login.dart';

class AdminLogout extends StatefulWidget {
  const AdminLogout({super.key});

  @override
  State<AdminLogout> createState() => _AdminLogoutState();
}

class _AdminLogoutState extends State<AdminLogout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Text('Go To Login Page'),
            ),
          ],
        ),
      ),
    );
  }
}
