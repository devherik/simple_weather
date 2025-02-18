import 'package:result_dart/result_dart.dart';

abstract class LocalstorageRepository {
  Future<Result<bool>> init();
  Future<Result<bool>> saveData(String key, Map<String, dynamic> data);
  Future<Result<Map<String, dynamic>>> getData(String key);
}
