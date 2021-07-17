import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:smartcon_app/main.dart';
import 'package:smartcon_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:smartcon_app/screens/homePage.dart';

void main() async {
  // This line enables the extension
  enableFlutterDriverExtension();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Call the `main()` function of your app or call `runApp` with any widget you
  // are interested in testing.
  runApp(MaterialApp(home: MyAppMock()));
}

class MyAppMock extends MyApp {
  @override
  Widget build(BuildContext context) {
    return Provider<SmartconUser>.value(
      value: SmartconUser(uid: 'yScVhq7iIzRLKNMFhSJnywnRkua2'),
      child: MaterialApp(
        title: 'SmartCon',
        theme: ThemeData(
          // This is the theme of your application.

          primarySwatch: Colors.teal,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,

          textTheme: TextTheme(
            // App Title - white
            headline1: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 45.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Page Title - purple
            headline2: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Color(0xFF637DEB),
                fontSize: 32.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Page Subtitle - black
            headline3: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Color(0xFF4A4444),
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Form Buttons
            headline4: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Buttons Text - purple
            headline5: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Color(0xFF637DEB),
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Home Buttons Text - white
            headline6: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
