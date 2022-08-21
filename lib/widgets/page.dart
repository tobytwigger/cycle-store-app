import 'package:cycle_store_app/widgets/drawer.dart';
import 'package:flutter/material.dart';

class PageWidget extends StatelessWidget
{
  final String header;

  final Widget child;

  final bool includeDrawer;

  const PageWidget({Key? key, required this.child, required this.header, this.includeDrawer = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the LoginScreen object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(header),
      ),
      drawer: includeDrawer ? DrawerWidget() : null,
      body: child
    );
  }

}