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

static Future<Database> initDatabase([bool isTest = false])
  async {
    WidgetsFlutterBinding.ensureInitialized();
      return openDatabase( 
      join(await getDatabasesPath(), isTest ? 'oblivion_skills_database_test.db' : 'oblivion_skills_database.db'),
      onCreate: (db, version) {
        db.execute(
          '''CREATE TABLE Skills(id INTEGER, name TEXT, governingAttributeId INTEGER);
             CREATE TABLE Attributes(id INTEGER, name TEXT);
             CREATE TABLE Characters(id INTEGER, name TEXT, level INTEGER);
             CREATE TABLE CharacterAttributes(id INTEGER, characterId INTEGER, attributeId INTEGER, value INTEGER);
             CREATE TABLE CharacterSkills(id INTEGER, characterId INTEGER, skillId INTEGER, totalLevel INTEGER, levelsSinceLevelUp INTEGER, isMajor INTEGER);
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