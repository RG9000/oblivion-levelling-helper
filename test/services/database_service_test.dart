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

  test('Character table created', () async {
    var tableStructure = await db.rawQuery("pragma table_info('Characters');");
    expect(tableStructure[0]["name"], "id");
    expect(tableStructure[0]["type"], "INTEGER");
    expect(tableStructure[1]["name"], "name");
    expect(tableStructure[1]["type"], "TEXT");
  });

  test('Skills table created', () async {
    var tableStructure = await db.rawQuery("pragma table_info('Skills');");
    expect(tableStructure[0]["name"], "id");
    expect(tableStructure[0]["type"], "INTEGER");
    expect(tableStructure[1]["name"], "name");
    expect(tableStructure[1]["type"], "TEXT");
    expect(tableStructure[2]["name"], "governingAttributeId");
    expect(tableStructure[2]["type"], "INTEGER");
  });
  
  test('Attributes table created', () async {
    var tableStructure = await db.rawQuery("pragma table_info('Attributes');");
    expect(tableStructure[0]["name"], "id");
    expect(tableStructure[0]["type"], "INTEGER");
    expect(tableStructure[1]["name"], "name");
    expect(tableStructure[1]["type"], "TEXT");
  });

  test('CharacterAttributes table created', () async {
    var tableStructure = await db.rawQuery("pragma table_info('CharacterAttributes');");
    expect(tableStructure[0]["name"], "id");
    expect(tableStructure[0]["type"], "INTEGER");
    expect(tableStructure[1]["name"], "characterId");
    expect(tableStructure[1]["type"], "INTEGER");
    expect(tableStructure[2]["name"], "attributeId");
    expect(tableStructure[2]["type"], "INTEGER");
    expect(tableStructure[3]["name"], "value");
    expect(tableStructure[3]["type"], "INTEGER");
  });
  
  test('CharacterSkills table created', () async {
    var tableStructure = await db.rawQuery("pragma table_info('CharacterSkills');");
    expect(tableStructure[0]["name"], "id");
    expect(tableStructure[0]["type"], "INTEGER");
    expect(tableStructure[1]["name"], "characterId");
    expect(tableStructure[1]["type"], "INTEGER");
    expect(tableStructure[2]["name"], "skillId");
    expect(tableStructure[2]["type"], "INTEGER");
    expect(tableStructure[3]["name"], "totalLevel");
    expect(tableStructure[3]["type"], "INTEGER");
    expect(tableStructure[4]["name"], "levelsSinceLevelUp");
    expect(tableStructure[4]["type"], "INTEGER");
    expect(tableStructure[5]["name"], "isMajor");
    expect(tableStructure[5]["type"], "INTEGER");
  });
  
  test('Attributes table initialized', () async {
    var tableData = await db.query("Attributes");
    expect(tableData.length, 8);
  });
  
  test('Skills table initialized', () async {
    var tableData = await db.query("Skills");
    expect(tableData.length, 21);
  });
  
  test('Skills table has 3 skills per attribute', () async {
    final List<Map<String, dynamic>> skillData = await db.query("Skills");
    final List<Map<String, dynamic>> attributeData = await db.query("Attributes");

    var skillList = List.generate(skillData.length, (i) {
      return Skill(
        SkillName.values[skillData[i]['id']],
        skillData[i]['name'],
        AttributeName.values[skillData[i]['governingAttributeId']],
      );
    });
    
    var attributeList = List.generate(attributeData.length, (i) {
      return Attribute(
        AttributeName.values[attributeData[i]['id']],
        attributeData[i]['name'],
      );
    });

    for(var attribute in attributeList)
    {
      if (attribute.id != AttributeName.luck)
      {
        var numSkillsForAttribute = skillList.where((element) => element.governingAttributeId == attribute.id).length;
        expect(numSkillsForAttribute, 3);
      }
    }

  });
}