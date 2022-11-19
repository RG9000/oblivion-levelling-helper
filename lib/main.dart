import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oblivion_skill_diary/provider/skill_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'model/skills.dart';

void main() {
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const OblivionSkillDiaryApp());
}

class OblivionSkillDiaryApp extends StatelessWidget {
  const OblivionSkillDiaryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SkillProvider(),
        child: Consumer<SkillProvider>(
            builder: (context, model, child) => const MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: SkillTrackerPage(),
                )));
  }
}

class SkillTrackerPage extends StatefulWidget {
  const SkillTrackerPage({Key? key}) : super(key: key);

  @override
  State<SkillTrackerPage> createState() => _SkillTrackerPageState();
}

class _SkillTrackerPageState extends State<SkillTrackerPage> {
  bool _isLevelLocked = false;
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 10000), (Timer t) {
      Provider.of<SkillProvider>(context, listen: false).truncateSkills();
      var skills = Provider.of<SkillProvider>(context, listen: false).skills;
      skills.forEach((element) { 
        Provider.of<SkillProvider>(context, listen: false).insertSkill(element);
      });
    } );
    setState(() {
      Provider.of<SkillProvider>(context, listen: false).loadFreshSkillMap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(_isLevelLocked
                    ? Icons.lock_outline
                    : Icons.lock_open_outlined),
                onPressed: () {
                  setState(() {
                    if (!_isLevelLocked &&
                        Provider.of<SkillProvider>(context, listen: false)
                                .getNumberOfMajorSkills() <
                            7) {
                      //show an error
                      return;
                    }
                    _isLevelLocked = !_isLevelLocked;
                  });
                }),
          ],
          leading: IconButton(icon: Icon(Icons.menu), onPressed: () =>
              showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Level Progress'),
                content: Column(mainAxisSize: MainAxisSize.min, children: Provider.of<SkillProvider>(context, listen: false).attributes.entries.map((value) => 
                  Text("${value.key.name.toUpperCase()}: ${Provider.of<SkillProvider>(context,listen:false).getAttributeIncreaseValue(value.key)} (+${getModifierForValue(Provider.of<SkillProvider>(context,listen:false).getAttributeIncreaseValue(value.key))})"),).toList()
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ]))
          ,), 
          centerTitle: true,
          title: const Text(
            "Skill Tracker",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black54),
      backgroundColor: Colors.black45,
      body: Stack(children: [SingleChildScrollView(
          child: Column(
              children: Provider.of<SkillProvider>(context)
                  .skills
                  .map((value) {
        return SkillCard(
          isLevelLocked: _isLevelLocked,
          skill: value,
        );
      }).toList())), Align(alignment: Alignment.bottomCenter, child: LinearProgressIndicator(value: Provider.of<SkillProvider>(context).progressTowardsLevelUp/10, minHeight: 30, color: Colors.amber, backgroundColor: Colors.amber.shade100,)),
    ]));
  }
}

class SkillCard extends StatefulWidget {
  SkillCard(
      {Key? key,
      required this.isLevelLocked,
      required this.skill,
      })
      : super(key: key);

  bool isLevelLocked = false;
  Skill skill;

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
        child: Card(
            color: Colors.black87,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(children: [
                MajorSkillSignifier(
                    isLevelLocked: widget.isLevelLocked,
                    skillKey: widget.skill.id,
                    skill: widget.skill),
                Text(widget.skill.name,
                    style:
                        const TextStyle(fontSize: 20, color: Colors.white70)),
                const Spacer(),
                (!widget.isLevelLocked
                    ? IconButton(
                        onPressed: () {
                          Provider.of<SkillProvider>(context, listen: false).decrementSkill(widget.skill.id);
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white70,
                        ))
                    : const Icon(Icons.remove, color: Colors.black54)),
                Text(widget.skill.totalLevel.toString(),
                    style:
                        const TextStyle(fontSize: 20, color: Colors.white70)),
                IconButton(
                    onPressed: () {
                      Provider.of<SkillProvider>(context, listen: false)
                          .incrementSkill(
                              widget.isLevelLocked, widget.skill.id);
                    },
                    icon: const Icon(Icons.add, color: Colors.white70)),
              ]),
            )));
  }
}

class MajorSkillSignifier extends StatefulWidget {
  MajorSkillSignifier(
      {Key? key,
      required this.isLevelLocked,
      required this.skillKey,
      required this.skill})
      : super(key: key);

  bool isLevelLocked;
  SkillName skillKey;
  Skill skill;

  @override
  _MajorSkillSignifierState createState() => _MajorSkillSignifierState();
}

class _MajorSkillSignifierState extends State<MajorSkillSignifier> {
  @override
  Widget build(BuildContext context) {
    return widget.isLevelLocked
        ? (widget.skill.isMajor
            ? const Icon(
                Icons.star,
                color: Colors.white70,
              )
            : const Icon(Icons.star, color: Colors.black87))
        : (widget.skill.isMajor
            ? IconButton(
                icon: const Icon(Icons.star, color:Colors.white70),
                onPressed: () {
                  Provider.of<SkillProvider>(context, listen: false)
                      .makeSkillMinor(widget.skillKey);
                })
            : IconButton(
                onPressed: () {
                  Provider.of<SkillProvider>(context, listen: false)
                      .makeSkillMajor(widget.skillKey);
                },
                icon: const Icon(
                  Icons.star_outline,
                  color: Colors.white70,
                )));
  }
}

int getModifierForValue(int val) {
  if (val == 0) 
  {
    return 1;
  }
  else if (val <= 4)
  {
    return 2;
  }
  else if (val <= 7)
  {
    return 3;
  }
  else if (val <= 9)
  {
    return 4;
  }
  else{
    return 5;
  }
   
}