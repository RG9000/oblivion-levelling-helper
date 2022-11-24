import 'package:flutter/material.dart';
import 'package:oblivion_skill_diary/utils.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/attributes.dart';
import '../model/character.dart';
import '../model/detailed_character.dart';
import '../model/skills.dart';

class DatabaseService {
  static late Future<Database> database;

   Future<void> insertSkill(Skill skill) async {
    // Get a reference to the database.
    final db = await database;
    
    await db.insert(
      'skills',
      skill.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Character>> getAllCharacters() async
  {
    final db = await database;
    List<Map<String, dynamic>> characters = await db.query("Characters");
    return characters.map((e) => Character(e["id"], e["name"], e["level"])).toList();
  }

  static Future addCharacter(DetailedCharacter character) async
  {
    final db = await database;
    var characterId = await db.insert("Characters", Character(character.id, character.name, character.level).toMapForInsert());
    for(var skill in character.skills)
    {
      db.insert("CharacterSkills", CharacterSkill(0, characterId, skill.id, skill.totalLevel, skill.levelSinceLevelUp, skill.isMajor).toMapForInsert());
    }
    for(var attribute in character.attributes)
    {
      db.insert("CharacterAttributes", CharacterAttribute(0, characterId, attribute.id, attribute.value).toMapForInsert());
    }
  }

static Future<Database> initDatabase([bool isTest = false])
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
    return database;
  }
}