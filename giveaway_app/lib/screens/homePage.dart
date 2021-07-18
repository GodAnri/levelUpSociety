import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveaway_app/models/user.dart';

import 'package:giveaway_app/screens/profileAwards.dart';
import 'package:giveaway_app/services/database.dart';
import 'package:provider/provider.dart';
import 'conferenceSuggestions/donate.dart';
import 'conferenceSuggestions/specialDonation.dart';
import 'insertConference/insertConference.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final user = Provider.of<GiveAwayUser>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          return Scaffold(
              key: Key('home_page'),
              body: SingleChildScrollView(
                  child: Column(children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset('images/homeHeader.png',
                          fit: BoxFit.fill),
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
                                    child: Image.asset('images/logo.png',
                                        width: 60),
                                  ),
                                  Text(
                                    "GiveAway",
                                    style:
                                        Theme.of(context).textTheme.headline1,
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
                              onPressed: () async {},
                              color: Color(0xffD2A76E),
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
                              Text(
                                userData.coins.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Rubik',
                                ),
                              ),
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
                                        builder: (context) => WrapperP()),
                                  );
                                },
                                color: Color(0xffD2A76E),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "PROFILE",
                                    style:
                                        Theme.of(context).textTheme.headline4,
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
                    top: MediaQuery.of(context).size.width * 0.07,
                  ),
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    child: RaisedButton(
                      key: Key('donate_btn'),
                      color: Color(0xffD2A76E),
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
                        "Donate Now",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.04,
                    right: MediaQuery.of(context).size.width * 0.15,
                    left: MediaQuery.of(context).size.width * 0.15,
                  ),
                  child: Text("Don't have any products? We'll buy them for you",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFC1675D),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Rubik',
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.005,
                    right: MediaQuery.of(context).size.width * 0.20,
                    left: MediaQuery.of(context).size.width * 0.20,
                  ),
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    child: RaisedButton(
                        color: Color(0xffD2A76E),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        highlightElevation: 20.0,
                        onPressed: () {
                          if (userData.coins < 15) {
                            showAlertDialog(context);
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SpecialDonate()),
                            );
                          }
                        },
                        child: Row(children: [
                          Text(
                            "Special donation",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            "  15",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.06,
                            child: Image.asset(
                              'images/coins.png',
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ])),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    child: RaisedButton(
                      color: Color(0xffD2A76E),
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
                        "Our Partners",
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
                  child:
                      Text("Are you an organization? Join us on this mission",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF95484B),
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Rubik',
                          )),
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * 0.6,
                  child: RaisedButton(
                    key: Key('insert_conference_btn'),
                    color: Color(0xffec5568),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    highlightElevation: 20.0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InsertConference()),
                      );
                    },
                    child: Text(
                      "Start partnership",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ])));
        });
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text(
        "Not enough coins",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
          fontFamily: 'Rubik',
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class WrapperP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final user = Provider.of<GiveAwayUser>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = null;
          if (snapshot.hasData) {
            userData = snapshot.data;
            return ProfileAwards();
          } else {
            return Container();
          }
        });
  }
}

class MdiIcons {}
