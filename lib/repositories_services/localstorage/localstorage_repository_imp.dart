import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:result_dart/result_dart.dart';
import 'package:simple_weather_app/repositories_services/localstorage/localstorage_repository.dart';

class LocalstorageRepositoryImp implements LocalstorageRepository {
  LocalstorageRepositoryImp._();
  static final instance = LocalstorageRepositoryImp._();
  late Box _box;

  bool _status = false;

  @override
  Future<Result<Map<dynamic, dynamic>>> getData(String key) async {
    try {
      final data = _box.get(key);
      if (data == null) {
        return Failure(Exception('Data do not exist.'));
      } else {
        return Success(
            data.map((key, value) => MapEntry(key.toString(), value)));
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<bool>> init() async {
    if (!_status) {
      try {
        final dir = await getApplicationDocumentsDirectory();
        await Hive.initFlutter(dir.path);
        await Hive.openBox('appPreferences').then((value) async {
          _box = value;
          _status = true;
        });
        return Success(_box.isOpen);
      } on Exception catch (e) {
        return Failure(e);
      }
    } else {
      return Success(_box.isOpen);
    }
  }

  @override
  Future<Result<bool>> saveData(String key, Map<dynamic, dynamic> data) async {
    try {
      await _box.put(key, data);
      return Success(true);
    } on Exception {
      return Failure(Exception('Error on saveData'));
    }
  }
}
