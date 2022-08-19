import 'package:cycle_store_app/auth/guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class AuthProvider {

  late UserGuard _userGuard;

  AuthProvider([UserGuard? userGuard]) {
    _userGuard = userGuard ?? UserGuard();
  }

  Future<bool> login(String email, String password) async {
    final response = await http.post(Uri.parse('$API_URL/token'), body: {
      'email': email,
      'password': password,
      'device_name': await _getDeviceId(),
    }, headers: {
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      String token = response.body;
      await _userGuard.store(token);
      return true;
    }

    if (response.statusCode == 422) {
      return false;
    }

    return false;
  }

  _getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return androidInfo.model;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.utsname.machine;
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
  }

  logout() async {
    return _userGuard.clear();
  }

  // Future<String?> user(BuildContext context) async {
  //   String? token = await Provider.of<AuthProvider>(context, listen: false).getToken();
  //   if(token == null) {
  //     throw Exception('User must be logged in');
  //   }
  //   final response = await http.get(Uri.parse('$API_URL/user'), headers: {
  //     'Authorization': 'Bearer $token',
  //   });
  //   inspect(response);
  //
  //   if (response.statusCode == 200) {
  //   //   List<dynamic> data = json.decode(response.body);
  //   //   for (int i = 0; i < data.length; i++) {
  //   //     dashboards.add(Dashboard.fromJson(data[i]));
  //   //   }
  //   //   return dashboards;
  //   } else {
  //     throw Exception('Problem loading user information.');
  //   }
  // }

}