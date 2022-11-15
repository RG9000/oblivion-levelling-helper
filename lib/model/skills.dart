enum SkillName {
  blade,
  blunt,
  unarmed,
  armorer,
  block,
  heavyArmor,
  athletics,
  alteration,
  destruction,
  restoration,
  alchemy,
  conjuration,
  mysticism,
  illusion,
  security,
  sneak,
  marksman,
  acrobatics,
  lightArmor,
  mercantile,
  speechcraft
}

enum AttributeName {
  str,
  int,
  wil,
  agi,
  spd,
  end,
  per,
  luck;
}

class Skill {
  String name;
  AttributeName governingAttribute;
  int totalLevel;
  int levelSinceLevelUp;
  bool isMajor;

  Skill(this.name, this.governingAttribute, this.totalLevel, this.levelSinceLevelUp, this.isMajor); 
}

