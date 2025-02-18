import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_weather_app/infra/port/output/localstorage_api.dart';

class LocalstorageApiImp implements LocalstorageApi {
  LocalstorageApiImp._();
  static final LocalstorageApiImp instance = LocalstorageApiImp._();

  late Box _box;
  bool _status = false;

  @override
  Future<Map<String, dynamic>> getData(String key) async {
    final Map<String, dynamic> data = _box.get(key);
    return data;
  }

  @override
  Future<bool> initApi() async {
    !_status
        ? Hive.openBox('weather').then((value) {
            _box = value;
            _status = true;
          })
        : log('LocalstorageApiImp already initialized');
    return true;
  }

  @override
  Future<bool> saveData(String key, Map<String, dynamic> data) async {
    _box.put(key, data);
    return true;
  }
}
