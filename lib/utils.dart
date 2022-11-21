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

Map<AttributeName, int> generateEmptyAttributeMap() {
  return {
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

List<Skill> generateEmptySkillMap(int characterId)
{
  return [ 
          Skill(characterId, SkillName.acrobatics, "Acrobatics", AttributeName.spd, 0, 0, false),
          Skill(characterId, SkillName.alchemy, "Alchemy", AttributeName.int, 0, 0, false),
          Skill(characterId, SkillName.alteration, "Alteration", AttributeName.wil, 0, 0, false),
          Skill(characterId, SkillName.armorer, "Armorer", AttributeName.end, 0, 0, false),
          Skill(characterId, SkillName.athletics, "Athletics", AttributeName.spd, 0, 0, false),
          Skill(characterId, SkillName.blade, "Blade", AttributeName.str, 0, 0, false),
          Skill(characterId, SkillName.block, "Block", AttributeName.end, 0, 0, false),
          Skill(characterId, SkillName.blunt, "Blunt", AttributeName.str, 0, 0, false),
          Skill(characterId, SkillName.conjuration, "Conjuration", AttributeName.int, 0, 0, false),
          Skill(characterId, SkillName.destruction, "Destruction", AttributeName.wil, 0, 0, false),
          Skill(characterId, SkillName.heavyArmor, "Heavy Armor", AttributeName.end, 0, 0, false),
          Skill(characterId, SkillName.illusion, "Illusion", AttributeName.per, 0, 0, false),
          Skill(characterId, SkillName.lightArmor, "Light Armor", AttributeName.spd, 0, 0, false),
          Skill(characterId, SkillName.marksman, "Marksman", AttributeName.spd, 0, 0, false),
          Skill(characterId, SkillName.mercantile, "Mercantile", AttributeName.per, 0, 0, false),
          Skill(characterId, SkillName.mysticism, "Mysticism", AttributeName.int, 0, 0, false),
          Skill(characterId, SkillName.restoration, "Restoration", AttributeName.wil, 0, 0, false),
          Skill(characterId, SkillName.security, "Security", AttributeName.agi, 0, 0, false),
          Skill(characterId, SkillName.sneak, "Sneak", AttributeName.agi, 0, 0, false),
          Skill(characterId, SkillName.speechcraft, "Speechcraft", AttributeName.per, 0, 0, false),
          Skill(characterId, SkillName.unarmed, "Hand to Hand", AttributeName.str, 0, 0, false)
        ]; 
}