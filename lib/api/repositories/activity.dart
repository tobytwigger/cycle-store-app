import 'dart:convert';
import 'dart:developer';

import 'package:cycle_store_app/api/client.dart';
import 'package:cycle_store_app/api/factory.dart';
import 'package:cycle_store_app/api/models/activity.dart';
import 'package:cycle_store_app/api/models/user.dart';
import 'package:cycle_store_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ActivityRepository {
  Client client;

  ActivityRepository(this.client);

  bool moreActivities = true;

  Future<List<Activity>> getActivities(
      {required int page, int perPage = 10}) async {
    var response = await client
        .get(Uri.parse('$API_URL/activity?page=$page&perPage=$perPage'));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      moreActivities = body['current_page'] < body['last_page'];
      List<Activity> activities = [];
      body['data'].forEach(
          (activityJson) => activities.add(Activity.fromJson(activityJson)));
      return activities;
    }

    return [];
  }
}
