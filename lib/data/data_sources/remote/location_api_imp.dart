import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:simple_weather_app/infra/port/input/location_api.dart';

class LocationApiImp implements LocationApi {
  LocationApiImp._privateConstructor();
  static final LocationApiImp instance = LocationApiImp._privateConstructor();

  late Position currentPosition;
  bool _status = false;

  bool _servicePermission = false;
  GeolocatorPlatform? _geolocatorPlatform;
  LocationPermission? _permission;

  @override
  getCurrentLocation() async {
    currentPosition = await _geolocatorPlatform!.getCurrentPosition();
    return currentPosition;
  }

  @override
  initApi() async {
    _geolocatorPlatform = GeolocatorPlatform.instance;
    _servicePermission = await _geolocatorPlatform!.isLocationServiceEnabled();
    if (!_servicePermission) {
      log('Service disabled');
      throw 'Service disabled';
    }
    _permission = await _geolocatorPlatform!.checkPermission();
    if (await checkPermission() == false) {
      await requestLocationPermission();
      if (_permission == LocationPermission.whileInUse ||
          _permission == LocationPermission.always) {
        currentPosition = await _geolocatorPlatform!.getCurrentPosition(
            locationSettings:
                const LocationSettings(accuracy: LocationAccuracy.best));
      } else {
        throw 'Permission denied';
      }
    } else {
      if (_permission == LocationPermission.whileInUse ||
          _permission == LocationPermission.always) {
        currentPosition = await _geolocatorPlatform!.getCurrentPosition(
            locationSettings:
                const LocationSettings(accuracy: LocationAccuracy.best));
        // _currentAddress
      } else {
        throw 'Permission denied';
      }
    }
  }

  @override
  requestLocationPermission() async {
    _permission = await _geolocatorPlatform!.requestPermission();
    if (_permission == LocationPermission.whileInUse ||
        _permission == LocationPermission.always) {
      currentPosition = await _geolocatorPlatform!.getCurrentPosition(
          locationSettings:
              const LocationSettings(accuracy: LocationAccuracy.best));
      return currentPosition;
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
}
