import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/features/choose_country_view/data/model/cities_model.dart';
import 'package:car_rental/features/choose_service_view/data/models/services_model.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;
import 'package:get/get.dart';

AuthController authController = Get.find();
citiesDataSource() async {
  authController.getCitiesData.value = CitiesModel();
  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_cities',
  );
  if (response != null) {
    print(response.data);
    authController.getCitiesData.value = CitiesModel.fromJson(response.data);
  } else {}
}
