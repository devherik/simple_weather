abstract class LocalstorageApi {
  Future<bool> initApi();
  Future<bool> saveData(String key, Map<String, dynamic> data);
  Future<Map<String, dynamic>> getData(String key);
}
