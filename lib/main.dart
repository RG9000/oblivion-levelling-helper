import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oblivion_skill_diary/pages/skill_tracker_page.dart';
import 'package:oblivion_skill_diary/provider/skill_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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