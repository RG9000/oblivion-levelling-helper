import 'package:flutter/material.dart';

//currently unused
class CharacterSelectionCard extends StatelessWidget {
  const CharacterSelectionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: InkWell(onTap: () => {}, child: Stack(children: [
        Image.asset(
          'assets/Card.png',
          scale: 4,
        ),
        Padding(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text("Lucian Lachance", style: TextStyle(fontSize: 30)),
              Text("Assassin", style: TextStyle(fontSize: 20),),
              Text("Level 10", style: TextStyle(fontSize: 18),),
              Text("STR 10, INT 5, WIL 4, AGI 7, SPD 6", style: TextStyle(fontSize: 18),),
              ]))
      ]),
    ));
  }
}