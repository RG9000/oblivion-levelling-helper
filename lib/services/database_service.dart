import 'package:flutter/material.dart';
import 'package:oblivion_skill_diary/utils.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

  // Future<List<Skill>> getSkillsFromDatabase() async {
  // // Get a reference to the database.
  //   final db = await database;

  //   // Query the table for all The Dogs.
  //   final List<Map<String, dynamic>> maps = await db.query('skills');

  //   // Convert the List<Map<String, dynamic> into a List<Dog>.
  //   return List.generate(maps.length, (i) {
  //     return Skill(
  //       maps[i]['characterId'],
  //       SkillName.values[maps[i]['id']],
  //       maps[i]['name'],
  //       AttributeName.values[maps[i]['governingAttribute']],
  //       maps[i]['totalLevel'],
  //       maps[i]['levelSinceLevelUp'],
  //       maps[i]['isMajor'] as int == 0 ? false : true,
  //     );
  //   });
  // }

  // Future<void> truncateSkills() async {
  //   final db = await database;
  //   await db.delete("skills");
  // }

  static Future<Database> initDatabase()
  async {
    WidgetsFlutterBinding.ensureInitialized();
      return openDatabase( 
      join(await getDatabasesPath(), 'oblivion_skills_database.db'),
      onCreate: (db, version) {
        db.execute(
          '''CREATE TABLE Skills(id INTEGER, name TEXT, governingAttributeId INTEGER);
             CREATE TABLE Attributes(id INTEGER, name TEXT);
             CREATE TABLE Character(id INTEGER, name TEXT, level INTEGER);
             CREATE TABLE CharacterAttributes(id INTEGER, characterId INTEGER, attributeId INTEGER, value INTEGER);
             CREATE TABLE CharacterSkill(id INTEGER, characterId INTEGER, skillId INTEGER, totalLevel INTEGER, levelsSinceLevelUp INTEGER, isMajor INTEGER);
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