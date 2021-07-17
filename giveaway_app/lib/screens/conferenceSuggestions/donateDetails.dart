import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcon_app/models/donation.dart';
import 'package:smartcon_app/screens/conferenceSuggestions/shoppingItem.dart';
import 'package:smartcon_app/services/database.dart';

import '../profile.dart';
import 'conferenceList.dart';

class DonateDetails extends StatefulWidget {
  DonateDetails({Key key}) : super(key: key);

  @override
  _DonateDetails createState() => _DonateDetails();
}

class _DonateDetails extends State<DonateDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final key = GlobalKey<AnimatedListState>();
  final items = [];

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
                                width: MediaQuery.of(context).size.width * 0.84,
                                child: Text(
                                  "Donation Details",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                alignment: Alignment.topLeft,
                              ),
                            ]))
                  ]),

                  Container(
                      child: Column(
                    children: [
                      Expanded(
                        child: AnimatedList(
                          key: key,
                          initialItemCount: items.length,
                          itemBuilder: (context, index, animation) =>
                              buildItem(items[index], index, animation),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: buildInsertButton(),
                      ),
                    ],
                  ))
                ]))));
  }

  Widget buildItem(item, int index, Animation<double> animation) =>
      ShoppingItemWidget(
        item: item,
        animation: animation,
        onClicked: () => removeItem(index),
      );

  Widget buildInsertButton() => RaisedButton(
        child: Text(
          'Insert item',
          style: TextStyle(fontSize: 20),
        ),
        color: Colors.white,
        onPressed: () => insertItem(3, "ola"),
      );

  void insertItem(int index, String item) {
    items.insert(index, item);
    key.currentState.insertItem(index);
  }

  void removeItem(int index) {
    final item = items.removeAt(index);

    /*key.currentState.removeItem(
      index,
    (context, animation) => buildItem(item, index, animation),
    );*/
  }
}
