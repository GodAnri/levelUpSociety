import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:giveaway_app/models/donation.dart';
import 'package:giveaway_app/services/database.dart';

class DonateDetails extends StatefulWidget {
  DonateDetails({Key key}) : super(key: key);

  @override
  _DonateDetails createState() => _DonateDetails();
}

class _DonateDetails extends State<DonateDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final key = GlobalKey<AnimatedListState>();
  final items = [];

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Donation>>.value(
        value: DatabaseService().donations, child: Scaffold());
  }
}
