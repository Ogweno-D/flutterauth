import 'package:flutter/material.dart';
import 'package:flutterauth/components/my_drawer.dart';
import 'package:flutterauth/services/auth_service.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  final authService = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: (){},
          )
        ],
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Text("Logged In!"),
      ),
    );
  }
}
