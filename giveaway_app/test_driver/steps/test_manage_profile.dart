import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class AndProfileFields extends And2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String field1, String field2) async {
    final field1Finder = find.byTooltip(field1);
    final field2Finder = find.byValueKey(field2);

    await FlutterDriverUtils.isPresent(world.driver, field1Finder);
    await FlutterDriverUtils.isPresent(world.driver, field2Finder);
  }

  @override
  RegExp get pattern => RegExp(
      r"I will be presented with the fields {string} and {string}");
}

class AndSaveProfileButton extends And1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String btn1) async {
    final btn1Finder = find.byTooltip(btn1);

    await FlutterDriverUtils.isPresent(world.driver, btn1Finder);
  }

  @override
  RegExp get pattern => RegExp(
      r"I will be able to save my profile by clicking the {string}");
}