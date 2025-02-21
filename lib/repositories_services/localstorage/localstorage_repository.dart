import 'package:result_dart/result_dart.dart';

abstract class LocalstorageRepository {
  Future<Result<bool>> init();
  Future<Result<bool>> saveData(String key, Map<dynamic, dynamic> data);
  Future<Result<Map<dynamic, dynamic>>> getData(String key);
}
