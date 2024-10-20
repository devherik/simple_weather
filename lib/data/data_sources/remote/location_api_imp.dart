import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:simple_weather_app/infra/port/input/location_api.dart';

class LocationApiImp implements LocationApi {
  LocationApiImp._privateConstructor();
  static final LocationApiImp instance = LocationApiImp._privateConstructor();

  Position? _currentPosition;
  bool _servicePermission = false;
  GeolocatorPlatform? _geolocatorPlatform;
  LocationPermission? _permission;
  String currentAddress = 'Timóteo';

  @override
  getCurrentLocation() async {
    return _currentPosition;
  }

  @override
  initAPI() async {
    _geolocatorPlatform = GeolocatorPlatform.instance;
    _servicePermission = await _geolocatorPlatform!.isLocationServiceEnabled();
    if (!_servicePermission) {
      log('Service disabled');
      throw 'Service disabled';
    }
    _permission = await _geolocatorPlatform!.checkPermission();
    if (await checkPermission()) {
      await requestLocationPermission();
    } else {
      if (_permission == LocationPermission.whileInUse) {
        _currentPosition = await _geolocatorPlatform!.getCurrentPosition();
        // _currentAddress
      } else {
        throw 'Permission denied';
      }
    }
    return _currentPosition;
  }

  @override
  requestLocationPermission() async {
    _permission = await _geolocatorPlatform!.requestPermission();
    if (_permission == LocationPermission.whileInUse) {
      _currentPosition = await _geolocatorPlatform!.getCurrentPosition();
      // _currentAddress
    } else {
      throw 'Permission denied';
    }
  }

  @override
  checkPermission() async {
    if (_permission == LocationPermission.denied) {
      return false;
    } else {
      return true;
    }
  }

  @override
  String getCurrentAddress() => currentAddress;
}
