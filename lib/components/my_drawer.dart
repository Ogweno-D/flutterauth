import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterauth/services/auth_service.dart';

import '../pages/settings_page.dart';
import 'my_drawer_tile.dart';

class MyDrawer extends StatelessWidget {
   MyDrawer({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // App Icon
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Icon(
              Icons.lock_open_rounded,
              size: 100,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

          Text(user.email!),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

          // Home
          MyDraweTile(
              text: "H O M E",
              onTap: () => Navigator.pop(context),
              icon: Icons.home_filled),

          // Settings
          MyDraweTile(
              text: "S E T T I N G S",
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              },
              icon: Icons.settings),

          const Spacer(),
          // Logout
          MyDraweTile(
              text: "L O G O U T", 
              onTap: ()=>AuthService().signOut(), 
              icon: Icons.logout),

          const Spacer()
        ],
      ),
    );
  }
}
