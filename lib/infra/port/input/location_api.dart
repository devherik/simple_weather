abstract class LocationApi<T> {
  Future<void> initApi();
  Future<T> getCurrentLocation();
  Future<T> checkPermission();
  Future<T> requestLocationPermission();
}
