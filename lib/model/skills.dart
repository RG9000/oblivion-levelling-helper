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
  SkillName id;
  String name;
  AttributeName governingAttribute;
  int totalLevel;
  int levelSinceLevelUp;
  bool isMajor;

  Skill(this.id, this.name, this.governingAttribute, this.totalLevel, this.levelSinceLevelUp, this.isMajor); 
  
  Map<String, dynamic> toMap() {
    return {
      'id': id.index,
      'name': name,
      'governingAttribute': governingAttribute.index,
      'totalLevel': totalLevel,
      'levelSinceLevelUp': levelSinceLevelUp,
      'isMajor': isMajor ? 1 : 0
    };
  }

  
}

