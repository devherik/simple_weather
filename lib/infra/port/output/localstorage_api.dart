import 'package:result_dart/result_dart.dart';

abstract class LocalstorageApi {
  Future<Result<bool>> initApi();
  Future<Result<bool>> saveData(String key, Map<String, dynamic> data);
  Future<Result<Map<String, dynamic>>> getData(String key);
}
