import 'package:cycle_store_app/auth/auth.dart';
import 'package:cycle_store_app/auth/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget
{
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Dashboard'),
            onTap: () {
              GoRouter.of(context).goNamed('dashboard');
              // Update the state of the app.
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Activities'),
            onTap: () {
              GoRouter.of(context).goNamed('activity.index');
              // Update the state of the app.
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Routes'),
            onTap: () {
              // Update the state of the app.
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Tours'),
            onTap: () {
              // Update the state of the app.
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Places'),
            onTap: () {
              // Update the state of the app.
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Backups'),
            onTap: () {
              // Update the state of the app.
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              // Update the state of the app.
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Log Out'),
            onTap: () {
              AuthProvider().logout();
              Provider.of<CurrentUser>(context, listen: false).user = null;
            },
          ),
        ],
      ),
    );
  }

}