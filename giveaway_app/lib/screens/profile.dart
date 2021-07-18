import 'package:chips_choice/chips_choice.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:giveaway_app/models/user.dart';
import 'package:giveaway_app/services/database.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<String>>.value(
      key: Key('manage_profile_page'),
      value: DatabaseService().categories,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
              child: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              children: <Widget>[
                // HEADER IMAGE (100%)
                Row(children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child:
                        Image.asset('images/pageHeader.png', fit: BoxFit.fill),
                  ),
                ]),

                // CONTENT ROW
                Row(
                  children: <Widget>[
                    // MARGINS
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.08,
                        right: MediaQuery.of(context).size.width * 0.08,
                      ),
                      child:
                          // CONTENT
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                            Row(children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Your Profile",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  )),
                            ]),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.84,
                                child: ProfileForm())
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ))),
    );
  }
}

class ProfileForm extends StatefulWidget {
  @override
  ProfileFormState createState() {
    return ProfileFormState();
  }
}

class ProfileFormState extends State<ProfileForm> {
  final _keyProfile = GlobalKey<FormState>();

  // form values
  String _district;
  List<String> _selectedInterests;

  @override
  Widget build(BuildContext context) {
    SmartconUser user = Provider.of<SmartconUser>(context);
    List<String> _interests = Provider.of<List<String>>(context) ?? [];

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Form(
                key: _keyProfile,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'DISTRICT',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Tooltip(
                        message: 'profile_district',
                        child: DropDownFormField(
                          titleText: 'District',
                          hintText: 'Choose a district',
                          value: _district ?? userData.district,
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
                            if (value == null)
                              return 'Please choose a district';
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
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'INTERESTS',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.84,
                      child: ChipsChoice<String>.multiple(
                        value: _selectedInterests ?? userData.interests,
                        onChanged: (val) =>
                            setState(() => _selectedInterests = val),
                        choiceItems: C2Choice.listFrom<String, String>(
                          source: _interests,
                          value: (i, v) => v,
                          label: (i, v) => v,
                        ),
                        choiceStyle: C2ChoiceStyle(
                            showCheckmark: false,
                            labelStyle: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Rubik',
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        choiceActiveStyle: C2ChoiceStyle(
                            showCheckmark: false,
                            borderColor: Color(0xFF637DEB),
                            labelStyle: TextStyle(
                              color: Color(0xFF637DEB),
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Rubik',
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        wrapped: true,
                      ),
                    ),

                    // SAVE BUTTON
                    Container(
                      padding: EdgeInsets.all(8),
                      child: RaisedButton(
                          key: Key('save_profile_btn'),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side:
                                  BorderSide(color: Colors.black26, width: 2)),
                          child: Text('SAVE',
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Rubik',
                              )),
                          onPressed: () async {
                            if (_keyProfile.currentState.validate()) {
                              _keyProfile.currentState.save();
                              await DatabaseService(uid: user.uid)
                                  .updateProfile(
                                _district ?? userData.district,
                                _selectedInterests ?? userData.interests,
                              );

                              Navigator.of(context).pop();
                            }
                          }),
                    ),
                  ],
                ));
          } else {
            print('waiting for profile');
            return Container();
          }
        });
  }
}

class MultiSelectChip extends StatefulWidget {
  final List<String> interests;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip(this.interests, {this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<String> selectedChoices = List();

  _buildChoiceList() {
    List<Widget> choices = List();

    widget.interests.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      key: Key('profile_interests'),
      children: _buildChoiceList(),
    );
  }
}
