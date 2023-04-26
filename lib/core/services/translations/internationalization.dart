import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/services/translations/ar_ar_translation.dart';
import 'package:car_rental/core/services/translations/en_us_translation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternationalizationMessages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUs,
        'ar_AR': arAR,
      };
}

class InternationalizationService {
  // default language

  // supported languages
  static Map<String, Locale> supportedLanguages = {
    'en': const Locale('en', 'US'),
    'ar': const Locale('ar', 'AR'),
  };

  /// update app language by code language for example (en,ar..etc)
  static updateLanguage(String languageCode) async {
    // update current language in shared pref
    SPHelper.spHelper.setLanguage(languageCode);

    await Get.updateLocale(supportedLanguages[languageCode]!);
  }

  /// check if the language is english
  static bool isItEnglish() => SPHelper.spHelper.getLanguage() == 'en';

  /// get current locale
  static Locale getCurrentLocal() =>
      Locale(SPHelper.spHelper.getLanguage() ?? 'en');
}
