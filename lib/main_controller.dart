import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:localstorage/localstorage.dart';
import 'package:simple_weather_app/data/data_sources/remote/location_api_imp.dart';
import 'package:simple_weather_app/infra/port/input/location_api.dart';

class MainController {
  // a controller to start the application apis, plugins, themes etc
  MainController._privateConstructor();
  static final MainController instance = MainController._privateConstructor();

  final LocationApi _locationApi = LocationApiImp.instance;

  initController() async {
    await initLocalStorage();
    await _locationApi.initAPI();
    await dotenv.load(fileName: '.env');
  }
}
