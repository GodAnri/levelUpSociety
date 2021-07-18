import 'package:flutter/material.dart';
import 'package:giveaway_app/screens/wheel.dart';

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
                  Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.08,
                        left: MediaQuery.of(context).size.width * 0.2,
                      ),
                      child: Row(children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Text(
                            "20",
                            style: TextStyle(
                              color: Colors.pink,
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
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ]))
                ])),
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.18,
            right: MediaQuery.of(context).size.width * 0.18,
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
                    MaterialPageRoute(builder: (context) => Wheel()),
                  );
                },
                child: Row(children: [
                  Text(
                    "Spin the Wheel - 10",
                    style: Theme.of(context).textTheme.headline6,
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
            minWidth: MediaQuery.of(context).size.width * 0.6,
            child: RaisedButton(
              key: Key('history_btn'),
              color: Color(0xFF6E96EF),
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
            minWidth: MediaQuery.of(context).size.width * 0.6,
            child: RaisedButton(
              key: Key('history_btn'),
              color: Color(0xFF6E96EF),
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
  }
}
