import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:giveaway_app/models/conferenceNO.dart';

class InsertConference extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InsertConferenceState();
  }
}

class InsertConferenceState extends State<InsertConference> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name;
  String _district;
  List<DateTime> _dates = [];
  String _category;
  String _description;
  String _website = '';
  Conference _conference;

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

  buildConference() {
    _conference = new Conference(
        name: _name,
        category: _category,
        district: _district,
        website: _website,
        description: _description,
        beginDate: _dates[0],
        endDate: _dates[0],
        rating: 0);
  }

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

  Widget _buildDistrict() {
    return Tooltip(
      message: 'district_field',
      child: DropDownFormField(
        titleText: 'District',
        hintText: 'Choose a district',
        value: _district,
        onSaved: (value) {
          setState(() {
            _district = value;
          });
        },
        onChanged: (value) {
          setState(() {
            _district = value;
          });
        },
        validator: (value) {
          if (value == null) {
            return 'Please choose a district';
          }
          return null;
        },
        dataSource: [
          {
            "display": "Porto",
            "value": "Porto",
          },
          {
            "display": "Aveiro",
            "value": "Aveiro",
          },
          {
            "display": "Lisboa",
            "value": "Lisboa",
          },
          {
            "display": "Viana do Castelo",
            "value": "Viana do Castelo",
          },
          {
            "display": "Faro",
            "value": "Faro",
          },
        ],
        textField: 'display',
        valueField: 'value',
      ),
    );
  }

  Widget _buildDate() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.84,
      child: Row(children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.54,
          height: 50.0,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2.0, color: Colors.black26),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Text(datesStr,
              key: Key('dates_field'),
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
                color: Color(0xFF5BBDB8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                highlightElevation: 40.0,
                onPressed: () async {
                  final List<DateTime> picked =
                      await DateRagePicker.showDatePicker(
                    context: context,
                    initialFirstDate: new DateTime.now(),
                    initialLastDate:
                        (new DateTime.now()).add(new Duration(days: 7)),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2222),
                  );
                  if (picked != null && picked.length == 2) {
                    _onDateChanged(picked);
                  }
                },
                child: Text(
                  "Date",
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                )),
          ),
        ),
      ]),
    );
  }

  Widget _buildCategory() {
    return Tooltip(
      message: 'category_field',
      child: DropDownFormField(
        titleText: 'Category',
        hintText: 'Category',
        value: _category,
        onSaved: (value) {
          setState(() {
            _category = value;
          });
        },
        onChanged: (value) {
          setState(() {
            _category = value;
          });
        },
        validator: (value) {
          if (value == null) {
            return 'Please choose a category';
          }
          return null;
        },
        dataSource: [
          {
            "display": "Technology",
            "value": "Technology",
          },
          {
            "display": "Hygiene",
            "value": "Hygiene",
          },
          {
            "display": "Cultural",
            "value": "Cultural",
          },
          {
            "display": "Children",
            "value": "Children",
          },
          {
            "display": "Environmental",
            "value": "Environmental",
          },
          {
            "display": "Clothes",
            "value": "Clothes",
          },
          {
            "display": "Literature",
            "value": "Literature",
          },
          {
            "display": "Animals",
            "value": "Animals",
          },
          {
            "display": "Scientific",
            "value": "Scientific",
          },
          {
            "display": "Wellness",
            "value": "Wellness",
          },
        ],
        textField: 'display',
        valueField: 'value',
      ),
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      key: Key('insert_conference_description'),
      decoration: new InputDecoration(
        labelText: "Description",
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(10.0),
          borderSide: new BorderSide(),
        ),
      ),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Description is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _description = value;
      },
    );
  }

  Widget _buildWebsite() {
    return TextFormField(
      decoration: new InputDecoration(
        labelText: "Website",
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(10.0),
          borderSide: new BorderSide(),
        ),
      ),
      keyboardType: TextInputType.url,
      validator: (String value) {},
      onSaved: (String value) {
        _website = value;
      },
    );
  }

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
              top: MediaQuery.of(context).size.width * 0.05,
              left: MediaQuery.of(context).size.width * 0.08,
              right: MediaQuery.of(context).size.width * 0.08,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Insert Your Organization",
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        color: Color(0xfffc4058),
                        fontSize: 32.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  )
                ])),
        // CONTENT ROW
        Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                SizedBox(height: 15),
                _buildCategory(),
                SizedBox(height: 15),
                _buildDescription(),
                SizedBox(height: 15),
                _buildWebsite(),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(8),
                  child: RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.black26, width: 2)),
                    child: Text('NEXT',
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Rubik',
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ])),
    );
  }
}
