import 'package:flutter/widgets.dart';
import 'package:oblivion_skill_diary/model/skills.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SkillProvider extends ChangeNotifier {
  
  List <Skill> skills = [];
  Map<AttributeName, int> attributes = {};
  int progressTowardsLevelUp = 0;
  late Future<Database> database;

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

  void loadFreshSkillMap()
  async {
    WidgetsFlutterBinding.ensureInitialized();
    database = openDatabase( 
      join(await getDatabasesPath(), 'oblivion_skills_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE skills(id INTEGER PRIMARY KEY, name TEXT, governingAttribute INTEGER, totalLevel INTEGER, levelSinceLevelUp INTEGER, isMajor INTEGER)',
        );
      },
      version: 1,
    );

    List<Skill> theseSkills = [];
    getSkillsFromDatabase().then((value) {
      theseSkills = value;
      debugPrint(skills.length.toString()) ;
      if (theseSkills.isEmpty)
      {
        skills = [ 
          Skill(SkillName.acrobatics, "Acrobatics", AttributeName.spd, 0, 0, false),
          Skill(SkillName.alchemy, "Alchemy", AttributeName.int, 0, 0, false),
          Skill(SkillName.alteration, "Alteration", AttributeName.wil, 0, 0, false),
          Skill(SkillName.armorer, "Armorer", AttributeName.end, 0, 0, false),
          Skill(SkillName.athletics, "Athletics", AttributeName.spd, 0, 0, false),
          Skill(SkillName.blade, "Blade", AttributeName.str, 0, 0, false),
          Skill(SkillName.block, "Block", AttributeName.end, 0, 0, false),
          Skill(SkillName.blunt, "Blunt", AttributeName.str, 0, 0, false),
          Skill(SkillName.conjuration, "Conjuration", AttributeName.int, 0, 0, false),
          Skill(SkillName.destruction, "Destruction", AttributeName.wil, 0, 0, false),
          Skill(SkillName.heavyArmor, "Heavy Armor", AttributeName.end, 0, 0, false),
          Skill(SkillName.illusion, "Illusion", AttributeName.per, 0, 0, false),
          Skill(SkillName.lightArmor, "Light Armor", AttributeName.spd, 0, 0, false),
          Skill(SkillName.marksman, "Marksman", AttributeName.spd, 0, 0, false),
          Skill(SkillName.mercantile, "Mercantile", AttributeName.per, 0, 0, false),
          Skill(SkillName.mysticism, "Mysticism", AttributeName.int, 0, 0, false),
          Skill(SkillName.restoration, "Restoration", AttributeName.wil, 0, 0, false),
          Skill(SkillName.security, "Security", AttributeName.agi, 0, 0, false),
          Skill(SkillName.sneak, "Sneak", AttributeName.agi, 0, 0, false),
          Skill(SkillName.speechcraft, "Speechcraft", AttributeName.per, 0, 0, false),
          Skill(SkillName.unarmed, "Hand to Hand", AttributeName.str, 0, 0, false)
        ];
      }
      else{
        skills = List.from(theseSkills);
      }
      var x = skills.where((element) => element.isMajor,).map((e) => e.levelSinceLevelUp,);
      if (x.isNotEmpty) 
      {
        progressTowardsLevelUp = x.reduce((value, element) => value + element);
        debugPrint("level up val");
        debugPrint(progressTowardsLevelUp.toString());
      }
      notifyListeners(); 
    });
    
    attributes = {
      AttributeName.agi: 0,
      AttributeName.end: 0,
      AttributeName.int: 0,
      AttributeName.luck: 0,
      AttributeName.per: 0,
      AttributeName.spd: 0,
      AttributeName.str: 0,
      AttributeName.wil: 0,
    };


    notifyListeners();
  }

  int getAttributeIncreaseValue(AttributeName attribute)
  {
    var x = skills.where((element) => element.governingAttribute == attribute)
      .map((e) => e.levelSinceLevelUp);
    if (x.isNotEmpty)
      return x.reduce((value, element) => value + element);
    else
      return 0;
  }

  incrementSkill(bool levelLocked, SkillName skill){
    if (levelLocked) {
      var thisSkill = skills.firstWhere((element) => skill == element.id,);
      thisSkill.levelSinceLevelUp += 1;
      if (thisSkill != null)
      {
        if (thisSkill.isMajor)
        {
          progressTowardsLevelUp += 1;
          if (progressTowardsLevelUp >= 10)
          {
            levelUp();
          }
        }
      }
    }
    skills.firstWhere((element) => skill == element.id,).totalLevel += 1;
    notifyListeners();
  }

  decrementSkill(SkillName skill)
  {
    var thisSkill = skills.firstWhere((element) => skill == element.id,);
    thisSkill.totalLevel -= 1;
    notifyListeners();
  }

  levelUp()
  {
    progressTowardsLevelUp = 0;
    attributes.updateAll((key, value) => 0);
    skills = skills.map((element) {element.levelSinceLevelUp = 0; return element;}).toList();
  }

  getNumberOfMajorSkills()
  {
    return skills.where((element) => element.isMajor).length;
  }

  makeSkillMajor(SkillName skill)
  {
    if (skills.where((element) => element.isMajor).length < 7)
    {
    skills.firstWhere((element) => element.id == skill).isMajor = true;
      notifyListeners();
    }
  }
  makeSkillMinor(SkillName skill)
  {
    skills.firstWhere((element) => element.id == skill).isMajor = false;
    notifyListeners();
  }
}