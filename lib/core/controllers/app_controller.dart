import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/features/privacy_policy_view/data/models/settings_model.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  int indexScreen = 0;

  setIndexScreen(int value) {
    this.indexScreen = value;

    update(['indexScreen']);
  }

  int indexLanguage = 0;

  setIndexLanguage(int value) {
    this.indexLanguage = value;
    update();
  }

  int indexGender = 0;

  setIndexGender(
    int value,
  ) {
    this.indexGender = value;

    update();
  }

  late TabController controller;
  Rx<SettingsModel> getSettingsData = SettingsModel().obs;
}
