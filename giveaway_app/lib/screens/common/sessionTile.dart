import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartcon_app/models/sessionNO.dart';
import 'package:url_launcher/url_launcher.dart';

class SessionTile extends StatelessWidget {
  final Session session;
  SessionTile({this.session});

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Row> _listToWidgets(List<String> strList) {
      List<Row> list = [];
      for (int i = 0; i < strList.length; i++) {
        list.add(Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.42 - 16,
              child: Text(strList[i],
                  style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Rubik',
                      color: Color(0xFF585858),
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ));
      }
      return list;
    }

    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: MediaQuery.of(context).size.width * 0.08,
        right: MediaQuery.of(context).size.width * 0.08,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(width: 2.0, color: Colors.black26)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            Container(
              child: Text(
                session.name.toUpperCase(),
                style: Theme.of(context).textTheme.headline5,
              ),
              alignment: Alignment.topLeft,
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.42 - 16,
                      child: Text(
                        'Topics',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    SizedBox(height: 2),
                    Column(
                      children: _listToWidgets(session.topics),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.42 - 16,
                      child: Text(
                        'Speakers',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    Column(
                      children: _listToWidgets(session.speakers),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.84 - 32,
                      child: Text(
                        'Description',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                            width:
                                MediaQuery.of(context).size.width * 0.84 - 32,
                            child: Text(session.description,
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: 'Rubik',
                                    color: Color(0xFF585858),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                      DateFormat.yMMMd().format(session.begin) +
                          ' - ' +
                          DateFormat.Hm().format(session.begin) +
                          ' TO ' +
                          DateFormat.Hm().format(session.end),
                      style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: 'Rubik',
                          color: Color(0xFF585858),
                          fontWeight: FontWeight.w400)),
                ),
                Container(
                    child: RaisedButton(
                  color: Color(0xFF6E96EF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  onPressed: () async {
                    _launchURL(session.website);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "MORE",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ))
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
