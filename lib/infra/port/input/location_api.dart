abstract class LocationApi<T> {
  initAPI();
  T getCurrentLocation();
  T checkPermission();
  T requestLocationPermission();
}
