import 'dart:collection';

import 'package:fiona_persistence/src/data/persistence/fiona_persistence.dart';
import 'package:fiona_persistence/src/data/persistence/fiona_persistence_batch.dart';
import 'package:fiona_persistence/src/data/persistence/scheme/command_script.dart';

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

  Future<void> create(FionaPersistenceBatch batch, int version) async{
    upgrade(batch, 0, version);
  }

  Future<void> upgrade(FionaPersistenceBatch batch, int oldVersion, int newVersion ) async{

    initializeCommands();

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