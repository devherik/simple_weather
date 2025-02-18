import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:result_dart/result_dart.dart';
import 'package:simple_weather_app/repositories_services/location/location_service.dart';

class LocationServiceImp implements LocationService {
  late GeocodingPlatform _geocodingPlatform;
  late LocationPermission _locationPermission;
  late Location currentPosition;
  late String address;

  @override
  Future<Result<Location>> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      final location = await _geocodingPlatform.placemarkFromCoordinates(
          position.latitude, position.longitude);
      currentPosition = Location(
          latitude: position.latitude,
          longitude: position.longitude,
          timestamp: position.timestamp);
      address = location.first.name!;
      return Success(currentPosition);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<bool>> hasLocationPermission() async {
    try {
      _locationPermission = await Geolocator.checkPermission();
      if (_locationPermission == LocationPermission.denied) {
        return Success(false);
      }
      return Success(true);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<bool>> initApi() async {
    try {
      _geocodingPlatform = GeocodingPlatform.instance!;
      _locationPermission = await Geolocator.checkPermission();
      if (_locationPermission == LocationPermission.denied) {
        await Geolocator.requestPermission();
        _locationPermission = await Geolocator.checkPermission();
        if (_locationPermission == LocationPermission.denied) {
          return Success(false);
        }
      }
      return Success(true);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<bool>> requestLocationPermission() async {
    try {
      await Geolocator.requestPermission();
      _locationPermission = await Geolocator.checkPermission();
      if (_locationPermission == LocationPermission.denied) {
        return Success(false);
      } else {
        return Success(true);
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
