import 'package:flutter_test/flutter_test.dart';
import 'package:oblivion_skill_diary/model/attributes.dart';
import 'package:oblivion_skill_diary/model/skills.dart';
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

  test('Skill can be mapped and inserted into database', () async {
    var skill = Skill(SkillName.acrobatics, "test", AttributeName.agi);
    var skillMap = skill.toMap();
    await db.insert("Skills", skillMap);
  });

  test('CharacterSkill can be mapped and inserted into database', () async {
    var characterSkill = CharacterSkill(1, 1, SkillName.acrobatics, 1, 1, false);
    var characterSkillMap = characterSkill.toMap();
    await db.insert("CharacterSkills", characterSkillMap);
  });
  
  test('CharacterSkill can be mapped and inserted into database with auto incrementation', () async {
    var characterSkill = CharacterSkill(0, 1, SkillName.acrobatics, 1, 1, false);
    var characterSkillMap = characterSkill.toMapForInsert();
    await db.insert("CharacterSkills", characterSkillMap);
    await db.insert("CharacterSkills", characterSkillMap);
    await db.insert("CharacterSkills", characterSkillMap);
  });
}