import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  WelcomeState createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text('Welcome!'),
        ElevatedButton(onPressed: () => GoRouter.of(context).go('/login'), child: const Text('Go to login'))
      ],
    );
  }
}