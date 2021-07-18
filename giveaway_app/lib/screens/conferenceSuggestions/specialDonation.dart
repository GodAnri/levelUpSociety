import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveaway_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:giveaway_app/models/donation.dart';
import 'package:giveaway_app/screens/insertConference/insertItems.dart';
import 'package:giveaway_app/services/database.dart';

import '../homePage.dart';

class SpecialDonate extends StatefulWidget {
  SpecialDonate({Key key}) : super(key: key);

  @override
  _SpecialDonate createState() => _SpecialDonate();
}

class _SpecialDonate extends State<SpecialDonate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _rating = false;
  bool _near = false;
  List<DateTime> _dates = [];
  String datesStr = 'Date of the delivery';

  _onDateChanged(picked) {
    setState(() {
      _dates = picked;
      datesStr = "FROM: " +
          _dates[0].toString().substring(0, 10) +
          "\nTO: " +
          _dates[1].toString().substring(0, 10);
    });
  }

  String _organization;
  String _name;
  String _money;
  List<String> _speakers = new List<String>();

  Widget _buildPhoneNumber() {
    return TextFormField(
      key: Key('number_field2'),
      decoration: new InputDecoration(
        labelText: "Phone Number",
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(10.0),
          borderSide: new BorderSide(),
        ),
      ),
      maxLength: 30,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone Number';
        }
        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildName() {
    return TextFormField(
      key: Key('name_field'),
      decoration: new InputDecoration(
        labelText: "Name of the person responsible",
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(10.0),
          borderSide: new BorderSide(),
        ),
      ),
      maxLength: 30,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildMoney() {
    return TextFormField(
      key: Key('money_field'),
      decoration: new InputDecoration(
        labelText: "How much do you want us to spend? Euros",
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(10.0),
          borderSide: new BorderSide(),
        ),
      ),
      maxLength: 30,
      validator: (String value) {
        if (value.isEmpty) {
          return 'A quantity is required';
        }
        return null;
      },
      onSaved: (String value) {
        _money = value;
      },
    );
  }

  Widget _buildOrganization() {
    return Tooltip(
      message: 'organization_field',
      child: DropDownFormField(
        titleText: 'Organization',
        hintText: 'Choose an organization',
        value: _organization,
        onSaved: (value) {
          setState(() {
            _organization = value;
          });
        },
        onChanged: (value) {
          setState(() {
            _organization = value;
          });
        },
        validator: (value) {
          if (value == null) {
            return 'Organization to donate to';
          }
          return null;
        },
        dataSource: [
          {
            "display": "Friends of the Earth",
            "value": "Friends of the Earth",
          },
          {
            "display": "MenCap",
            "value": "MenCap",
          },
          {
            "display": "The National Autistic Society",
            "value": "The National Autistic Society",
          },
          {
            "display": "UNICEF",
            "value": "UNICEF",
          },
          {
            "display": "Shelter",
            "value": "Shelter",
          },
          {
            "display": "Dogs Trust",
            "value": "Dogs Trust",
          },
          {
            "display": "The Blue Cross",
            "value": "The Blue Cross",
          },
          {
            "display": "Black Lives Matter",
            "value": "Black Lives Matter",
          },
          {
            "display": "Girlguiding",
            "value": "Girlguiding",
          },
        ],
        textField: 'display',
        valueField: 'value',
      ),
    );
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
              key: Key('donate_page'),
              body: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    // HEADER IMAGE (100%)
                    Row(children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset('images/pageHeader.png',
                            fit: BoxFit.fill),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.84,
                                  child: Text(
                                    "Donate",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  alignment: Alignment.topLeft,
                                ),
                              ]))
                    ]),

                    Container(
                      margin: EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _buildOrganization(),
                            SizedBox(height: 15),
                            _buildName(),
                            SizedBox(height: 15),
                            _buildPhoneNumber(),
                            SizedBox(height: 15),
                            _buildMoney(),
                            Text('Select a payment method:',
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Rubik',
                                )),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset('images/payment.png',
                                  fit: BoxFit.fill),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              child: RaisedButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: Colors.black26, width: 2)),
                                  child: Text('ITEMS TO BE DONATED',
                                      style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Rubik',
                                      )),
                                  onPressed: onNext),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              child: RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color: Colors.black26, width: 2)),
                                child: Text('DONATE ',
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Rubik',
                                    )),
                                onPressed: () async {
                                  await DatabaseService(uid: user.uid)
                                      .updateProfile(userData.coins - 15);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])));
        });
  }

  onNext() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //buildConference();
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Give to the organization"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InsertItems(
                    speakers: _speakers,
                  )),
        );
      },
    );

    Widget okButton2 = TextButton(
      child: Text("Please refund"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InsertItems(
                    speakers: _speakers,
                  )),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Read Carefully"),
      content: Text(
        "Read Carefully: \nSince this is a Special Donation we ask you to indicate a place or link where we can buy the products, otherwise we will resort to our default markets (you can check them in our website). \nYou have two options for any extra money you may send: it can be sent to the organisation or returned to the same account. Please choose the desired option below. Thank you.",
        style: TextStyle(
          color: Color(0xffec5568),
          fontSize: 16.0,
          fontFamily: 'Rubik',
        ),
      ),
      actions: [okButton, okButton2],
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
