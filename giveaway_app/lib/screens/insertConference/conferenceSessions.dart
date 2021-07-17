import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcon_app/models/conferenceNO.dart';
import 'package:smartcon_app/models/sessionNO.dart';
import 'package:smartcon_app/screens/common/sessionTile.dart';
import 'package:smartcon_app/screens/insertConference/newSession.dart';
import 'package:smartcon_app/services/database.dart';

import '../homePage.dart';

class conferenceSessions extends StatefulWidget {
  Conference conference;
  List<Session> sessions = List<Session>();

  conferenceSessions({Key key, this.conference}) : super(key: key);

  @override
  _conferenceSessions createState() => _conferenceSessions();
}

class _conferenceSessions extends State<conferenceSessions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
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
                      child: Text(
                        "Conference Sessions",
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          color: Color(0xFF5BBDB8),
                          fontSize: 32.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                  ]),
            )
          ]),
          SizedBox(height: 20),
          Row(
              children: widget.sessions.length <= 0
                  ? [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.08,
                            right: MediaQuery.of(context).size.width * 0.08),
                        child: Text("Add Session by tapping + button",
                            style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: 'Rubik',
                                color: Colors.black38,
                                fontWeight: FontWeight.w400)),
                      )
                    ]
                  : [
                      Flexible(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          addAutomaticKeepAlives: true,
                          itemCount: widget.sessions.length,
                          itemBuilder: (context, index) {
                            return SessionTile(session: widget.sessions[index]);
                          },
                        ),
                      ),
                    ])
        ]),
      ),
      floatingActionButton: Stack(children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
          child: Align(
            alignment: Alignment.bottomLeft,
            key: Key('btn1'),
            child: FloatingActionButton(
              heroTag: "btn1",
              child: Icon(Icons.add),
              backgroundColor: Color(0xFF5BBDB8),
              onPressed: onAddForm,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            key: Key('btn2'),
            heroTag: "btn2",
            child: Icon(Icons.done),
            backgroundColor: Color(0xFF5BBDB8),
            onPressed: onSave,
            foregroundColor: Colors.white,
          ),
        ),
      ]),
    );
  }

  //on add form
  void onAddForm() async {
    Session session = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewSession()),
    );
    if (session == null) return;

    setState(() {
      widget.sessions.add(session);
    });
  }

  //on save forms
  void onSave() async {
    if (widget.sessions.length != 0) {
      String conferenceId =
          await DatabaseService().addConference(widget.conference);

      for (var session in widget.sessions) {
        await DatabaseService().addSession(conferenceId, session);
      }
    }

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()),
        (Route<dynamic> route) => route is HomePage);
  }
}
