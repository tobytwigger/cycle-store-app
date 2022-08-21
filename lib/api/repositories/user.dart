
import 'dart:convert';

import 'package:cycle_store_app/api/client.dart';
import 'package:cycle_store_app/api/models/user.dart';
import 'package:cycle_store_app/utils/constants.dart';

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