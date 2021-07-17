import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';
import 'package:smartcon_app/models/sessionNO.dart';
import 'package:smartcon_app/models/user.dart';
import 'package:smartcon_app/screens/sessionSuggestions/sessionSuggestions.dart';
import 'package:smartcon_app/services/database.dart';

class AnswerQuiz extends StatefulWidget {
  const AnswerQuiz({Key key, this.conferenceId, this.conferenceName})
      : super(key: key);

  final String conferenceId;
  final String conferenceName;

  @override
  _AnswerQuizState createState() => _AnswerQuizState();
}

class _AnswerQuizState extends State<AnswerQuiz> {
  int _questionIdx = 0;
  String buttonString = '';
  List<String> _checked = List<String>();
  List<List<String>> finalAnswers = List<List<String>>();

  Future<Widget> _nextQuestion(List<SessionQuestion> quiz) async {
    final user = Provider.of<SmartconUser>(context, listen: false);

    if (quiz.length != 1 && _questionIdx < quiz.length - 1) {
      setState(() {
        _save_checked();
        _questionIdx++;
      });
    } else {
      setState(() {
        _save_checked();
      });

      for (int i = 0; i < quiz.length; i++) {
        if (quiz[i].type == "conceptKnowledge") {
          print('concept knowledge');
          if (finalAnswers[i].length >= quiz[i].required) {
            print('adddddd ');
            print(i);
            await DatabaseService(uid: user.uid)
                .addSessionSuggestion(widget.conferenceId, quiz[i].sessionId);
          }
        } else if (quiz[i].type == "right/wrong") {
          print('right/wrong');
          if (quiz[i].answer == quiz[i].options.indexOf(finalAnswers[i][0])) {
            await DatabaseService(uid: user.uid)
                .addSessionSuggestion(widget.conferenceId, quiz[i].sessionId);
          }
        } else
          print('Error - unknown question type');
      }

      List<String> sessions = await DatabaseService(uid: user.uid)
          .getSuggestedSessions(widget.conferenceId);
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SessionSuggestions(
                  conferenceId: widget.conferenceId,
                  conferenceName: widget.conferenceName,
                  suggestedSessionIds: sessions,
                )),
      );
    }
  }

  _save_checked() {
    finalAnswers.add(_checked);
    print(finalAnswers);
    _checked = [];
  }

  Widget _buildQuestion(SessionQuestion question) {
    return Column(
      children: [
        // Conference Name
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.08,
                  right: MediaQuery.of(context).size.width * 0.08,
                  bottom: 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.84,
                child: Text(question.question,
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),

        // Options
        Row(
          children: [
            Flexible(
                child: CheckboxGroup(
              orientation: GroupedButtonsOrientation.VERTICAL,
              margin: const EdgeInsets.only(left: 12.0),
              onSelected: (List selected) => setState(() {
                if (selected.length > 1 && question.type == 'right/wrong')
                  selected.removeAt(0);
                _checked = selected;
              }),
              labels: question.options,
              checked: _checked,
              itemBuilder: (Checkbox checkbox, Text optionText, int i) {
                return Row(
                  children: <Widget>[
                    checkbox,
                    Container(
                      width: MediaQuery.of(context).size.width * 0.84 - 20,
                      child: optionText,
                    )
                  ],
                );
              },
            )),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SessionQuestion>>(
        stream: DatabaseService().getQuizQuestions(widget.conferenceId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<SessionQuestion> quiz = snapshot.data;
            (quiz.length != 1 && _questionIdx < quiz.length - 1)
                ? buttonString = 'Next'
                : buttonString = 'Save';

            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // HEADER IMAGE
                    Row(children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset('images/pageHeader.png',
                            fit: BoxFit.fill),
                      ),
                    ]),

                    // Page Title Row
                    Row(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.08,
                            right: MediaQuery.of(context).size.width * 0.08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.84,
                              child: Text(
                                widget.conferenceName,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            SizedBox(height: 10),

                            // Answer Quiz Title
                            Container(
                              width: MediaQuery.of(context).size.width * 0.84,
                              child: Text(
                                "ANSWER QUIZ",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                          ],
                        ),
                      ),
                      // Conference Name
                    ]),

                    SizedBox(height: 20),
                    // Question Widget
                    quiz.isNotEmpty
                        ? _buildQuestion(quiz[_questionIdx])
                        : Container(height: 0),

                    // Next Button
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.08,
                              right: MediaQuery.of(context).size.width * 0.08,
                              top: 20),
                          child: RaisedButton(
                            onPressed: () async {
                              _nextQuestion(quiz);
                            },
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                    color: Colors.black26, width: 2)),
                            child: Text(buttonString,
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
                  ],
                ),
              ),
            );
          } else {
            print("Waiting for conference quiz");
            return Container();
          }
        });
  }
}

class OptionTile extends StatelessWidget {
  final String option;
  OptionTile({this.option});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: MediaQuery.of(context).size.width * 0.08,
        right: MediaQuery.of(context).size.width * 0.08,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          child: Text(option,
              style: TextStyle(
                  fontFamily: 'Rubik',
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.w400)),
          alignment: Alignment.topLeft,
        ),
      ]),
    );
  }
}
