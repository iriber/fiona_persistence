

class PersistenceException implements Exception{

  String message;

  PersistenceException({String this.message="persistence.exception"});

  @override
  String toString() {
    return message;
  }
}