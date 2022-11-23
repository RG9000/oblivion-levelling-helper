import 'package:flutter_test/flutter_test.dart';
import 'package:oblivion_skill_diary/model/attributes.dart';
import 'package:oblivion_skill_diary/services/database_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  String testdbpath = "oblivion_skills_database_test.db";
  late Database db;
  setUpAll(() async {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory for unit testing calls for SQFlite
    databaseFactory = databaseFactoryFfi;
    // delete the test database
    databaseFactory.deleteDatabase(testdbpath);
    // recreate the test database
    db = await DatabaseService.initDatabase(true);
  });
  test('Attribute can be mapped and inserted into database', () async {
    var attribute = Attribute(AttributeName.agi, "test");
    var attributeMap = attribute.toMap();
    await db.insert("Attributes", attributeMap);
  });

  test('CharacterAttribute can be mapped and inserted into database manually', () async {
    var characterAttribute = CharacterAttribute(1, 1, AttributeName.agi, 1);
    var characterAttributeMap = characterAttribute.toMap();
    await db.insert("CharacterAttributes", characterAttributeMap);
  });

  test('CharacterAttribute can be mapped and inserted into database with autoincrementation', () async {
    var characterAttribute = CharacterAttribute(0, 1, AttributeName.agi, 1);
    var characterAttributeMap = characterAttribute.toMapForInsert();
    await db.insert("CharacterAttributes", characterAttributeMap);
    await db.insert("CharacterAttributes", characterAttributeMap);
    await db.insert("CharacterAttributes", characterAttributeMap);
  });
}