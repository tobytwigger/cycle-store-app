import 'package:cycle_store_app/api/client.dart';
import 'package:cycle_store_app/api/models/user.dart';
import 'package:cycle_store_app/auth/currentUser.dart';
import 'package:cycle_store_app/widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../auth/auth.dart';
import 'dart:convert';
import './../utils/constants.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return PageWidget(
        header: 'DashboardScreen',
        child: Column(
          children: const <Widget>[
            Text('You are logged in'),
          ],
        )
    );
  }
}