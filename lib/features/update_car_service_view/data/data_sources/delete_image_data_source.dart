import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/features/car_ad_sale_view/data/data_sources/get_product_by_id_data_source.dart';
import 'package:car_rental/features/choose_country_view/data/data_souces/cities_data_source.dart';
import 'package:car_rental/features/create_account_normal_user/data/data_sources/get_otp_data_source.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_profile_data_source.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_vendor_profile_data_source.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;

ProfileController profileController = myGet.Get.find();
deleteImageDataSource(String imageId,
    String productId
    ) async {
  Helper.showLoading();

  dynamic response = await Apis.apis.post(
    'api/ads_delete_image',
    formData: FormData.fromMap({
      'image_id':  imageId
    }),
  );
  if (response != null) {
    Helper.hideLoading();

 getProductById(productId);
  } else {
    Helper.hideLoading();
    // BotToast.closeAllLoading();
  }
}
