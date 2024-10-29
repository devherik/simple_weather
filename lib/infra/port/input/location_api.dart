abstract class LocationApi<T> {
  initAPI();
  T getCurrentLocation();
  T checkPermission();
  T getCurrentAddress();
  getUserLocations();
  setUserLocation(T newLocation);
  updateCurrentAddress(T newAddress);
  T requestLocationPermission();
}
