import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcon_app/models/donation.dart';
import 'package:smartcon_app/services/database.dart';

import '../profile.dart';
import 'conferenceList.dart';

class Donate extends StatefulWidget {
  Donate({Key key}) : super(key: key);

  @override
  _Donate createState() => _Donate();
}

class _Donate extends State<Donate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _rating = false;
  bool _near = false;
  List<DateTime> _dates = [];
  String datesStr = 'Must Pick a date';

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

  Widget _buildName() {
    return TextFormField(
      key: Key('name_field'),
      decoration: new InputDecoration(
        labelText: "Name",
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
            return 'Please choose an organization';
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
    return StreamProvider<List<Donation>>.value(
      value: DatabaseService().donations,
      child: Scaffold(
        key: Key('donate_page'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                          "Donate",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        alignment: Alignment.topLeft,
                      ),

                      //Manage Profile Button
                      SizedBox(height: 10),
                      RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.black26, width: 2)),
                        highlightElevation: 40.0,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profile()),
                          );
                        },
                        child: Text("MANAGE PROFILE",
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Rubik',
                            )),
                      ),

                      SizedBox(height: 20),
                      Text(
                        'DATE',
                        style: Theme.of(context).textTheme.headline3,
                      ),

                      // Date Picker
                      SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.84,
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.54,
                              height: 50.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 2.0, color: Colors.black26),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Text(datesStr,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Rubik',
                                  )),
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: ButtonTheme(
                                height: 50,
                                child: MaterialButton(
                                    color: Color(0xFF6E96EF),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    highlightElevation: 40.0,
                                    onPressed: () async {
                                      final List<DateTime> picked =
                                          await DateRagePicker.showDatePicker(
                                        context: context,
                                        initialFirstDate: new DateTime.now(),
                                        initialLastDate: (new DateTime.now())
                                            .add(new Duration(days: 7)),
                                        firstDate: new DateTime(2020),
                                        lastDate: new DateTime(2022),
                                      );
                                      if (picked != null &&
                                          picked.length == 2) {
                                        print(picked);
                                        _onDateChanged(picked);
                                      }
                                    },
                                    child: Text(
                                      "CHANGE",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
                      Container(
                        padding: EdgeInsets.all(8),
                        child: RaisedButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                    color: Colors.black26, width: 2)),
                            child: Text('DONE ',
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Rubik',
                                )),
                            onPressed: onNext),
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                children: [
                  ConferenceList(
                      filterDistrict: _near,
                      ratingOrder: _rating,
                      dates: _dates)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  onNext() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //buildConference();
      Navigator.push(
        context,
        MaterialPageRoute(
            /*builder: (context) => conferenceSessions(
                  conference: _conference,
                )*/
            ),
      );
    }
  }
}
