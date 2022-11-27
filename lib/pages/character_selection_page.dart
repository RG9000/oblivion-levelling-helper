import 'dart:math';

import 'package:flutter/material.dart';
import 'package:oblivion_skill_diary/pages/character_creation_page.dart';
import 'package:oblivion_skill_diary/provider/state_provider.dart';
import 'package:provider/provider.dart';

import '../model/character.dart';
import '../widgets/character_card.dart';

class CharacterSelectionPage extends StatefulWidget {
  const CharacterSelectionPage({Key? key}) : super(key: key);

  @override
  State<CharacterSelectionPage> createState() => _CharacterSelectionPageState();
}

class _CharacterSelectionPageState extends State<CharacterSelectionPage> {
  late List<Character> characters = [];
  @override
  void initState() {
    Provider.of<StateProvider>(context, listen: false)
        .getAllCharacters()
        .then((value) {
      setState(() {
        characters = value;
      });
    });
    super.initState();
  }

  void goToCharacterCreationPage()
  {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CharacterCreationPage(nextCharacterId: characters.isEmpty ? 1 : characters.map((e) => e.id).reduce(max) + 1)),
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Oblivion Levelling Helper"), centerTitle: true),
      body: characters.isNotEmpty
          ? SingleChildScrollView(
              child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                      children: characters
                          .map((e) => CharacterCard(key: Key("character_card_${e.id}"), character: e))
                          .toList())),
            ))
          : Center(
              child: Column(children: [
              const Spacer(),
              IconButton(
                key: const Key("centralized_add_button"),
                onPressed: () => {goToCharacterCreationPage()},
                iconSize: 100,
                icon: const Icon(Icons.add_circle_outline),
              ),
              const Spacer()
            ])),
      floatingActionButton: characters.isNotEmpty
          ? FloatingActionButton(
              key: const Key("floating_add_button"),
              onPressed: () => {goToCharacterCreationPage()},
              tooltip: 'Add New Character',
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
