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
  bool _status = false;

  Future<bool> init() async {
    if (!_status) {
      _localstorageRepository = LocalstorageRepositoryImp.instance;
      await _localstorageRepository.init();
      await _localstorageRepository
          .getData('appPreferences')
          .onSuccess(
              (success) => value = AppPreferencesEntity.fromJson(success))
          .onFailure((failure) => _localstorageRepository.saveData(
              'appPreferences', AppPreferencesEntity.empty().toJson()));
      _status = true;
    } else {
      log('Localstorage viewmodel already initialized');
    }
    return _status;
  }

  Future<void> clearPreferences() async {
    //await _localstorageRepository.clearData('appPreferences');
  }

  Future<void> savePreferences() async {
    await _localstorageRepository.saveData('appPreferences', value.toJson());
  }

  Future<void> end() async => _status = false;
}
