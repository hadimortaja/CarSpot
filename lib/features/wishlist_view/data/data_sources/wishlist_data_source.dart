import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/features/choose_service_view/data/models/services_model.dart';
import 'package:car_rental/features/home_view/data/models/categories_model.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/models/categories_ads_model.dart';
import 'package:car_rental/features/wishlist_view/data/models/wishlist_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;
import 'package:get/get.dart';

ProfileController profileController = Get.find();
getWishlistDataSource() async {
  profileController.getWishlistData.value = WishlistModel();
  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_wishlist',
  );
  if (response != null) {
    profileController.getWishlistData.value =
        WishlistModel.fromJson(response.data);
  } else {}
}
