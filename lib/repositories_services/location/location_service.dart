import 'package:geocoding/geocoding.dart';
import 'package:result_dart/result_dart.dart';

abstract class LocationService {
  Future<Result<bool>> initApi();
  Future<Result<Location>> getCurrentLocation();
  Future<Result<bool>> requestLocationPermission();
  Future<Result<bool>> hasLocationPermission();
}
