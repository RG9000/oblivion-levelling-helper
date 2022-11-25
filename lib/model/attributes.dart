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

class Attribute
{
  final AttributeName id;
  final String name;

  Attribute(this.id, this.name);

  Map<String, dynamic> toMap() =>
    {
      'id': id.index,
      'name': name,
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
      'characterId': characterId,
      'attributeId': attributeId.index,
      'value': value
    };

}