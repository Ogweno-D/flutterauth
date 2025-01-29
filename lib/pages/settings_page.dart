import 'package:flutter/material.dart';

import '../components/my_drawer.dart';
import '../services/auth_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: ()=>AuthService().signOut(),
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