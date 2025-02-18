import 'package:result_dart/result_dart.dart';
import 'package:simple_weather_app/data/data_sources/local/localstorage_api_imp.dart';
import 'package:simple_weather_app/infra/port/output/localstorage_api.dart';
import 'package:simple_weather_app/repositories_services/localstorage/localstorage_repository.dart';

class LocalstorageRepositoryImp implements LocalstorageRepository {
  late LocalstorageApi _localstorageApi;

  @override
  Future<Result<Map<String, dynamic>>> getData(String key) async {
    try {
      final Map<String, dynamic> data = await _localstorageApi.getData(key);
      return Success(data);
    } on Exception {
      return Failure(Exception('Error on getData'));
    }
  }

  @override
  Future<Result<bool>> init() async {
    try {
      _localstorageApi = LocalstorageApiImp.instance;
      LocalstorageApiImp.instance.initApi();
      return Success(true);
    } on Exception {
      return Failure(Exception('Error on initApi'));
    }
  }

  @override
  Future<Result<bool>> saveData(String key, Map<String, dynamic> data) async {
    try {
      await _localstorageApi.saveData(key, data);
      return Success(true);
    } on Exception {
      return Failure(Exception('Error on saveData'));
    }
  }
}
