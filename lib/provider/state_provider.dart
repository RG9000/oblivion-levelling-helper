import 'package:flutter/widgets.dart';
import 'package:oblivion_skill_diary/services/database_service.dart';

import '../model/character.dart';


class StateProvider extends ChangeNotifier {
  
  DatabaseService dbService;
  late Future isInitialized;

  StateProvider(this.dbService)
  {
    isInitialized = _init();
  }

  Future _init() async
  {
    await dbService.initDatabase();
  }

  Future<List<Character>> getAllCharacters() async
  {
    await isInitialized;
    return await dbService.getAllCharacters();
  }

  // void instantializeCharacter(int characterId)
  // async {
  //   List<Skill> theseSkills = [];
  //   databaseService.getSkillsFromDatabase().then((value) {
  //     theseSkills = value;
  //     debugPrint(skills.length.toString()) ;
  //     if (theseSkills.isEmpty)
  //     {
  //       skills = generateEmptySkillMap(characterId);
  //     }
  //     else
  //     {
  //       skills = List.from(theseSkills);
  //     }
  //     var x = skills.where((element) => element.isMajor,).map((e) => e.levelSinceLevelUp,);
  //     if (x.isNotEmpty) 
  //     {
  //       progressTowardsLevelUp = x.reduce((value, element) => value + element);
  //     }
  //     generateEmptyAttributeMap(); 
  //     notifyListeners(); 
  //   });
  // }

  // void insertSkillIntoDatabase(Skill skill) => 
  //   databaseService.insertSkill(skill);
  
  // void truncateSkills() => 
  //   databaseService.truncateSkills();

  // int getAttributeIncreaseValue(AttributeName attribute)
  // {
  //   var x = skills.where((element) => element.governingAttribute == attribute)
  //     .map((e) => e.levelSinceLevelUp);
  //   if (x.isNotEmpty) {
  //     return x.reduce((value, element) => value + element);
  //   } else {
  //     return 0;
  //   }
  // }

  // incrementSkill(bool levelLocked, SkillName skill){
  //   if (levelLocked) {
  //     var thisSkill = skills.firstWhere((element) => skill == element.id,);
  //     thisSkill.levelSinceLevelUp += 1;
  //     if (thisSkill.isMajor)
  //     {
  //       progressTowardsLevelUp += 1;
  //       if (progressTowardsLevelUp >= 10)
  //       {
  //         levelUp();
  //       }
  //     }
  //   }
  //   skills.firstWhere((element) => skill == element.id,).totalLevel += 1;
  //   notifyListeners();
  // }

  // decrementSkill(SkillName skill)
  // {
  //   var thisSkill = skills.firstWhere((element) => skill == element.id,);
  //   thisSkill.totalLevel -= 1;
  //   notifyListeners();
  // }

  // levelUp()
  // {
  //   progressTowardsLevelUp = 0;
  //   attributes.updateAll((key, value) => 0);
  //   skills = skills.map((element) {element.levelSinceLevelUp = 0; return element;}).toList();
  // }

  // getNumberOfMajorSkills()
  // {
  //   return skills.where((element) => element.isMajor).length;
  // }

  // makeSkillMajor(SkillName skill)
  // {
  //   if (skills.where((element) => element.isMajor).length < 7)
  //   {
  //   skills.firstWhere((element) => element.id == skill).isMajor = true;
  //     notifyListeners();
  //   }
  // }
  // makeSkillMinor(SkillName skill)
  // {
  //   skills.firstWhere((element) => element.id == skill).isMajor = false;
  //   notifyListeners();
  // }
}