import 'package:cycle_store_app/api/factory.dart';
import 'package:cycle_store_app/api/models/activity.dart';
import 'package:cycle_store_app/api/repositories/activity.dart';
import 'package:cycle_store_app/widgets/page.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final PagingController<int, Activity> _pagingController =
      PagingController(firstPageKey: 1);

  List<Activity> activities = [
    Activity(
        id: 55,
        name: 'Test Name',
        description: 'Test Desc',
        fileId: 3,
        linkedTo: {},
        userId: 2,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(), startedAt: DateTime.now())
  ];

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchActivities(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
        header: 'Activities',
        child: Scrollbar(
            child: PagedListView<int, Activity>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Activity>(
            itemBuilder: (context, Activity activity, index) =>
                Text(activities[index].name ?? 'No Name'),
          ),
        )));
  }

  Future<void> _fetchActivities(pageKey) async {
    try {
      ActivityRepository activityRepository =
          ActivityRepository(await ClientFactory.create());
      List<Activity> activities =
          await activityRepository.getActivities(page: pageKey, perPage: 10);
      if (activityRepository.moreActivities == false) {
        _pagingController.appendLastPage(activities);
      } else {
        _pagingController.appendPage(activities, pageKey + 1);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
}
