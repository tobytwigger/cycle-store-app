import 'package:cycle_store_app/auth/client.dart';
import 'package:cycle_store_app/auth/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import './../auth/auth.dart';
import 'dart:convert';
import './../utils/constants.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  User? user;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    String? token = await Provider.of<AuthProvider>(context, listen: false).getToken();
    if(token == null) {
      throw Exception('The user is not logged in');
    }
    Client client = Client(token);
    setState(() async => user = await client.user());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          child: const Text('Logout'),
          onPressed: () {
            Provider.of<AuthProvider>(context, listen: false).logout();
          },
        ),
        user != null ? Text('Your name is ${user?.name}') : Text('The user data is loading'),
      ],
    );
  }
}