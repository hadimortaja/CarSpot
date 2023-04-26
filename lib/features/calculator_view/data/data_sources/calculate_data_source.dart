import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/services/translations/en_us_translation.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/features/calculator_view/data/models/calculate_model.dart';
import 'package:car_rental/features/choose_country_view/data/data_souces/cities_data_source.dart';
import 'package:car_rental/features/create_account_normal_user/data/data_sources/get_otp_data_source.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:car_rental/features/my_ads_view/data/data_sources/my_ads_data_source.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;

HomeController homeController = myGet.Get.find();
calculateDataSource({
  String? price,
  String? years,
  String? rate,
  String? prepaid,
}) async {
  Helper.showLoading();

  dynamic response = await Apis.apis.post(
    'api/calculate',
    formData: FormData.fromMap({"price": price, 'rate': rate, 'years': years,
    'prepaid':prepaid
    }),
  );
  if (response != null) {
    Helper.hideLoading();

    homeController.getCalculateData.value =
        CalculateModel.fromJson(response.data);
  } else {
    Helper.hideLoading();
  }
}
