
import 'dart:convert';
import 'dart:developer';

import 'package:cycle_store_app/api/client.dart';
import 'package:cycle_store_app/api/factory.dart';
import 'package:cycle_store_app/api/models.dart';
import 'package:cycle_store_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class UserRepository {

  Client client;

  UserRepository(this.client);

  Future<User?> getCurrentUser() async {
    var response = await client.get(Uri.parse('$API_URL/user'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }

    return null;
  }

}