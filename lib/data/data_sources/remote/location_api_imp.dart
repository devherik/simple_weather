import 'package:geolocator/geolocator.dart';
import 'package:simple_weather_app/infra/port/input/location_api.dart';

class LocationApiImp implements LocationApi {
  LocationApiImp();
  GeolocatorPlatform? _geolocatorPlatform;
  @override
  getCurrentLocation() async {
    return _geolocatorPlatform!.getCurrentPosition();
  }

  @override
  initAPI() {
    _geolocatorPlatform = GeolocatorPlatform.instance;
  }
}
