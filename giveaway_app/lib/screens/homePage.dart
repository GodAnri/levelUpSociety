import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:giveaway_app/screens/profileAwards.dart';
import 'package:giveaway_app/services/auth.dart';
import '../wrapper.dart';
import 'conferenceSuggestions/donate.dart';
import 'conferenceSuggestions/specialDonation.dart';
import 'insertConference/insertConference.dart';

class HomePage extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key('home_page'),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset('images/homeHeader.png', fit: BoxFit.fill),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.18,
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 55.0, right: 10.0),
                              child: Image.asset('images/logo.png', width: 60),
                            ),
                            Text(
                              "GiveAway",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(
                            "It's never been easier to donate",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Rubik',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.08,
                        top: MediaQuery.of(context).size.width * 0.08,
                      ),
                      child: RaisedButton(
                        key: Key('sign_out_btn'),
                        onPressed: () async {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Wrapper()),
                              (Route<dynamic> route) => route is HomePage);
                          await _auth.signOutGoogle();
                        },
                        color: Color(0xFF6E96EF),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "SIGN OUT",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.08,
                        top: MediaQuery.of(context).size.width * 0.08,
                      ),
                      child: Row(children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.08,
                          child: Image.asset(
                            'images/coins.png',
                            height: 20,
                            width: 20,
                          ),
                        ),
                        RaisedButton(
                          key: Key('manage_profile_btn'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileAwards()),
                            );
                          },
                          color: Color(0xFF6E96EF),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "PROFILE",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ])),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.08,
            ),
            child: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * 0.6,
              child: RaisedButton(
                key: Key('donate_btn'),
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
                  "Donate Know",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.03,
              right: MediaQuery.of(context).size.width * 0.15,
              left: MediaQuery.of(context).size.width * 0.15,
            ),
            child: Text("Don't have any products? We'll buy them for you",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6E96EF),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Rubik',
                )),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.01,
              right: MediaQuery.of(context).size.width * 0.20,
              left: MediaQuery.of(context).size.width * 0.20,
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
                      MaterialPageRoute(builder: (context) => SpecialDonate()),
                    );
                  },
                  child: Row(children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Image.asset(
                        'images/coins.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Text(
                      "Special donation",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ])),
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
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Text(
                  "Our Parteners",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.02,
              right: MediaQuery.of(context).size.width * 0.15,
              left: MediaQuery.of(context).size.width * 0.15,
            ),
            child: Text("Are you an organization? Join us on this mission",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5BBDB8),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Rubik',
                )),
          ),
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width * 0.6,
            child: RaisedButton(
              key: Key('insert_conference_btn'),
              color: Color(0xFF5BBDB8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              highlightElevation: 20.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InsertConference()),
                );
              },
              child: Text(
                "Start partnership",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ])));
  }
}

class MdiIcons {}
