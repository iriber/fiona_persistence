
import 'package:fiona_persistence/src/data/persistence/fiona_persistence_batch.dart';
import 'package:fiona_persistence/src/data/persistence/fiona_persistence_scheme.dart';

abstract class FionaPersistence{

  Future<void> init();

  Future<List<Map<String, Object?>>> findAll(String entityName, {String? where, List<Object?>? whereArgs, String? orderBy, int? limit, int? offset});

  Future<Map<String, Object?>?> findBy(String entityName, {String? where, List<Object?>? whereArgs});

  Future<int> add(String entityName, Map<String, Object?> entity);

  Future<bool> update(String entityName, Map<String, Object?> entity, String idName, dynamic idValue);

  Future<int> remove(String entityName, {String? where, List<Object?>? whereArgs});

  Future<int> removeAll(String entityName);

  Future<List<Map<String, Object?>>> query(String sql, {List<Object?>? arguments});

  Future<FionaPersistenceBatch> getBatch();

  FionaPersistenceScheme getScheme();
}