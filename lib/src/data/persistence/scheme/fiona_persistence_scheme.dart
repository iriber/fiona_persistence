import 'dart:collection';

import 'package:fiona_persistence/src/data/persistence/scheme/command_script.dart';
import 'package:fiona_persistence/src/data/persistence/fiona_persistence.dart';
import 'package:fiona_persistence/src/data/persistence/fiona_persistence_batch.dart';

/**
 * This class create the persistence scheme and manage the upgrading.
 */
abstract class FionaPersistenceScheme{

  final Map<int, List<CommandScript>> versionCommands = HashMap();

  List<String> logs= List.empty(growable: true);

  String getSchemeName();

  String getPath();

  int getSchemeVersion();

  void initializeCommands();

  Future<void> create(FionaPersistence persistence, int version) async{
    upgrade(persistence, 0, version);
  }

  Future<void> upgrade(FionaPersistence persistence, int oldVersion, int newVersion ) async{

    initializeCommands();

    FionaPersistenceBatch batch = await persistence.getBatch();

    for( int currentVersion=oldVersion+1; currentVersion<=newVersion; currentVersion++ ){
      List<CommandScript> commands = versionCommands[currentVersion]??List.empty();
      commands.forEach((command) {

        logs.add(command.script);
        command.execute(batch);
      });
    }

    await batch.commit();

  }

}