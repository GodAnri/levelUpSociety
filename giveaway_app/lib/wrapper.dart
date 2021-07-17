import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcon_app/models/user.dart';
import 'package:smartcon_app/screens/homePage.dart';
import 'package:smartcon_app/screens/login.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return either Home or Login
    final user = Provider.of<SmartconUser>(context);

    if (user == null) {
      return LoginPage();
    } else {
      return HomePage();
    }
  }
}
