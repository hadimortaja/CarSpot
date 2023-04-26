import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/features/choose_service_view/data/models/services_model.dart';
import 'package:car_rental/features/home_view/data/models/categories_model.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;
import 'package:get/get.dart';

HomeController homeController = Get.find();
homeCategoriesDataSource() async {
  homeController.getCategoriesData.value = CategoriesModel();
  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_Categories',
  );
  if (response != null) {
    homeController.getCategoriesData.value =
        CategoriesModel.fromJson(response.data);
  } else {}
}
