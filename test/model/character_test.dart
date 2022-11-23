import 'package:flutter_test/flutter_test.dart';
import 'package:oblivion_skill_diary/model/character.dart';
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

  test('Character can be mapped and inserted into database', () async {
    var character = Character(1, "test character", 0);
    var characterMap = character.toMap();
    await db.insert("Characters", characterMap);
  });

  test('Character can be mapped and inserted into database with auto incrementation', () async {
    var character = Character(0, "test character", 0);
    var characterMap = character.toMapForInsert();
    await db.insert("Characters", characterMap);
    await db.insert("Characters", characterMap);
    await db.insert("Characters", characterMap);
  });
}