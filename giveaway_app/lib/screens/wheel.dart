import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:giveaway_app/models/user.dart';
import 'package:giveaway_app/screens/profileAwards.dart';
import 'package:giveaway_app/services/database.dart';
import 'package:provider/provider.dart';

import 'homePage.dart';

class Wheel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: Key('insert_conference_page'), body: SpiningWheel());
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
    // TODO: implement build
    final user = Provider.of<GiveAwayUser>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          return Scaffold(
            appBar: AppBar(backgroundColor: Color(0xfffee4c0), elevation: 0.0),
            backgroundColor: Color(0xfffee4c0),
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
                    builder: (context, snapshot) => snapshot.hasData
                        ? RouletteScore(snapshot.data)
                        : Container(),
                  ),
                  SizedBox(height: 30),
                  new ElevatedButton(
                      child: new Text("Spin"),
                      onPressed: () async {
                        if (userData.coins < 10) {
                          showAlertDialog(context);
                        } else {
                          await DatabaseService(uid: user.uid)
                              .updateProfile(userData.coins - 10);
                          _wheelNotifier.sink.add(_generateRandomVelocity());
                        }
                      })
                ],
              ),
            ),
          );
        });
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 2000;

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

class RouletteScore extends StatelessWidget {
  final int selected;

  final Map<int, String> labels = {
    1: 'Spin Again',
    2: 'Double donation',
    3: 'Sorry',
    4: 'Double coins',
    5: 'Special Donation',
    6: 'Extra Coins',
    7: 'Sorry',
    8: 'Special Donation',
  };

  RouletteScore(this.selected);

  @override
  Widget build(BuildContext context) {
    return Text('${labels[selected]}',
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 24.0));
  }
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
        color: Color(0xffec5568),
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
