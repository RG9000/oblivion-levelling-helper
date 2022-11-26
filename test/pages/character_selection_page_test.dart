import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oblivion_skill_diary/model/character.dart';
import 'package:oblivion_skill_diary/pages/character_selection_page.dart';
import 'package:oblivion_skill_diary/provider/state_provider.dart';
import 'package:provider/provider.dart';

import 'character_selection_page_test.mocks.dart';

@GenerateMocks([StateProvider])
void main() {
  testWidgets('Character Selection Page Appbar renders correctly',
      (tester) async {
    var stateProvider = MockStateProvider();

    List<Character> noCharacters = []; 

    when(stateProvider.getAllCharacters()).thenAnswer((_) async => noCharacters);

    await tester.pumpWidget(
      ListenableProvider<StateProvider>.value(
        value: stateProvider,
        child: const MaterialApp(home: CharacterSelectionPage()), 
      ),
    );

    final titleFinder = find.text("Oblivion Levelling Helper");

    expect(titleFinder, findsOneWidget);
  });

   testWidgets('Add character button in center of screen when no characters',
      (tester) async {
    var stateProvider = MockStateProvider();

    List<Character> noCharacters = []; 

    when(stateProvider.getAllCharacters()).thenAnswer((_) async => noCharacters);

    await tester.pumpWidget(
      ListenableProvider<StateProvider>.value(
        value: stateProvider,
        child: const MaterialApp(home: CharacterSelectionPage()), 
      ),
    );

    final iconFinder = find.byKey(const Key("centralized_add_button"));
    expect(iconFinder, findsOneWidget);
  });


   testWidgets('Add character button is floating when there are characters',
      (tester) async {
    var stateProvider = MockStateProvider();

    List<Character> someCharacters = [
      Character(1, "test1", 1),
      Character(2, "test2", 1),
      Character(3, "test3", 1),
      Character(4, "test4", 1),
      Character(5, "test5", 1),
    ]; 

    when(stateProvider.getAllCharacters()).thenAnswer((_) async => someCharacters);

    await tester.pumpWidget(
      ListenableProvider<StateProvider>.value(
        value: stateProvider,
        child: const MaterialApp(home: CharacterSelectionPage()), 
      ),
    );

    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    final centralIconFinder = find.byKey(const Key("centralized_add_button"));
    final floatingIconFinder = find.byKey(const Key("floating_add_button"));
    expect(centralIconFinder, findsNothing);
    expect(floatingIconFinder, findsOneWidget);
  });
  
  testWidgets('Character list can be scrolled',
      (tester) async {
    var stateProvider = MockStateProvider();

    var someCharacters = List<Character>.generate(10000, (i) => Character(i, "test$i", 1));

    when(stateProvider.getAllCharacters()).thenAnswer((_) async => someCharacters);

    await tester.pumpWidget(
      ListenableProvider<StateProvider>.value(
        value: stateProvider,
        child: const MaterialApp(home: CharacterSelectionPage()), 
      ),
    );

    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    final listFinder = find.byType(Scrollable);
    final itemFinder = find.byKey(const Key("character_card_9999"));

    await tester.scrollUntilVisible(
      itemFinder,
      500.0,
      scrollable: listFinder,
    );

    expect(itemFinder, findsOneWidget);
    
  });
}
