import 'package:flutter_test/flutter_test.dart';
import 'package:oblivion_skill_diary/model/attributes.dart';
import 'package:oblivion_skill_diary/model/character.dart';
import 'package:oblivion_skill_diary/model/detailed_character.dart';
import 'package:oblivion_skill_diary/model/skills.dart';
import 'package:oblivion_skill_diary/utils.dart';

void main() {

  test('Detailed character can be created from constituents', () async {
    var character = Character(1, "test character", 5);
    var skills = generateEmptySkillMap();
    var attributes = generateEmptyAttributeMap();
    var characterSkills = [
      CharacterSkill(1, 1, SkillName.acrobatics, 1,2, true),
      CharacterSkill(2, 1, SkillName.alchemy, 3,4, false),
      CharacterSkill(3, 1, SkillName.armorer, 5,6, true)
    ];

    var characterAttributes = [
      CharacterAttribute(1,1,AttributeName.spd, 1),
      CharacterAttribute(2,1,AttributeName.int, 2),
      CharacterAttribute(3,1,AttributeName.end, 3),
    ];

    var actual = DetailedCharacter(character.id, character.name, character.level, skills, attributes, characterSkills, characterAttributes);

    expect(actual.attributes.length, 3);
    expect(actual.skills.length, 3);

    expect(actual.skills[0].id, SkillName.acrobatics);
    expect(actual.skills[0].governingAttributeId, AttributeName.spd);
    expect(actual.skills[0].totalLevel, 1);
    expect(actual.skills[0].levelSinceLevelUp, 2);
    expect(actual.skills[1].id, SkillName.alchemy);
    expect(actual.skills[1].governingAttributeId, AttributeName.int);
    expect(actual.skills[1].totalLevel, 3);
    expect(actual.skills[1].levelSinceLevelUp, 4);
    expect(actual.skills[2].id, SkillName.armorer);
    expect(actual.skills[2].governingAttributeId, AttributeName.end);
    expect(actual.skills[2].totalLevel, 5);
    expect(actual.skills[2].levelSinceLevelUp, 6);

    expect(actual.attributes[0].id, AttributeName.spd);
    expect(actual.attributes[0].name, "Speed");
    expect(actual.attributes[0].value, 1);
    expect(actual.attributes[1].id, AttributeName.int);
    expect(actual.attributes[1].name, "Intelligence");
    expect(actual.attributes[1].value, 2);
    expect(actual.attributes[2].id, AttributeName.end);
    expect(actual.attributes[2].name, "Endurance");
    expect(actual.attributes[2].value, 3);

    expect(actual.id, 1);
    expect(actual.name, "test character");
    expect(actual.level, 5);
  });
}