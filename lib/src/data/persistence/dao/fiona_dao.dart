import 'package:fiona_persistence/src/data/persistence/fiona_persistence.dart';


abstract class FionaDAO<T> {

  final FionaPersistence persistence;

  FionaDAO(this.persistence);

  String get entityName;

  String get createSQL;

  String get id => "id";

  T fromMap(Map<String, Object?> entity);

  Map<String, Object?> toMap(T entity);

  dynamic getId(T entity);

  FionaPersistence getPersistence(){
    return persistence;
  }

  Future<int> add(T entity) async {
    int result = 0;
    result = await persistence.add( entityName, toMap(entity));
    return result;
  }

  Future<bool> update(T entity)async{
    return await persistence.update( entityName, toMap(entity), id, getId(entity));
  }

  Future<List<T>> findAll({String? where, List<Object?>? whereArgs, String? orderBy, int? limit, int? offset}) async {
    final List<Map<String, Object?>> queryResult = await persistence.findAll(entityName, where: where, whereArgs: whereArgs, orderBy: orderBy, limit: limit, offset: offset);
    return queryResult.map((e) => fromMap(e)).toList();
  }

  Future<T> getById(dynamic entityId) async {
    final Map<String, Object?> queryResult = await persistence.findBy(entityName, where: "$id = ?", whereArgs: [entityId]);
    return fromMap(queryResult);
  }

  Future<T> getBy({String? where, List<Object?>? whereArgs}) async {
    final Map<String, Object?> queryResult = await persistence.findBy(entityName, where: where, whereArgs: whereArgs);
    return fromMap(queryResult);
  }

  Future<void> delete(T entity) async {
    try {
      await persistence.remove(entityName, where: "$id = ?", whereArgs: [getId(entity)]);
    } catch (err) {
    }
  }

  Future<void> deleteAll() async {
    try {
      await persistence.removeAll(entityName);
    } catch (err) {
    }
  }
}