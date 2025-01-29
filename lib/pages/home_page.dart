import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterauth/components/my_drawer.dart';
import 'package:flutterauth/services/auth_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? currentUser = AuthService().currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Text(
              "",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => AuthService().signOut(),
          )
        ],
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Text(
          "Welcome  ${currentUser!.email!}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
