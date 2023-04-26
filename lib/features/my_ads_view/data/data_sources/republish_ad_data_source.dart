import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/features/choose_country_view/data/data_souces/cities_data_source.dart';
import 'package:car_rental/features/create_account_normal_user/data/data_sources/get_otp_data_source.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:car_rental/features/my_ads_view/data/data_sources/my_ads_data_source.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_profile_data_source.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_vendor_profile_data_source.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;

republishProductDataSource(String id) async {
  Helper.showLoading();

  dynamic response = await Apis.apis.post(
    'api/republish_product',
    formData: FormData.fromMap({"product_id": id}),
  );
  if (response != null) {
    Helper.hideLoading();
    print(response.data);
    BotToast.showText(text: response.data['message']);
    // myGet.Get.offAll(() => MainView());
    // getProfileDataSource();
    // myAdsDataSource(1, true);
  } else {
    Helper.hideLoading();
    // BotToast.closeAllLoading();
  }
}
