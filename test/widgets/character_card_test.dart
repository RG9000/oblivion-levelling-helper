
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oblivion_skill_diary/model/character.dart';
import 'package:oblivion_skill_diary/widgets/character_card.dart';

void main() {

  
 testWidgets('Character Card renders correctly',
    (tester) async {

    Character character = Character(1, "test", 5);
    
    await tester.pumpWidget(
      MaterialApp(home: CharacterCard(character: character))
    );

    final levelFinder = find.text("level 5");

    final nameFinder = find.byWidgetPredicate(
    (widget) =>
      widget is Text &&
      widget.style?.fontSize == 30 &&
      widget.data == "test" &&
      widget.textAlign == TextAlign.center,
    description: 'Title Text',
  );

    expect(nameFinder, findsOneWidget);
    expect(levelFinder, findsOneWidget);
    
  }); 

}