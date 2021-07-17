import 'package:chips_choice/chips_choice.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcon_app/models/user.dart';
import 'package:smartcon_app/screens/profile.dart';
import 'package:smartcon_app/services/database.dart';

import 'conferenceSuggestions/donate.dart';

class ProfileAwards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('insert_conference_page'),
      body: SingleChildScrollView(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(children: <Widget>[
        Row(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Image.asset('images/pageHeader.png', fit: BoxFit.fill),
          ),
        ]),
        Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.08,
              right: MediaQuery.of(context).size.width * 0.08,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Profile",
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        color: Color(0xFF5BBDB8),
                        fontSize: 32.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Row(children: [
                    Text(
                      "20",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Image.asset(
                        'images/coins.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ])
                ])),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.02,
          ),
          child: ButtonTheme(
            minWidth: MediaQuery.of(context).size.width * 0.6,
            child: RaisedButton(
              color: Color(0xFF6E96EF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              highlightElevation: 20.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Donate()),
                );
              },
              child: Text(
                "Redeem vouchers",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.02,
          ),
          child: ButtonTheme(
            minWidth: MediaQuery.of(context).size.width * 0.6,
            child: RaisedButton(
              color: Color(0xFF6E96EF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              highlightElevation: 20.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Donate()),
                );
              },
              child: Text(
                "Donation history",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ),
      ])),
    );
  }
}
