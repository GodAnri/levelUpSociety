import 'package:chips_choice/chips_choice.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcon_app/models/user.dart';
import 'package:smartcon_app/screens/profile.dart';
import 'package:smartcon_app/services/database.dart';

class ProfileAwards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key('home_page'),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Stack(children: <Widget>[
            // HEADER IMAGE (100%)
            Row(children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset('images/pageHeader.png', fit: BoxFit.fill),
              ),
            ]),
            // CONTENT ROW
            Row(children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08,
                    right: MediaQuery.of(context).size.width * 0.08,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Page title
                        Container(
                          width: MediaQuery.of(context).size.width * 0.84,
                          child: Text(
                            "Hey Angel",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          alignment: Alignment.topLeft,
                        ),
                      ]))
            ])
          ])
        ])));
  }
}
