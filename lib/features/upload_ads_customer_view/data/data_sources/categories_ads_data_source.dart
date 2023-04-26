import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/features/choose_service_view/data/models/services_model.dart';
import 'package:car_rental/features/home_view/data/models/categories_model.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/models/categories_ads_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;
import 'package:get/get.dart';

UploadAdsController uploadAdsController = Get.find();
categoriesAdsDataSource() async {
  uploadAdsController.getCategoriesData.value = CategoriesAdsModel();
  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_categories',
  );
  if (response != null) {
    uploadAdsController.getCategoriesData.value =
        CategoriesAdsModel.fromJson(response.data);
  } else {}
}
