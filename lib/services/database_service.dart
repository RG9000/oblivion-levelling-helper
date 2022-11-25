import 'package:flutter/material.dart';
import 'package:oblivion_skill_diary/utils.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/attributes.dart';
import '../model/character.dart';
import '../model/detailed_character.dart';
import '../model/skills.dart';

class DatabaseService {
  late Future<Database> database;

  Future<List<Character>> getAllCharacters() async
  {
    final db = await database;
    List<Map<String, dynamic>> characters = await db.query("Characters");
    return characters.map((e) => Character(e["id"], e["name"], e["level"])).toList();
  }

  Future addCharacter(DetailedCharacter character) async
  {
    final db = await database;
    var characterId = await db.insert("Characters", Character(character.id, character.name, character.level).toMapForInsert());
    for(var skill in character.skills)
    {
      db.insert("CharacterSkills", CharacterSkill(0, characterId, skill.id, skill.totalLevel, skill.levelSinceLevelUp, skill.isMajor).toMap());
    }
    for(var attribute in character.attributes)
    {
      db.insert("CharacterAttributes", CharacterAttribute(0, characterId, attribute.id, attribute.value).toMap());
    }
  }

  Future updateCharacter(DetailedCharacter character) async
  {
    final db = await database;
    var characterId = await db.update("Characters", Character(character.id, character.name, character.level).toMap());
    for(var skill in character.skills)
    {
      db.update("CharacterSkills", CharacterSkill(0, characterId, skill.id, skill.totalLevel, skill.levelSinceLevelUp, skill.isMajor).toMap(), where: "characterId = ${character.id} and skillId = ${skill.id.index}");
    }
    for(var attribute in character.attributes)
    {
      db.update("CharacterAttributes", CharacterAttribute(0, characterId, attribute.id, attribute.value).toMap(), where: "characterId = ${character.id} and attributeId = ${attribute.id.index}");
    }
  }

  Future<DetailedCharacter> getCharacterById(int id) async
  {
    final db = await database;

    // get the character itself
    var characterQ = await db.query("Characters", where: "id = $id", limit: 1);
    Map<String, dynamic> characterMap = characterQ.first;
    var character = Character(characterMap["id"], characterMap["name"], characterMap["level"]);

    // get its skills
    List<Map<String,dynamic>> characterSkillMap = await db.query("CharacterSkills", where: "characterId = $id");
    var characterSkills = characterSkillMap.map((e) => CharacterSkill(e["id"], e["characterId"], SkillName.values[e["skillId"]], e["totalLevel"], e["levelsSinceLevelUp"], e["isMajor"] == 0 ? false : true)); 

    // get its attributes 
    List<Map<String,dynamic>> characterAttributeMap = await db.query("CharacterAttributes", where: "characterId = $id");
    var characterAttributes = characterAttributeMap.map((e) => CharacterAttribute(e["id"], e["characterId"], AttributeName.values[e["attributeId"]], e["value"]));

    var skills = generateEmptySkillMap();
    var attributes = generateEmptyAttributeMap();

    return DetailedCharacter(character.id, character.name, character.level, skills, attributes, characterSkills.toList(), characterAttributes.toList());
  }

  initDatabase([bool isTest = false])
  async {
    WidgetsFlutterBinding.ensureInitialized();
      database = openDatabase( 
      join(await getDatabasesPath(), isTest ? 'oblivion_skills_database_test.db' : 'oblivion_skills_database.db'),
      onCreate: (db, version) {
        db.execute(
          '''CREATE TABLE Skills(id INTEGER, name TEXT, governingAttributeId INTEGER);
            CREATE TABLE Attributes(id INTEGER, name TEXT);
            CREATE TABLE Characters(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, level INTEGER);
            CREATE TABLE CharacterAttributes(id INTEGER PRIMARY KEY AUTOINCREMENT, characterId INTEGER, attributeId INTEGER, value INTEGER);
            CREATE TABLE CharacterSkills(id INTEGER PRIMARY KEY AUTOINCREMENT, characterId INTEGER, skillId INTEGER, totalLevel INTEGER, levelsSinceLevelUp INTEGER, isMajor INTEGER);
            ''',
        );
        for (var attribute in generateEmptyAttributeMap())
        {
          db.insert('Attributes', attribute.toMap());
        }
        for(var skill in generateEmptySkillMap()) 
        {
          db.insert('Skills', skill.toMap());
        }
      },
      version: 1,
    );
  }
}
