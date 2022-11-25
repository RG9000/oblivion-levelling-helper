
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oblivion_skill_diary/provider/state_provider.dart';
import 'package:oblivion_skill_diary/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

import 'state_provider_test.mocks.dart';

@GenerateMocks([DatabaseService])
void main() {

  test('provider constructor initializes database', () async {
    var dbService = MockDatabaseService();
    when(await dbService.initDatabase(false)).thenReturn(null);
    var uut = StateProvider(dbService);
    verify(dbService.initDatabase(false)).called(1);
  });

}