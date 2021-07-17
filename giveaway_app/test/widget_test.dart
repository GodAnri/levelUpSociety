import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:smartcon_app/main.dart';
import 'package:smartcon_app/models/conferenceNO.dart';
import 'package:smartcon_app/models/user.dart';
import 'package:smartcon_app/screens/homePage.dart';
import 'package:smartcon_app/screens/insertConference/conferenceSessions.dart';
import 'package:smartcon_app/screens/insertConference/newSession.dart';

class MockConference extends Mock implements Conference {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  group('HomePage', () {
    testWidgets('Pressing InsertConference', (WidgetTester tester) async {
      await tester.pumpWidget(HomePage());
      await tester.tap(find.byKey(Key('insert_conference_btn')));
      await tester.pump();
      expect(find.text('Insert'), findsOneWidget);
    });
  });
/*  group('Conference Sessions', () {
    /*setUp(
      var model = MockConference();
      await model.initialise();
    );*/
    testWidgets('Pressing +', (WidgetTester tester) async {
      await tester.pumpWidget(conferenceSessions(/*conference:, sessions: */));
      await tester.tap(find.byKey(Key('btn1')));
      await tester.pump();
      expect(find.text('New Session'), findsOneWidget);
    });
    testWidgets('Pressing Okay button', (WidgetTester tester) async {
      await tester.pumpWidget(conferenceSessions());
      await tester.tap(find.byKey(Key('btn2')));
      await tester.pump();
      expect(find.text('Smart Con'), findsOneWidget);
    });
  });
  group('New Session', () {
    testWidgets('Pressing Insert Topics', (WidgetTester tester) async {
      await tester.pumpWidget(NewSession());
      await tester.tap(find.byKey(Key('topicsButtonn')));
      await tester.pump();
      expect(find.text('Insert Topics'), findsOneWidget);
    });
  });*/
}
