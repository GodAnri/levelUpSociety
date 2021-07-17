import 'dart:async';
import 'dart:math';

import 'package:chips_choice/chips_choice.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcon_app/models/user.dart';
import 'package:smartcon_app/screens/profile.dart';
import 'package:smartcon_app/services/database.dart';

import 'conferenceSuggestions/donate.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';

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
                  MaterialPageRoute(builder: (context) => Wheel()),
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

class SpiningWheel extends StatefulWidget {
  @override
  _SpiningWheelState createState() => _SpiningWheelState();
}

class _SpiningWheelState extends State<SpiningWheel> {
  final StreamController _dividerController = StreamController<int>();

  final _wheelNotifier = StreamController<double>();
  @override
  void dispose() {
    super.dispose();
    _dividerController.close();
    _wheelNotifier.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xffDDC3FF), elevation: 0.0),
      backgroundColor: Color(0xffDDC3FF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinningWheel(
              Image.asset('images/roulette.png'),
              width: 310,
              height: 310,
              initialSpinAngle: _generateRandomAngle(),
              spinResistance: 0.6,
              canInteractWhileSpinning: false,
              dividers: 8,
              onUpdate: _dividerController.add,
              onEnd: _dividerController.add,
              secondaryImage: Image.asset('images/roulettecenter.png'),
              secondaryImageHeight: 110,
              secondaryImageWidth: 110,
              shouldStartOrStop: _wheelNotifier.stream,
            ),
            SizedBox(height: 30),
            StreamBuilder(
              stream: _dividerController.stream,
              builder: (context, snapshot) =>
                  snapshot.hasData ? RouletteScore(snapshot.data) : Container(),
            ),
            SizedBox(height: 30),
            new ElevatedButton(
              child: new Text("Start"),
              onPressed: () =>
                  _wheelNotifier.sink.add(_generateRandomVelocity()),
            )
          ],
        ),
      ),
    );
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 2000;

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

class RouletteScore extends StatelessWidget {
  final int selected;

  final Map<int, String> labels = {
    1: '1000\$',
    2: '400\$',
    3: '800\$',
    4: '7000\$',
    5: '5000\$',
    6: '300\$',
    7: '2000\$',
    8: '100\$',
  };

  RouletteScore(this.selected);

  @override
  Widget build(BuildContext context) {
    return Text('${labels[selected]}',
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 24.0));
  }
}
