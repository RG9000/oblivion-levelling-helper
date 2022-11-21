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
  final String fullName;

  Attribute(this.id, this.fullName);

  Map<String, dynamic> toMap() =>
    {
      'id': id.index,
      'fullName': fullName,
    };
}