import 'attributes.dart';

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


class Skill2 {
  int characterId;
  SkillName id;
  String name;
  AttributeName governingAttribute;
  int totalLevel;
  int levelSinceLevelUp;
  bool isMajor;

  Skill2(this.characterId, this.id, this.name, this.governingAttribute, this.totalLevel, this.levelSinceLevelUp, this.isMajor); 
  
  Map<String, dynamic> toMap() =>
    {
      'id': id.index,
      'name': name,
      'governingAttribute': governingAttribute.index,
      'totalLevel': totalLevel,
      'levelSinceLevelUp': levelSinceLevelUp,
      'isMajor': isMajor ? 1 : 0
    };
}

class Skill {
  final SkillName id;
  final String name;
  final AttributeName governingAttributeId;

  Skill(this.id, this.name, this.governingAttributeId);

  Map<String, dynamic> toMap() =>
    {
      'id': id.index,
      'name': name,
      'governingAttributeId': governingAttributeId.index,
    };
}

class CharacterSkill
{
  final int id;
  final int characterId;
  final SkillName skillId;
  int totalLevel;
  int levelsSinceLevelUp;
  bool isMajor;

  CharacterSkill(this.id, this.characterId, this.skillId, this.totalLevel, this.levelsSinceLevelUp, this.isMajor);

  Map<String, dynamic> toMap() =>
    {
      'id': id,
      'characterId': characterId,
      'skillId': skillId.index,
      'totalLevel': totalLevel,
      'levelsSinceLevelUp': levelsSinceLevelUp,
      'isMajor': isMajor == false ? 0 : 1
    };

    Map<String, dynamic> toMapForInsert() =>
    {
      'characterId': characterId,
      'skillId': skillId.index,
      'totalLevel': totalLevel,
      'levelsSinceLevelUp': levelsSinceLevelUp,
      'isMajor': isMajor == false ? 0 : 1
    };
}