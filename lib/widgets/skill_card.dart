import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/skills.dart';
import '../provider/skill_provider.dart';
import 'major_skill_signifier.dart';

class SkillCard extends StatelessWidget {
  SkillCard(
      {Key? key,
      required this.isLevelLocked,
      required this.skill,
      })
      : super(key: key);

  bool isLevelLocked = false;
  Skill skill;

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
                    isLevelLocked: isLevelLocked,
                    skillKey: skill.id,
                    skill: skill),
                Text(skill.name,
                    style:
                        const TextStyle(fontSize: 20, color: Colors.white70)),
                const Spacer(),
                (!isLevelLocked
                    ? IconButton(
                        onPressed: () {
                          Provider.of<SkillProvider>(context, listen: false).decrementSkill(skill.id);
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white70,
                        ))
                    : const Icon(Icons.remove, color: Colors.black54)),
                Text(skill.totalLevel.toString(),
                    style:
                        const TextStyle(fontSize: 20, color: Colors.white70)),
                IconButton(
                    onPressed: () {
                      Provider.of<SkillProvider>(context, listen: false)
                          .incrementSkill(
                              isLevelLocked, skill.id);
                    },
                    icon: const Icon(Icons.add, color: Colors.white70)),
              ]),
            )));
  }
}