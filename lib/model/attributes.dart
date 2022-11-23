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