import 'dart:developer';

import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Navigator(
          key: _navigatorKey,
          onGenerateRoute: (routeSettings) {
            return MaterialPageRoute(
              builder: (context) => Center(
                child: Container(
                  margin: const EdgeInsets.all(50),
                  child: Image.asset("assets/images/logo_seacorp.png"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
