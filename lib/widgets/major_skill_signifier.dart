
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/skills.dart';
import '../provider/skill_provider.dart';

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
