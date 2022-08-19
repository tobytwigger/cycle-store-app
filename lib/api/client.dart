import 'package:cycle_store_app/api/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../auth/auth.dart';
import 'dart:convert';
import './../utils/constants.dart';
import 'dart:developer';

class Client
{

  final String _token;

  Client(this._token);

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    headers ??= {};
    headers['Authorization'] = 'Bearer $_token';
    return http.get(url, headers: headers);
  }

}