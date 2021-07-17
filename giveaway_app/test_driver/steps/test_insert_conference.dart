import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class AndInsertConferenceFields extends And5WithWorld<String, String, String, String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String field1, String field2, String field3,  String field4, String field5) async {
    final field1Finder = find.byValueKey(field1);
    final field2Finder = find.byTooltip(field2);
    final field3Finder = find.byValueKey(field3);
    final field4Finder = find.byTooltip(field4);
    final field5Finder = find.byValueKey(field5);

    await FlutterDriverUtils.isPresent(world.driver, field1Finder);
    await FlutterDriverUtils.isPresent(world.driver, field2Finder);
    await FlutterDriverUtils.isPresent(world.driver, field3Finder);
    await FlutterDriverUtils.isPresent(world.driver, field4Finder);
    await FlutterDriverUtils.isPresent(world.driver, field5Finder);
  }

  @override
  RegExp get pattern => RegExp(
      r"I will be presented with the fields {string}, {string}, {string}, {string} and {string}");
}