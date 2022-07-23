import 'package:cycle_store_app/auth/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import './../auth/auth.dart';
import 'dart:convert';
import './../utils/constants.dart';
import 'dart:developer';

class Client
{

  final String _token;

  Client(this._token);

  Future<User> user() async {
    final response = await http.get(Uri.parse('$API_URL/user'), headers: {
      'Authorization': 'Bearer $_token',
    });
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Problem loading user');
    }

  }
}