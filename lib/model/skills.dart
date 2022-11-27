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

class PickableSkill extends Skill {

  bool isPicked = false; 
  
  PickableSkill(super.id, super.name, super.governingAttributeId, this.isPicked);

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
      'characterId': characterId,
      'skillId': skillId.index,
      'totalLevel': totalLevel,
      'levelsSinceLevelUp': levelsSinceLevelUp,
      'isMajor': isMajor == false ? 0 : 1
    };
}