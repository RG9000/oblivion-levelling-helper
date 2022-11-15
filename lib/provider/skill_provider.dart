import 'package:flutter/widgets.dart';
import 'package:oblivion_skill_diary/model/skills.dart';

class SkillProvider extends ChangeNotifier {
  Map<SkillName, Skill> skills = {};
  Map<AttributeName, int> attributes = {};
  int progressTowardsLevelUp = 0;

  loadFreshSkillMap()
  {
    skills = {
      SkillName.acrobatics: Skill("Acrobatics", AttributeName.spd, 0, 0, false),
      SkillName.alchemy: Skill("Alchemy", AttributeName.int, 0, 0, false),
      SkillName.alteration: Skill("Acrobatics", AttributeName.wil, 0, 0, false),
      SkillName.armorer: Skill("Armorer", AttributeName.end, 0, 0, false),
      SkillName.athletics: Skill("Athletics", AttributeName.spd, 0, 0, false),
      SkillName.blade: Skill("Blade", AttributeName.str, 0, 0, false),
      SkillName.block: Skill("Block", AttributeName.end, 0, 0, false),
      SkillName.blunt: Skill("Blunt", AttributeName.str, 0, 0, false),
      SkillName.conjuration: Skill("Conjuration", AttributeName.int, 0, 0, false),
      SkillName.destruction: Skill("Destruction", AttributeName.wil, 0, 0, false),
      SkillName.heavyArmor: Skill("Heavy Armor", AttributeName.end, 0, 0, false),
      SkillName.illusion: Skill("Illusion", AttributeName.per, 0, 0, false),
      SkillName.lightArmor: Skill("Light Armor", AttributeName.spd, 0, 0, false),
      SkillName.marksman: Skill("Marksman", AttributeName.spd, 0, 0, false),
      SkillName.mercantile: Skill("Mercantile", AttributeName.per, 0, 0, false),
      SkillName.mysticism: Skill("Mysticism", AttributeName.int, 0, 0, false),
      SkillName.restoration: Skill("Restoration", AttributeName.wil, 0, 0, false),
      SkillName.security: Skill("Security", AttributeName.agi, 0, 0, false),
      SkillName.sneak: Skill("Sneak", AttributeName.agi, 0, 0, false),
      SkillName.speechcraft: Skill("Speechcraft", AttributeName.per, 0, 0, false),
      SkillName.unarmed: Skill("Hand to Hand", AttributeName.str, 0, 0, false)
    };
    
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
  }

  incrementSkill(bool levelLocked, SkillName skill){
    if (levelLocked) {
      var thisSkill = skills[skill];
      thisSkill?.levelSinceLevelUp += 1;
      if (thisSkill != null)
      {
        attributes.update(thisSkill.governingAttribute, (value) => value + 1);
        if (thisSkill.isMajor)
        {
          progressTowardsLevelUp += 1;
          if (progressTowardsLevelUp == 10)
          {
            levelUp();
          }
        }
      }
    }
    skills[skill]?.totalLevel += 1;
    notifyListeners();
  }

  levelUp()
  {
    progressTowardsLevelUp = 0;
    attributes.updateAll((key, value) => 0);
    skills.entries.map((element) => element.value.levelSinceLevelUp = 0);
  }

  getNumberOfMajorSkills()
  {
    return skills.entries.where((element) => element.value.isMajor).length;
  }

  makeSkillMajor(SkillName skill)
  {
    if (skills.entries.where((element) => element.value.isMajor).length < 7)
    {
      skills[skill]?.isMajor = true;
      notifyListeners();
    }
  }
  makeSkillMinor(SkillName skill)
  {
    skills[skill]?.isMajor = false;
    notifyListeners();
  }
}