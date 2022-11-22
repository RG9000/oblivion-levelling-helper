
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/skill_provider.dart';
import '../utils.dart';
import '../widgets/skill_card.dart';

class SkillTrackerPage extends StatefulWidget {
  const SkillTrackerPage({Key? key}) : super(key: key);

  @override
  State<SkillTrackerPage> createState() => _SkillTrackerPageState();
}

class _SkillTrackerPageState extends State<SkillTrackerPage> {
  bool _isLevelLocked = false;
  int _characterId = -1;
  @override
  void initState() {
    super.initState();
    // Timer.periodic(const Duration(milliseconds: 10000), (Timer t) {
    //   Provider.of<SkillProvider>(context, listen: false).truncateSkills();
    //   var skills = Provider.of<SkillProvider>(context, listen: false).skills;
    //   for (var element in skills) {
    //     Provider.of<SkillProvider>(context, listen: false).insertSkillIntoDatabase(element);
    //   }
    // });
    //setState(() {
    Provider.of<SkillProvider>(context, listen: false).init();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    // return Scaffold(
    //     appBar: AppBar(
    //         actions: [
    //           IconButton(
    //               icon: Icon(_isLevelLocked
    //                   ? Icons.lock_outline
    //                   : Icons.lock_open_outlined),
    //               onPressed: () {
    //                 setState(() {
    //                   if (!_isLevelLocked &&
    //                       Provider.of<SkillProvider>(context, listen: false)
    //                               .getNumberOfMajorSkills() <
    //                           7) {
    //                     //show an error
    //                     return;
    //                   }
    //                   _isLevelLocked = !_isLevelLocked;
    //                 });
    //               }),
    //         ],
    //         leading: IconButton(
    //           icon: const Icon(Icons.menu),
    //           onPressed: () => showDialog<String>(
    //               context: context,
    //               builder: (BuildContext context) => AlertDialog(
    //                       title: const Text('Level Progress'),
    //                       content: Column(
    //                           mainAxisSize: MainAxisSize.min,
    //                           children: Provider.of<SkillProvider>(context,
    //                                   listen: false)
    //                               .attributes
    //                               .entries
    //                               .map(
    //                                 (value) => Text(
    //                                     "${value.key.name.toUpperCase()}: ${Provider.of<SkillProvider>(context, listen: false).getAttributeIncreaseValue(value.key)} (+${getModifierForValue(Provider.of<SkillProvider>(context, listen: false).getAttributeIncreaseValue(value.key))})"),
    //                               )
    //                               .toList()),
    //                       actions: <Widget>[
    //                         TextButton(
    //                           onPressed: () => Navigator.pop(context, 'OK'),
    //                           child: const Text('OK'),
    //                         ),
    //                       ])),
    //         ),
    //         centerTitle: true,
    //         title: const Text(
    //           "Skill Tracker",
    //           style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    //         ),
    //         backgroundColor: Colors.black54),
    //     backgroundColor: Colors.black45,
    //     body: Stack(children: [
    //       SingleChildScrollView(
    //           child: Column(
    //               children:
    //                   Provider.of<SkillProvider>(context).skills.map((value) {
    //         return SkillCard(
    //           isLevelLocked: _isLevelLocked,
    //           skill: value,
    //         );
    //       }).toList())),
    //       Align(
    //           alignment: Alignment.bottomCenter,
    //           child: LinearProgressIndicator(
    //             value:
    //                 Provider.of<SkillProvider>(context).progressTowardsLevelUp /
    //                     10,
    //             minHeight: 30,
    //             color: Colors.amber,
    //             backgroundColor: Colors.amber.shade100,
    //           )),
    //     ]));
  }
}