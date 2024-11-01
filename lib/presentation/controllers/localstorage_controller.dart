import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class LocalstorageController {
  LocalstorageController._privateConstructor();
  static final instance = LocalstorageController._privateConstructor();

  var userAddresses$ = ValueNotifier<List<String>>([]);

  initController() async {
    await initLocalStorage().whenComplete(
      () {
        localStorage.setItem('LOCATION_0', 'Timóteo');
        localStorage.setItem('LOCATION_1', 'Santana do Paraíso');
        localStorage.setItem('LOCATION_2', 'Belo Horizonte');
        restoreUserLocations();
      },
    );
  }

  restoreUserLocations() {
    int index = 0;
    while (localStorage.getItem('LOCATION_$index') != null && index < 3) {
      userAddresses$.value.add(localStorage.getItem('LOCATION_$index') ?? '');
      index++;
    }
  }

  updateUserLocations() {
    int index = 0;
    for (var location in userAddresses$.value) {
      localStorage.setItem('LOCATION_$index', location);
      index++;
    }
  }

  addLocation(String name) {
    userAddresses$.value.length < 3
        ? userAddresses$.value.add(name)
        : throw 'List is full';
    updateUserLocations();
  }

  removeUserLocation(String name) {
    userAddresses$.value.removeWhere((element) => element == name);
    updateUserLocations();
  }
}
