import 'package:simple_weather_app/infra/port/output/localstorage_api.dart';

class LocalstorageApiImp implements LocalstorageApi {
  LocalstorageApiImp._();
  static final LocalstorageApiImp instance = LocalstorageApiImp._();

  @override
  Future<Map<String, dynamic>> getData(String key) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<void> initApi() {
    // TODO: implement initApi
    throw UnimplementedError();
  }

  @override
  Future<void> saveData(String key, Map<String, dynamic> data) {
    // TODO: implement saveData
    throw UnimplementedError();
  }
}
