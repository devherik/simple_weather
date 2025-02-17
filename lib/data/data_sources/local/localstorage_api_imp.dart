import 'package:hive_flutter/hive_flutter.dart';
import 'package:result_dart/result_dart.dart';
import 'package:simple_weather_app/infra/port/output/localstorage_api.dart';
import 'package:simple_weather_app/model/weather_entity.dart';

class LocalstorageApiImp implements LocalstorageApi {
  LocalstorageApiImp._();
  static final LocalstorageApiImp instance = LocalstorageApiImp._();

  late Box _box;
  late WeatherEntity lastWeather;

  @override
  Future<Result<Map<String, dynamic>>> getData(String key) async {
    try {
      final Map<String, dynamic> data = _box.get(key);
      return Success(data);
    } on Exception {
      return Failure(Exception('Error on getData'));
    }
  }

  @override
  Future<Result<bool>> initApi() async {
    try {
      Hive.openBox('weather').then((value) {
        _box = value;
        lastWeather = WeatherEntity.fromJson(_box.get('LAST_WEATHER'));
      });
      return Success(true);
    } on Exception {
      return Failure(Exception('Error on initApi'));
    }
  }

  @override
  Future<Result<bool>> saveData(String key, Map<String, dynamic> data) async {
    try {
      _box.put(key, data);
      return Success(true);
    } on Exception {
      return Failure(Exception('Error on saveData'));
    }
  }
}
