class Character
{
  int id;
  String name;
  int level = 1;

  Character(this.id, this.name, this.level);

  Map<String, dynamic> toMap() =>
    {
      'id': id,
      'name': name,
      'level': level
    };

  Map<String, dynamic> toMapForInsert() =>
    {
      'name': name,
      'level': level
    };
}



