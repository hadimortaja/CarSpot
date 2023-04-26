import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:car_rental/features/my_ads_view/data/data_sources/my_ads_data_source.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_profile_data_source.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_vendor_profile_data_source.dart';
import 'package:car_rental/features/welcome_after_login_view/presentation/views/welcome_after_login_view.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;

setProfileDataSource({
  String? name,
  String? email,
  String? description,
  String? address,
  String? phones,
}) async {
  // BotToast.showLoading();
  Helper.showLoading();
log({'name': name, 'email': email, 'description': description,
  'address':address,
  'phones':phones,
}.toString());
  dynamic response = await Apis.apis.post(
    'api/set_profile',
    formData: FormData.fromMap(
        {'name': name, 'email': email, 'description': description,
        'address':address,
        'phones':phones,
        }),
  );
  if (response != null) {
    myGet.Get.back();

    // BotToast.closeAllLoading();
    Helper.hideLoading();

    getProfileDataSource();
    getVendorProfileDataSource();
    BotToast.showText(text: "Data Updated");
  } else {
    Helper.hideLoading();
  }
}
