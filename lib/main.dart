import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/dashboard.dart';
import './screens/login.dart';
import './auth/auth.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (BuildContext context) => AuthProvider(),
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sanctum Books',
        home: new Scaffold(
          body: Center(
              child: Consumer<AuthProvider>(
                builder: (context, auth, child) {
                  switch (auth.isAuthenticated) {
                    case true:
                      return Dashboard();
                    default:
                      return LoginForm();
                  }
                },
              )
          ),
        )
    );
  }
}