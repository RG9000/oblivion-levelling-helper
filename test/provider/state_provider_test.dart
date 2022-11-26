
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oblivion_skill_diary/model/character.dart';
import 'package:oblivion_skill_diary/provider/state_provider.dart';
import 'package:oblivion_skill_diary/services/database_service.dart';

import 'state_provider_test.mocks.dart';

@GenerateMocks([DatabaseService])
void main() {

  test('provider constructor initializes database', () async {
    var dbService = MockDatabaseService();
    when(await dbService.initDatabase(false)).thenReturn(null);
    StateProvider(dbService);
    verify(dbService.initDatabase(false)).called(1);
  });

  test('getAllCharacters calls database getAllCharacters method', () async {
    
    var dbService = MockDatabaseService();
    
    List<Character> noCharacters = []; 
    when(dbService.initDatabase(false)).thenAnswer((_) => null);
    when(dbService.getAllCharacters()).thenAnswer((_) async => noCharacters);

    var uut = StateProvider(dbService);
    await uut.getAllCharacters();
    verify(dbService.initDatabase(false)).called(1);
    verify(dbService.getAllCharacters()).called(1);
  });

}