import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:simple_weather_app/model/app_preferences_entity.dart';
import 'package:simple_weather_app/repositories_services/localstorage/localstorage_repository.dart';
import 'package:simple_weather_app/repositories_services/localstorage/localstorage_repository_imp.dart';

class LocalstorageViewmodel extends ValueNotifier<AppPreferencesEntity> {
  LocalstorageViewmodel._(super._value);
  static final instance = LocalstorageViewmodel._(AppPreferencesEntity.empty());

  late LocalstorageRepository _localstorageRepository;

  Map<String, String> lastLocation = {'latitude': '', 'longitude': ''};

  Future<void> initController() async {
    _localstorageRepository = LocalstorageRepositoryImp();
    await _localstorageRepository.init().whenComplete(() async {
      await _localstorageRepository
          .getData('appPreferences')
          .onSuccess(
              (success) => value = AppPreferencesEntity.fromJson(success))
          .onFailure((failure) => log(failure.toString()));
    });
  }
}
