import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LocaleManager extends ChangeNotifier {
  Locale _locale = const Locale('en');
  LocaleList _localeName = LocaleList.englishUSA;

  LocaleManager() {
    if (Hive.box<String>('configs').containsKey('locale')) {
      final locale = Hive.box<String>('configs').get('locale');
      _locale = Locale(locale!);
    } else {
      final locales = WidgetsBinding.instance.window.locales;

      for (final locale in locales) {
        _locale = locale;

        if (locale.languageCode.split('_')[0] == 'uk') {
          Hive.box<String>('configs').put('locale', 'uk');
          Hive.box<String>('configs').put('localeName', 'ukraine');
          _locale = const Locale('uk');
          _localeName = LocaleList.ukraine;
        } else if (locale.languageCode.split('_')[0] == 'en') {
          Hive.box<String>('configs').put('locale', 'en');
          Hive.box<String>('configs').put('localeName', 'englishUSA');
          _locale = const Locale('en');
          _localeName = LocaleList.englishUSA;
        } else if (locale.languageCode.split('_')[0] == 'de') {
          Hive.box<String>('configs').put('locale', 'de');
          Hive.box<String>('configs').put('localeName', 'german');
          _locale = const Locale('ge');
          _localeName = LocaleList.german;
        } else if (locale.languageCode.split('_')[0] == 'ru') {
          Hive.box<String>('configs').put('locale', 'ru');
          Hive.box<String>('configs').put('localeName', 'russian');
          _locale = const Locale('ru');
          _localeName = LocaleList.russian;
          break;
        } else if (locale.languageCode.split('_')[0] == 'es') {
          Hive.box<String>('configs').put('locale', 'es');
          Hive.box<String>('configs').put('localeName', 'spanish');
          _locale = const Locale('es');
          _localeName = LocaleList.spanish;
        }

        break;
      }
    }
  }

  Locale get locale => _locale;

  LocaleList get localeName => _localeName;

  void setLocale(LocaleList locale) {
    switch (locale) {
      case LocaleList.russian:
        Hive.box<String>('configs').put('locale', 'ru');
        Hive.box<String>('configs').put('localeName', 'russian');
        _locale = const Locale('ru');
        _localeName = LocaleList.russian;
        break;
      case LocaleList.ukraine:
        Hive.box<String>('configs').put('locale', 'uk');
        Hive.box<String>('configs').put('localeName', 'ukraine');
        _locale = const Locale('uk');
        _localeName = LocaleList.ukraine;

        break;
      case LocaleList.spanish:
        Hive.box<String>('configs').put('locale', 'es');
        Hive.box<String>('configs').put('localeName', 'spanish');
        _locale = const Locale('es');
        _localeName = LocaleList.spanish;

        break;
      case LocaleList.englishUk:
        Hive.box<String>('configs').put('locale', 'en');
        Hive.box<String>('configs').put('localeName', 'englishUk');
        _locale = const Locale('en');
        _localeName = LocaleList.englishUk;

        break;
      case LocaleList.englishUSA:
        Hive.box<String>('configs').put('locale', 'en');
        Hive.box<String>('configs').put('localeName', 'englishUSA');
        _locale = const Locale('en');
        _localeName = LocaleList.englishUSA;

        break;
      case LocaleList.englishIndia:
        Hive.box<String>('configs').put('locale', 'en');
        Hive.box<String>('configs').put('localeName', 'englishIndia');
        _locale = const Locale('en');
        _localeName = LocaleList.englishIndia;

        break;
      case LocaleList.german:
        Hive.box<String>('configs').put('locale', 'de');
        Hive.box<String>('configs').put('localeName', 'german');
        _locale = const Locale('ge');
        _localeName = LocaleList.german;

        break;
    }
    notifyListeners();
  }
}

enum LocaleList { englishUk, englishUSA, englishIndia, ukraine, spanish, german, russian }
