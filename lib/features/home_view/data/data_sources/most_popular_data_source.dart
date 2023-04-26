import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/features/choose_service_view/data/models/services_model.dart';
import 'package:car_rental/features/home_view/data/models/categories_model.dart';
import 'package:car_rental/features/home_view/data/models/most_popular_model.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:get/get.dart' as myGet;
import 'package:get/get.dart';

HomeController homeController = Get.find();
homeMostPopularDataSource({String? city = ""}) async {
  homeController.getMostPopularData.value = MostPopularModel();
  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    SPHelper.spHelper.getToken() != ''
        ? 'api/get_most_pobular?city=$city'
        : 'api/get_most_pobular_guest?city=$city',
  );
  if (response != null) {
    homeController.getMostPopularData.value =
        MostPopularModel.fromJson(response.data);
  } else {}
}
