import 'package:cycle_store_app/widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return PageWidget(
        includeDrawer: false,
        header: 'Dashboard',
        child: Column(
          children: <Widget>[
            const Text('Welcome!'),
            ElevatedButton(
                onPressed: () => GoRouter.of(context).go('/login'),
                child: const Text('Go to login'))
          ],
        ));
  }
}
