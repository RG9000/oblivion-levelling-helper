import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/attributes.dart';
import '../model/skills.dart';

class DatabaseService {
  
  static Future<Database> database = initDatabase();

   Future<void> insertSkill(Skill skill) async {
    // Get a reference to the database.
    final db = await database;
    
    await db.insert(
      'skills',
      skill.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Skill>> getSkillsFromDatabase() async {
  // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('skills');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Skill(
        maps[i]['characterId'],
        SkillName.values[maps[i]['id']],
        maps[i]['name'],
        AttributeName.values[maps[i]['governingAttribute']],
        maps[i]['totalLevel'],
        maps[i]['levelSinceLevelUp'],
        maps[i]['isMajor'] as int == 0 ? false : true,
      );
    });
  }

  Future<void> truncateSkills() async {
    final db = await database;
    await db.delete("skills");
  }

  static Future<Database> initDatabase()
  async {
    WidgetsFlutterBinding.ensureInitialized();
      return openDatabase( 
      join(await getDatabasesPath(), 'oblivion_skills_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE skills(companyId INTEGER, id INTEGER, name TEXT, governingAttribute INTEGER, totalLevel INTEGER, levelSinceLevelUp INTEGER, isMajor INTEGER)',
        );
      },
      version: 2,
    );
  }
}