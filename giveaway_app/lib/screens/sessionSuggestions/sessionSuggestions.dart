import 'package:flutter/material.dart';
import 'package:smartcon_app/models/sessionNO.dart';
import 'package:smartcon_app/screens/common/sessionTile.dart';
import 'package:smartcon_app/services/database.dart';

class SessionSuggestions extends StatefulWidget {
  const SessionSuggestions(
      {Key key,
      this.conferenceId,
      this.conferenceName,
      this.suggestedSessionIds})
      : super(key: key);

  final String conferenceId;
  final String conferenceName;
  final List<String> suggestedSessionIds;

  @override
  _SessionSuggestionsState createState() => _SessionSuggestionsState();
}

class _SessionSuggestionsState extends State<SessionSuggestions> {
  bool _all = false;

  List<Session> _getSuggestedSessions(List<Session> sessions) {
    if (_all) return sessions;
    List<Session> suggested = List<Session>();
    for (int i = 0; i < sessions.length; i++) {
      if (widget.suggestedSessionIds.contains(sessions[i].sessionId))
        suggested.add(sessions[i]);
    }
    return suggested;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DatabaseService().getConferenceSessions(widget.conferenceId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Session> sessions = _getSuggestedSessions(snapshot.data);

            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Header - Image + Button
                    Row(children: <Widget>[
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset('images/pageHeader.png',
                                fit: BoxFit.fill),
                          ),

                          // Toogle See All Sessions / See Suggested Sessions
                          Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.08,
                                top: MediaQuery.of(context).size.width * 0.08,
                              ),
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    _all = !_all;
                                  });
                                },
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color: Color(0xFF6E96EF), width: 2)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    !_all
                                        ? 'SEE ALL SESSIONS'
                                        : 'SEE SUGGESTED SESSIONS',
                                    style: TextStyle(
                                      color: Color(0xFF6E96EF),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Rubik',
                                    ),
                                  ),
                                ),
                                elevation: 5,
                              )),
                        ],
                      ),
                    ]),

                    // Content Row
                    Row(children: <Widget>[
                      // MARGINS
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.08,
                          right: MediaQuery.of(context).size.width * 0.08,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.84,
                              child: Text(
                                widget.conferenceName,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                              child: Text(
                                "SUGGESTED SESSIONS",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                          ],
                        ),
                      ),
                    ]),

                    Row(
                      children: [
                        SessionList(sessions: sessions),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            print('waiting for conference sesssions');
            return Container();
          }
        });
  }
}

class SessionList extends StatefulWidget {
  const SessionList({Key key, this.sessions}) : super(key: key);

  final List<Session> sessions;

  @override
  _SessionListState createState() => _SessionListState();
}

class _SessionListState extends State<SessionList> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.sessions.length,
        itemBuilder: (context, index) {
          return SessionTile(session: widget.sessions[index]);
        },
      ),
    );
  }
}
