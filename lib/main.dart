import 'package:cycle_store_app/api/factory.dart';
import 'package:cycle_store_app/api/models/user.dart';
import 'package:cycle_store_app/api/repositories/user.dart';
import 'package:cycle_store_app/auth/currentUser.dart';
import 'package:cycle_store_app/auth/guard.dart';
import 'package:cycle_store_app/screens/activity.dart';
import 'package:cycle_store_app/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import './screens/dashboard.dart';
import './screens/login.dart';
import 'auth/auth.dart';
import 'dart:developer';

void main() {
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => CurrentUser(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<User?> _future;

  Future<User?> loadCurrentUser() async {
    try {
      log('Starting');

      var factory = await ClientFactory.create();
        log('HERE');
        return await UserRepository(factory).getCurrentUser();
      } catch (e) {
      log(e.toString());
      return null;
    }
  }

  User? user;

  @override
  void initState() {
    super.initState();
    _future = loadCurrentUser();
    _future.then((User? currentUser) => setState(() => user = currentUser));
    _future.then((User? currentUser) => Provider.of<CurrentUser>(context, listen: false).user = currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          return MaterialApp.router(
            title: 'Cycle Store',
            routeInformationProvider: _router.routeInformationProvider,
            routeInformationParser: _router.routeInformationParser,
            routerDelegate: _router.routerDelegate,
          );
        });
  }

  late final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: 'welcome',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomeScreen();
        },
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (BuildContext context, GoRouterState state) {
          return const DashboardScreen();
        },
      ),
      GoRoute(
        path: '/activity',
        name: 'activity.index',
        builder: (BuildContext context, GoRouterState state) {
          return const ActivityScreen();
        },
      ),
    ],

    // redirect to the login page if the user is not logged in
    redirect: (GoRouterState state) {
      // if the user is not logged in, they need to login
      final bool loggedIn =
          Provider.of<CurrentUser>(context, listen: false).user != null;
      log(loggedIn ? 'Y' : 'N');
      final bool guestAllowed = ['/login', '/'].contains(state.subloc);
      if (!loggedIn) {
        return guestAllowed ? null : '/login';
      }

      // if the user is logged in but still on the login page, send them to
      // the home page
      if (guestAllowed) {
        return '/dashboard';
      }

      // no need to redirect at all
      return null;
    },
    refreshListenable: Provider.of<CurrentUser>(context),
  );
}
