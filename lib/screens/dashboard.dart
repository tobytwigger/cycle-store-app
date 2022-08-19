import 'package:cycle_store_app/api/client.dart';
import 'package:cycle_store_app/api/models.dart';
import 'package:cycle_store_app/auth/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../auth/auth.dart';
import 'dart:convert';
import './../utils/constants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          child: const Text('Logout'),
          onPressed: () {
            AuthProvider().logout();
            Provider.of<CurrentUser>(context).user = null;
          },
        ),
        const Text('You are logged in'),
      ],
    );
  }
}