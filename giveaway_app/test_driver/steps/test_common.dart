import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class ThenRedirectToPage extends Then1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String page) async {
    final pageFinder = find.byValueKey(page);
    await FlutterDriverUtils.tap(world.driver, pageFinder);
  }

  @override
  RegExp get pattern => RegExp(r"I will be redirected to the {string}");
}

class GivenHomePage extends Given1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String page) async {
    final pageFinder = find.byValueKey(page);
    await FlutterDriverUtils.isPresent(world.driver, pageFinder);
  }

  @override
  RegExp get pattern => RegExp(r"I am at the {string}");
}