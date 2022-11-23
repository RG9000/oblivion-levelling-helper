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



