import 'skills.dart';
import 'attributes.dart';
import 'character.dart';

class DetailedCharacter extends Character
{
  List<DetailedSkill> skills = [];
  List<DetailedAttribute> attributes = [];

  DetailedCharacter(
   super.id,
   super.name, 
   super.level,
   List<Skill> allSkills,
   List<Attribute> allAttributes,
   List<CharacterSkill> characterSkills,
   List<CharacterAttribute> characterAttributes)
  {
    for (var characterSkill in characterSkills)
    {
      var thisSkill = allSkills.firstWhere((element) => element.id == characterSkill.skillId);
      skills.add(DetailedSkill(thisSkill.id, thisSkill.name, thisSkill.governingAttributeId, characterSkill));
    }
    for (var characterAttribute in characterAttributes)
    {
      var thisAttribute = allAttributes.firstWhere((element) => element.id == characterAttribute.attributeId);
      attributes.add(DetailedAttribute(thisAttribute.id, thisAttribute.name, characterAttribute));
    }
  }
}

class DetailedSkill extends Skill
{
  int levelSinceLevelUp = 0;
  int totalLevel = 0;
  bool isMajor = false;

  DetailedSkill(super.id, super.name, super.governingAttributeId, CharacterSkill skill)
  {
    levelSinceLevelUp = skill.levelsSinceLevelUp;
    totalLevel = skill.totalLevel;
    isMajor = skill.isMajor;
  }
}

class DetailedAttribute extends Attribute
{
  int value = 0; 

  DetailedAttribute(super.id, super.name, CharacterAttribute attribute)
  {
    value = attribute.value;
  }
}