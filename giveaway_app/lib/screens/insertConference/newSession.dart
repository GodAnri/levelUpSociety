import 'package:flutter/material.dart';
import 'package:smartcon_app/models/sessionNO.dart';
import 'package:smartcon_app/screens/conferenceSuggestions/donate.dart';
import 'package:time_range/time_range.dart';
import 'package:smartcon_app/screens/insertConference/insertSpeakers.dart';
import 'insertItems.dart';
import 'insertTopics.dart';

class NewSession extends StatefulWidget {
  Session session;
  final state = _NewSessionState();

  @override
  _NewSessionState createState() => state;
}

class _NewSessionState extends State<NewSession> {
  final GlobalKey<FormState> _sessionFormKey = GlobalKey<FormState>();

  String _name;
  DateTime _date;
  List<DateTime> _dates = [];

  final _defaultTimeRange = TimeRangeResult(
    TimeOfDay(hour: 14, minute: 50),
    TimeOfDay(hour: 15, minute: 20),
  );

  TimeRangeResult _timeRange;
  String dateStr = 'Must Pick a date';
  String _description;
  String _website = "";
  List<String> _speakers = new List<String>();
  List<String> _topics = new List<String>();

  _buildSession() {
    _dateAndTime();
    widget.session = new Session(
      name: _name,
      speakers: _speakers,
      topics: _topics,
      website: _website,
      description: _description,
      begin: _dates[0],
      end: _dates[1],
    );
  }

  DateTime _dateAndTime() {
    TimeOfDay begin = _timeRange.start;
    TimeOfDay end = _timeRange.end;

    setState(() {
      _dates = [
        new DateTime(
            _date.year, _date.month, _date.day, begin.hour, begin.minute),
        new DateTime(_date.year, _date.month, _date.day, end.hour, end.minute)
      ];
    });

    print(_dates[0].hour);
    print(_dates[1].hour);
  }

  _onDateChanged(picked) {
    setState(() {
      _date = picked;
      dateStr = _date.toString().substring(0, 10);
    });
  }

  @override
  void initState() {
    super.initState();
    _timeRange = _defaultTimeRange;
  }

  Widget _buildName() {
    return TextFormField(
      decoration: new InputDecoration(
        labelText: "Name",
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(10.0),
          borderSide: new BorderSide(),
        ),
      ),
      maxLength: 50,
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

  Widget _buildTopics() {
    return Row(children: <Widget>[
      ButtonTheme(
        key: Key('topicsButtonn'),
        minWidth: MediaQuery.of(context).size.width * 0.84,
        child: RaisedButton(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.black26, width: 2)),
          highlightElevation: 40.0,
          onPressed: () async {
            var receivedTopics = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InsertTopics(topics: _topics)),
            );
            if (receivedTopics != null) _topics = receivedTopics;
          },
          child: Text("INSERT TOPICS",
              style: TextStyle(
                color: Colors.black38,
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Rubik',
              )),
        ),
      ),
    ]
        //Manage Profile Button
        );
  }

  Widget _buildSpeakers() {
    return Row(
      children: [
        ButtonTheme(
          minWidth: MediaQuery.of(context).size.width * 0.84,
          child: MaterialButton(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.black26, width: 2)),
            highlightElevation: 40.0,
            onPressed: () async {
              var receivedSpeakers = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InsertItems(
                          speakers: _speakers,
                        )),
              );
              if (receivedSpeakers != null) _speakers = receivedSpeakers;
            },
            child: Text("INSERT SPEAKERS",
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Rubik',
                )),
          ),
        ),
      ],
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
          child: Text(dateStr,
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
                  final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2222),
                  );
                  if (picked != null && picked != _date) {
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

  Widget _buildDescription() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: new InputDecoration(
        labelText: "Description",
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(10.0),
          borderSide: new BorderSide(),
        ),
      ),
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

  Widget _buildHour() {
    return Row(children: <Widget>[
      Flexible(
          child: TimeRange(
        fromTitle: Text(
          'From',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5BBDB8)),
        ),
        toTitle: Text(
          'To',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5BBDB8)),
        ),
        titlePadding: 20,
        textStyle:
            TextStyle(fontWeight: FontWeight.normal, color: Colors.black87),
        activeTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        borderColor: Colors.grey,
        backgroundColor: Colors.transparent,
        activeBackgroundColor: Colors.grey,
        firstTime: TimeOfDay(hour: 1, minute: 30),
        lastTime: TimeOfDay(hour: 20, minute: 00),
        initialRange: _timeRange,
        timeStep: 10,
        timeBlock: 30,
        onRangeCompleted: (range) => setState(() => _timeRange = range),
      ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(children: <Widget>[
        // HEADER
        Row(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Image.asset('images/pageHeader.png', fit: BoxFit.fill),
          ),
        ]),

        // Title
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
                      "New Session",
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        color: Color(0xFF5BBDB8),
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
            key: _sessionFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                _buildTopics(),
                SizedBox(height: 15),
                _buildSpeakers(),
                SizedBox(height: 15),
                _buildWebsite(),
                SizedBox(height: 15),
                _buildDescription(),
                SizedBox(height: 15),
                _buildDate(),
                SizedBox(height: 15),
                _buildHour(),
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
                    onPressed: onNext,
                  ),
                ),
              ],
            ),
          ),
        ),
      ])),
    );
  }

  //on save forms
  Future<void> onNext() async {
    if (_sessionFormKey.currentState.validate() &&
        _speakers.length != 0 &&
        _topics.length != 0) {
      _sessionFormKey.currentState.save();
      _buildSession();

      SessionQuestion question = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Donate()),
      );
      if (question == null) return null;

      widget.session.addQuestion(question);

      Navigator.pop(context, widget.session);
    }
  }
}
