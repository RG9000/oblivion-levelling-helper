// Mocks generated by Mockito 5.3.2 from annotations
// in oblivion_skill_diary/test/provider/state_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:oblivion_skill_diary/model/character.dart' as _i6;
import 'package:oblivion_skill_diary/model/detailed_character.dart' as _i3;
import 'package:oblivion_skill_diary/services/database_service.dart' as _i4;
import 'package:sqflite/sqflite.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDatabase_0 extends _i1.SmartFake implements _i2.Database {
  _FakeDatabase_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDetailedCharacter_1 extends _i1.SmartFake
    implements _i3.DetailedCharacter {
  _FakeDetailedCharacter_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DatabaseService].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseService extends _i1.Mock implements _i4.DatabaseService {
  MockDatabaseService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Database> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i5.Future<_i2.Database>.value(_FakeDatabase_0(
          this,
          Invocation.getter(#database),
        )),
      ) as _i5.Future<_i2.Database>);
  @override
  set database(_i5.Future<_i2.Database>? _database) => super.noSuchMethod(
        Invocation.setter(
          #database,
          _database,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<List<_i6.Character>> getAllCharacters() => (super.noSuchMethod(
        Invocation.method(
          #getAllCharacters,
          [],
        ),
        returnValue: _i5.Future<List<_i6.Character>>.value(<_i6.Character>[]),
      ) as _i5.Future<List<_i6.Character>>);
  @override
  _i5.Future<dynamic> addCharacter(_i3.DetailedCharacter? character) =>
      (super.noSuchMethod(
        Invocation.method(
          #addCharacter,
          [character],
        ),
        returnValue: _i5.Future<dynamic>.value(),
      ) as _i5.Future<dynamic>);
  @override
  _i5.Future<dynamic> updateCharacter(_i3.DetailedCharacter? character) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateCharacter,
          [character],
        ),
        returnValue: _i5.Future<dynamic>.value(),
      ) as _i5.Future<dynamic>);
  @override
  _i5.Future<_i3.DetailedCharacter> getCharacterById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCharacterById,
          [id],
        ),
        returnValue:
            _i5.Future<_i3.DetailedCharacter>.value(_FakeDetailedCharacter_1(
          this,
          Invocation.method(
            #getCharacterById,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.DetailedCharacter>);
  @override
  dynamic initDatabase([bool? isTest = false]) =>
      super.noSuchMethod(Invocation.method(
        #initDatabase,
        [isTest],
      ));
}