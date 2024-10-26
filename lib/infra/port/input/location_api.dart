abstract class LocationApi<T> {
  initAPI();
  T getCurrentLocation();
  T checkPermission();
  T getCurrentAddress();
  updateCurrentAddress(T newAddress);
  T requestLocationPermission();
}
