abstract class FionaPersistenceBatch{

  Future<void> execute(String query);

  Future<void> commit();

}