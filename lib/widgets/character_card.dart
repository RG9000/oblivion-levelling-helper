import 'package:flutter/material.dart';

import '../model/character.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({Key? key, required this.character}) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: InkWell(
            onTap: () => {},
            child: Container(
                width: 800,
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                child: Column(children: [
                  Text(
                    character.name,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text("level ${character.level.toString()}"),
                  ),
                ]))));
  }
}
