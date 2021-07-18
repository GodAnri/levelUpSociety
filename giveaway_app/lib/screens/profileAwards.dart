import 'package:flutter/material.dart';
import 'package:giveaway_app/models/user.dart';
import 'package:giveaway_app/screens/profile.dart';
import 'package:giveaway_app/screens/wheel.dart';
import 'package:giveaway_app/services/database.dart';
import 'package:provider/provider.dart';

class ProfileAwards extends StatefulWidget {
  const ProfileAwards({Key key, this.userId, this.coins}) : super(key: key);

  final String userId;
  final int coins;

  @override
  _ProfileAwardsState createState() => _ProfileAwardsState();
}

class _ProfileAwardsState extends State<ProfileAwards> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final user = Provider.of<GiveAwayUser>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          return Scaffold(
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
                              color: Color(0xFFec5568),
                              fontSize: 32.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.1,
                              left: MediaQuery.of(context).size.width * 0.22,
                            ),
                            child: Row(children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Text(
                                  userData.coins.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 70.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Rubik',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                child: Image.asset(
                                  'images/coins.png',
                                  height: 70,
                                  width: 70,
                                ),
                              ),
                            ]))
                      ])),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.11,
                  right: MediaQuery.of(context).size.width * 0.11,
                  top: MediaQuery.of(context).size.width * 0.1,
                ),
                child: ButtonTheme(
                  padding: EdgeInsets.all(30),
                  minWidth: MediaQuery.of(context).size.width * 0.1,
                  child: RaisedButton(
                      color: Color(0xFFec5568),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      highlightElevation: 20.0,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Wheel()),
                        );
                      },
                      child: Row(children: [
                        Text(
                          "Spin the Wheel             10",
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
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
                  top: MediaQuery.of(context).size.width * 0.10,
                ),
                child: ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  child: RaisedButton(
                    padding: EdgeInsets.all(30),
                    key: Key('history_btn'),
                    color: Color(0xFFffD2A76E),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    highlightElevation: 20.0,
                    onPressed: () {},
                    child: Text(
                      "Donation History and State",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.10,
                ),
                child: ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  child: RaisedButton(
                    padding: EdgeInsets.all(30),
                    key: Key('history_btn'),
                    color: Color(0xFFffD2A76E),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    highlightElevation: 20.0,
                    onPressed: () {},
                    child: Text(
                      "Edit Profile",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ),
            ])),
          );
        });
  }
}
