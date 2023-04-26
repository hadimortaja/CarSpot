import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/features/car_ad_sale_view/data/models/product_by_id_model.dart';
import 'package:car_rental/features/choose_service_view/data/models/services_model.dart';
import 'package:car_rental/features/home_view/data/models/banner_model.dart';
import 'package:car_rental/features/home_view/data/models/categories_model.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:car_rental/features/update_car_view/presentation/widgets/upload_widget.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

HomeController homeController = Get.find();
UploadAdsController uploadAdsController = Get.find();

getProductById(String id) async {
  homeController.getProductByIdData.value = ProductByIDModel();
  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_product_by_id/$id',
  );
  if (response != null) {
    homeController.getProductByIdData.value =
        ProductByIDModel.fromJson(response.data);
    uploadAdsController.picturesUpdate.value=
    homeController.getProductByIdData.value.data!.pictures!;
  } else {}
}
