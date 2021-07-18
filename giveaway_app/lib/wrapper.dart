import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:giveaway_app/models/user.dart';
import 'package:giveaway_app/screens/homePage.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return either Home or Login
    final user = Provider.of<GiveAwayUser>(context);
    if (user == null)
      print("WTFFFFFFFFFFF");
    else
      return HomePage();
  }
}
