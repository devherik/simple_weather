import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:localstorage/localstorage.dart';
import 'package:simple_weather_app/infra/port/input/location_api.dart';

class LocationApiImp implements LocationApi {
  LocationApiImp._privateConstructor();
  static final LocationApiImp instance = LocationApiImp._privateConstructor();

  Position? _currentPosition;
  bool _servicePermission = false;
  GeolocatorPlatform? _geolocatorPlatform;
  LocationPermission? _permission;
  String currentAddress = '';

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
    if (await checkPermission() == false) {
      await requestLocationPermission();
      if (_permission == LocationPermission.whileInUse ||
          _permission == LocationPermission.always) {
        _currentPosition = await _geolocatorPlatform!.getCurrentPosition(
            locationSettings:
                const LocationSettings(accuracy: LocationAccuracy.high));
        currentAddress = localStorage.getItem('PRIMARY_LOCATION') ?? '';
        currentAddress == ''
            ? await placemarkFromCoordinates(
                    _currentPosition!.latitude, _currentPosition!.longitude)
                .then((List<Placemark> places) {
                Placemark place = places[0];
                currentAddress = place.administrativeArea!;
              })
            : null;
      } else {
        throw 'Permission denied';
      }
    } else {
      if (_permission == LocationPermission.whileInUse ||
          _permission == LocationPermission.always) {
        _currentPosition = await _geolocatorPlatform!.getCurrentPosition(
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
      _currentPosition = await _geolocatorPlatform!.getCurrentPosition(
          locationSettings:
              const LocationSettings(accuracy: LocationAccuracy.best));
      return _currentPosition;
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

  @override
  updateCurrentAddress(newAddress) => currentAddress = newAddress;
}
