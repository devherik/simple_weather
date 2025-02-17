import 'package:result_dart/result_dart.dart';

abstract class LocalstorageApi {
  Future<Result<void>> initApi();
  Future<Result<void>> saveData(String key, Map<String, dynamic> data);
  Future<Result<Map<String, dynamic>>> getData(String key);
}
