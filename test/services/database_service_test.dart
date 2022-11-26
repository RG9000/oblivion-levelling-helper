import 'package:flutter_test/flutter_test.dart';
import 'package:oblivion_skill_diary/model/attributes.dart';
import 'package:oblivion_skill_diary/model/character.dart';
import 'package:oblivion_skill_diary/model/detailed_character.dart';
import 'package:oblivion_skill_diary/model/skills.dart';
import 'package:oblivion_skill_diary/services/database_service.dart';
import 'package:oblivion_skill_diary/utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() {
  String testdbpath = "oblivion_skills_database_test.db";
  late Database db;
  DatabaseService dbService = DatabaseService();

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    await databaseFactory.deleteDatabase(testdbpath);
    await dbService.initDatabase(true);
    db = await dbService.database;
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

test('Can add and read a character in database', () async {
    databaseFactory.deleteDatabase(testdbpath); 
    var character1Skills = [
      CharacterSkill(1, 1, SkillName.acrobatics, 1,2, true),
      CharacterSkill(2, 1, SkillName.alchemy, 3,4, false),
      CharacterSkill(3, 1, SkillName.armorer, 5,6, true)
    ];

    var character1Attributes = [
      CharacterAttribute(1,1,AttributeName.spd, 1),
      CharacterAttribute(2,1,AttributeName.int, 2),
      CharacterAttribute(3,1,AttributeName.end, 3),
    ];
    await dbService.initDatabase(true) ;
    var character1 = DetailedCharacter(0, "test1", 1, generateEmptySkillMap(), generateEmptyAttributeMap(), character1Skills, character1Attributes);
    await dbService.addCharacter(character1);
    
    var actual = await dbService.getAllCharacters();

    expect(actual.length, 1);
    expect(actual[0].name, "test1");
    expect(actual[0].level, 1);
  });

test('Can add and read multiple characters in database', () async {
    databaseFactory.deleteDatabase(testdbpath); 
    var character1Skills = [
      CharacterSkill(1, 1, SkillName.acrobatics, 1,2, true),
      CharacterSkill(2, 1, SkillName.alchemy, 3,4, false),
      CharacterSkill(3, 1, SkillName.armorer, 5,6, true)
    ];

    var character1Attributes = [
      CharacterAttribute(1,1,AttributeName.spd, 1),
      CharacterAttribute(2,1,AttributeName.int, 2),
      CharacterAttribute(3,1,AttributeName.end, 3),
    ];

    var character2Skills = [
      CharacterSkill(1, 2, SkillName.acrobatics, 1,2, true),
      CharacterSkill(2, 2, SkillName.alchemy, 3,4, false),
      CharacterSkill(3, 2, SkillName.armorer, 5,6, true)
    ];

    var character2Attributes = [
      CharacterAttribute(1,2,AttributeName.spd, 1),
      CharacterAttribute(2,2,AttributeName.int, 2),
      CharacterAttribute(3,2,AttributeName.end, 3),
    ];
    await dbService.initDatabase(true) ;
    var character1 = DetailedCharacter(0, "test1", 1, generateEmptySkillMap(), generateEmptyAttributeMap(), character1Skills, character1Attributes);
    var character2 = DetailedCharacter(0, "test1", 1, generateEmptySkillMap(), generateEmptyAttributeMap(), character2Skills, character2Attributes);

    await dbService.addCharacter(character1);
    await dbService.addCharacter(character2);
    
    var actual = await dbService.getAllCharacters();

    expect(actual.length, 2);
    expect(actual[0].name, "test1");
    expect(actual[0].level, 1);
  });

  test('Can add and read detailed characters in database', () async {
    databaseFactory.deleteDatabase(testdbpath); 
    var character1Skills = [
      CharacterSkill(1, 1, SkillName.acrobatics, 1,2, true),
      CharacterSkill(2, 1, SkillName.alchemy, 3,4, false),
      CharacterSkill(3, 1, SkillName.armorer, 5,6, true)
    ];

    var character1Attributes = [
      CharacterAttribute(1,1,AttributeName.spd, 1),
      CharacterAttribute(2,1,AttributeName.int, 2),
      CharacterAttribute(3,1,AttributeName.end, 3),
    ];
    
    await dbService.initDatabase(true) ;
    var character1 = DetailedCharacter(0, "test1", 1, generateEmptySkillMap(), generateEmptyAttributeMap(), character1Skills, character1Attributes);

    await dbService.addCharacter(character1);
    var actual = await dbService.getCharacterById(1);
    

    expect(actual.id, 1);
    expect(actual.name, "test1");
    expect(actual.level, 1);

    expect(actual.attributes.length, 3);
    expect(actual.skills.length, 3);

    expect(actual.skills.first.name, "Acrobatics");
  });

  test('Can update detailed characters in database', () async {
    databaseFactory.deleteDatabase(testdbpath); 
    var character1Skills = [
      CharacterSkill(1, 1, SkillName.acrobatics, 1,2, true),
      CharacterSkill(2, 1, SkillName.alchemy, 3,4, false),
      CharacterSkill(3, 1, SkillName.armorer, 5,6, true)
    ];

    var character1Attributes = [
      CharacterAttribute(1,1,AttributeName.spd, 1),
      CharacterAttribute(2,1,AttributeName.int, 2),
      CharacterAttribute(3,1,AttributeName.end, 3),
    ];
    
    await dbService.initDatabase(true) ;
    var character1 = DetailedCharacter(0, "test1", 1, generateEmptySkillMap(), generateEmptyAttributeMap(), character1Skills, character1Attributes);
    await dbService.addCharacter(character1);

    character1.id = 1;
    character1.name = "test2";
    character1.level = 2;
    character1.skills[0].isMajor = false;
    character1.skills[0].levelSinceLevelUp = 5;
    character1.skills[0].totalLevel = 10;
    character1.attributes[0].value = 5;

    await dbService.updateCharacter(character1);

    var actual = await dbService.getCharacterById(1);
    

    expect(actual.id, 1);
    expect(actual.name, "test2");
    expect(actual.level, 2);

    expect(actual.attributes.length, 3);
    expect(actual.skills.length, 3);

    expect(actual.skills.first.name, "Acrobatics");
    expect(actual.skills.first.isMajor, false);
    expect(actual.skills.first.levelSinceLevelUp, 5);
    expect(actual.skills.first.totalLevel, 10);
    expect(actual.attributes.first.value, 5);
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
    var characterAttributeMap = characterAttribute.toMap();
    await db.insert("CharacterAttributes", characterAttributeMap);
    await db.insert("CharacterAttributes", characterAttributeMap);
    await db.insert("CharacterAttributes", characterAttributeMap);
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
    var characterSkillMap = characterSkill.toMap();
    await db.insert("CharacterSkills", characterSkillMap);
    await db.insert("CharacterSkills", characterSkillMap);
    await db.insert("CharacterSkills", characterSkillMap);
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