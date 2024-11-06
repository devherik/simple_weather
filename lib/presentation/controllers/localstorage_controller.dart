import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class LocalstorageController {
  LocalstorageController._privateConstructor();
  static final instance = LocalstorageController._privateConstructor();

  var userLocations$ = ValueNotifier<List<String>>([]);

  initController() async {
    await initLocalStorage().whenComplete(
      () {
        localStorage.setItem('LOCATION_0', 'Timóteo');
        localStorage.setItem('LOCATION_1', 'Santana do Paraíso');
        localStorage.setItem('LOCATION_2', 'Belo Horizonte');
        localStorage.setItem('MAIN_LOCATION', 'Timóteo');
        restoreUserLocations();
      },
    );
  }

  String getMainLocation() {
    if (localStorage.getItem('MAIN_LOCATION') != null) {
      return localStorage.getItem('MAIN_LOCATION')!;
    } else {
      return '';
    }
  }

  setMainLocation(String value) => localStorage.setItem('MAIN_LOCATION', value);

  restoreUserLocations() {
    int index = 0;
    while (localStorage.getItem('LOCATION_$index') != null && index < 3) {
      userLocations$.value.add(localStorage.getItem('LOCATION_$index') ?? '');
      index++;
    }
  }

  updateUserLocations() {
    int index = 0;
    for (var location in userLocations$.value) {
      localStorage.setItem('LOCATION_$index', location);
      index++;
    }
  }

  addLocation(String name) {
    userLocations$.value.length < 3
        ? userLocations$.value.add(name)
        : throw 'List is full';
    updateUserLocations();
  }

  removeUserLocation(String name) {
    userLocations$.value.removeWhere((element) => element == name);
    updateUserLocations();
  }
}
