import 'attributes.dart';

class Character
{
  final int id;
  final String name;
  int level = 1;

  Character(this.id, this.name, this.level);

  Map<String, dynamic> toMap() =>
    {
      'id': id,
      'name': name,
      'level': level
    };
}

class CharacterAttribute
{
  final int id;
  final int characterId;
  final AttributeName attributeId;
  int value;

  CharacterAttribute(this.id, this.characterId, this.attributeId, this.value);

   Map<String, dynamic> toMap() =>
    {
      'id': id,
      'characterId': characterId,
      'attributeId': attributeId.index,
      'value': value
    };
}

