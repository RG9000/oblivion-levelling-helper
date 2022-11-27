import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:oblivion_skill_diary/model/attributes.dart';
import 'package:oblivion_skill_diary/model/skills.dart';
import 'package:oblivion_skill_diary/utils.dart';

import '../model/character.dart';

List<GlobalKey<FormState>> formKeys = [
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>()
];

class CharacterCreationPage extends StatefulWidget {
  int nextCharacterId;

  CharacterCreationPage({Key? key, required this.nextCharacterId}) : super(key: key);

  @override
  State<CharacterCreationPage> createState() => _CharacterCreationPageState();
}

class _CharacterCreationPageState extends State<CharacterCreationPage> {
  int currentStep = 0;
  static Character character = Character(0, "", 0);

  bool characterNameValid = true;
  final characterNameController = TextEditingController();

  List<CharacterSkill> characterSkills = [];
  List<CharacterAttribute> characterAttributes = [];
  List<Skill> allSkills = generateEmptySkillMap();
  List<Attribute> allAttributes = generateEmptyAttributeMap();

  static var _focusNode = FocusNode();
  int numMajorSkillsSelected = 0;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Step> steps = [];

  @override
  void initState() {
    super.initState();

    characterSkills = allSkills.map((e) => CharacterSkill(0, widget.nextCharacterId, e.id, 1, 0, false)).toList();
    characterAttributes = allAttributes.map((e) => CharacterAttribute(0, widget.nextCharacterId, e.id, 0)).toList();

    steps = <Step>[
      Step(
          title: const Text('Name'),
          isActive: true,
          state: StepState.indexed,
          content: Form(
            key: formKeys[0],
            child: Column(
              children: <Widget>[
                TextFormField(
                  focusNode: _focusNode,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  onSaved: (String? value) {
                    character.name = value ?? "";
                  },
                  maxLines: 1,
                  //initialValue: 'Aseem Wangoo',
                  validator: (value) {
                    if (value == null || value.isEmpty || value.isEmpty) {
                      return 'Character name must not be empty';
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'Enter character name',
                      icon: Icon(Icons.person),
                      labelStyle: TextStyle(
                          decorationStyle: TextDecorationStyle.solid)),
                ),
              ],
            ),
          )),
      Step(
          title: const Text('Major Skills'),
          isActive: true,
          state: StepState.indexed,
          content: Form(
            key: formKeys[1],
            child: Column(
                children: <Widget>[const Padding(padding:EdgeInsets.only(bottom:10), child: Text("Select your 7 Major Skills"))]
                    +characterSkills 
                    .map((e) => StatefulBuilder(
                        builder: (context, _setState) => CheckboxListTile(
                            title: Text(allSkills.firstWhere((element) => element.id == e.skillId).name),
                            value: e.isMajor,
                            onChanged: (newValue) {
                              _setState(() {
                                if (newValue == true) {
                                  if (numMajorSkillsSelected < 7) {
                                    numMajorSkillsSelected += 1;
                                    e.isMajor = true;
                                  }
                                } else {
                                  numMajorSkillsSelected -= 1;
                                  e.isMajor = false;
                                }
                              });
                            }))).toList()
            )),
          ),
          Step(
          title: const Text('Initial Skill Levels'),
          isActive: true,
          state: StepState.indexed,
          content: Form(
            key: formKeys[2],
            child: Column(
                children: <Widget>[const Padding(padding:EdgeInsets.only(bottom:10), child: Text("Enter your initial skill values"))]
                    +characterSkills 
                    .map((e) => StatefulBuilder(
                        builder: (context, _setState) => Column(children: [
                          Text(allSkills.firstWhere((element) => element.id == e.skillId,).name),
                          SpinBox(
                            value: e.totalLevel.toDouble(),
                            onChanged: (newValue) {
                              _setState(() {
                                e.totalLevel = newValue.toInt();
                              });
                            })])
                      )).toList()
            )),
          )
    ];
    // _focusNode.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    characterNameController.dispose();
    //_focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Character Creation",
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Stepper(
              type: StepperType.horizontal,
              currentStep: currentStep,
              steps: steps,
              onStepContinue: () {
                setState(() {
                  if (formKeys[currentStep].currentState?.validate() != null &&
                      formKeys[currentStep].currentState?.validate() == true) {
                    if (currentStep < steps.length - 1) {
                      if (currentStep == 0)
                      {
                        character.name = characterNameController.text;
                      }
                      currentStep = currentStep + 1;
                    } else {
                      currentStep = 0;
                    }
                  }
                });
              }),
        ));
  }
}
