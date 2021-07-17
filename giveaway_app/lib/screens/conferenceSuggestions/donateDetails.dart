import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcon_app/models/donation.dart';
import 'package:smartcon_app/screens/conferenceSuggestions/shoppingItem.dart';
import 'package:smartcon_app/services/database.dart';

import '../profile.dart';
import 'conferenceList.dart';

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
