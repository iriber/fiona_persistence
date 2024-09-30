import 'package:fiona_persistence/src/data/persistence/fiona_persistence_batch.dart';

/**
 * This class represents a command script
 * We will have a command script for each alter of our persistence.
 * For example if we need to have a column to a table, we'll have
 * CommandScript with "ALTER TABLE ADD COLUMNM etc etc"
 */
class CommandScript{

  String script;

  CommandScript(this.script);

  Future<void> execute(FionaPersistenceBatch batch) async {

    batch.execute(this.script);
  }

}