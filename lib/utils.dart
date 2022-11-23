import 'model/attributes.dart';
import 'model/skills.dart';

int getModifierForValue(int val) {
  if (val == 0) {
    return 1;
  } else if (val <= 4) {
    return 2;
  } else if (val <= 7) {
    return 3;
  } else if (val <= 9) {
    return 4;
  } else {
    return 5;
  }
}

List<Attribute> generateEmptyAttributeMap() =>
  [ 
    Attribute(AttributeName.agi, "Agility"),
    Attribute(AttributeName.end, "Endurance"),
    Attribute(AttributeName.int, "Intelligence"),
    Attribute(AttributeName.luck, "Luck"),
    Attribute(AttributeName.per, "Personality"),
    Attribute(AttributeName.spd, "Speed"),
    Attribute(AttributeName.str, "Strength"),
    Attribute(AttributeName.wil, "Willpower")
  ];

List<Skill> generateEmptySkillMap() =>
  [ 
    Skill(SkillName.acrobatics, "Acrobatics", AttributeName.spd),
    Skill(SkillName.alchemy, "Alchemy", AttributeName.int),
    Skill(SkillName.alteration, "Alteration", AttributeName.wil),
    Skill(SkillName.armorer, "Armorer", AttributeName.end),
    Skill(SkillName.athletics, "Athletics", AttributeName.spd),
    Skill(SkillName.blade, "Blade", AttributeName.str),
    Skill(SkillName.block, "Block", AttributeName.end),
    Skill(SkillName.blunt, "Blunt", AttributeName.str),
    Skill(SkillName.conjuration, "Conjuration", AttributeName.int),
    Skill(SkillName.destruction, "Destruction", AttributeName.wil),
    Skill(SkillName.heavyArmor, "Heavy Armor", AttributeName.end),
    Skill(SkillName.illusion, "Illusion", AttributeName.per),
    Skill(SkillName.lightArmor, "Light Armor", AttributeName.spd),
    Skill(SkillName.marksman, "Marksman", AttributeName.agi),
    Skill(SkillName.mercantile, "Mercantile", AttributeName.per),
    Skill(SkillName.mysticism, "Mysticism", AttributeName.int),
    Skill(SkillName.restoration, "Restoration", AttributeName.wil),
    Skill(SkillName.security, "Security", AttributeName.agi),
    Skill(SkillName.sneak, "Sneak", AttributeName.agi),
    Skill(SkillName.speechcraft, "Speechcraft", AttributeName.per),
    Skill(SkillName.unarmed, "Hand to Hand", AttributeName.str)
  ]; 