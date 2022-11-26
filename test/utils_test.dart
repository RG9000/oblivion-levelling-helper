import 'package:flutter_test/flutter_test.dart';
import 'package:oblivion_skill_diary/utils.dart';

void main() {

  test('getModifierForValue returns 1 for 0 skill increases', () async {
    var skillIncreases = 0;
    var actual = getModifierForValue(skillIncreases);
    expect(actual, 1);
  });
  
  test('getModifierForValue returns 2 for 4 skill increases', () async {
    var skillIncreases = 4;
    var actual = getModifierForValue(skillIncreases);
    expect(actual, 2);
  });
  
  test('getModifierForValue returns 3 for 7 skill increases', () async {
    var skillIncreases = 7;
    var actual = getModifierForValue(skillIncreases);
    expect(actual, 3);
  });
  
  test('getModifierForValue returns 4 for 9 skill increases', () async {
    var skillIncreases = 9;
    var actual = getModifierForValue(skillIncreases);
    expect(actual, 4);
  });
  
  test('getModifierForValue returns 5 for 10 skill increases', () async {
    var skillIncreases = 10;
    var actual = getModifierForValue(skillIncreases);
    expect(actual, 5);
  });
  
  test('getModifierForValue returns 5 for 11 skill increases', () async {
    var skillIncreases = 11;
    var actual = getModifierForValue(skillIncreases);
    expect(actual, 5);
  });
}