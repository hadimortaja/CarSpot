import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/services/notification_firebase.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/services/translations/en_us_translation.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/features/choose_country_view/data/data_souces/cities_data_source.dart';
import 'package:car_rental/features/create_account_normal_user/data/data_sources/get_otp_data_source.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;

signUpProviderDataSource({
  String? username,
  String? email,
  String? password,
  String? password_confirmation,
  String? serviceId,
  String? city_id,
  String? address,
  List? phoneNumber,
}) async {
  String fcmToken =await NotificationHelper().getToken();
  Helper.showLoading();
  log({
    "name": username,
    "service_id": serviceId,
    "city_id": city_id,
    "username": username,
    "email": email,
    "password": password,
    "password_confirmation": password_confirmation,
    "address": address,
    "fcm_token":fcmToken,


    // "phones": [
    //   {'\"phone\"': "123123123"},
    //   {'\"phone\"': "1223412344"},
    //   {'\"phone\"': "666666"}
    // ].toString(),
    "phones": phoneNumber.toString(),
    'passport': await MultipartFile.fromFile(authController.passport!.path,
        filename: authController.passport!.path),
    'license': await MultipartFile.fromFile(authController.linces!.path,
        filename: authController.linces!.path),
    'photo': await MultipartFile.fromFile(authController.passport!.path,
        filename: authController.passport!.path),
  }.toString());
  dynamic response = await Apis.apis.post(
    'api/register_vendor',
    formData: FormData.fromMap({
      "name": username,
      "service_id": serviceId,
      "city_id": city_id,
      "username": username,
      "email": email,
      "password": password,
      "password_confirmation": password_confirmation,
      "address": address,
      "fcm_token":fcmToken,

      // "phones": [
      //   {'\"phone\"': "123123123"},
      //   {'\"phone\"': "1223412344"},
      //   {'\"phone\"': "666666"}
      // ].toString(),
      "phones": phoneNumber.toString(),
      'passport': await MultipartFile.fromFile(authController.passport!.path,
          filename: authController.passport!.path),
      'license': await MultipartFile.fromFile(authController.linces!.path,
          filename: authController.linces!.path),
      'photo': await MultipartFile.fromFile(authController.passport!.path,
          filename: authController.passport!.path),
    }
        //   {
        //   'name': username,
        //   'service_id': serviceId,
        //   'city_id': city_id,
        //   'username': username,
        //   'email': email,
        //   'password': password,
        //   'password_confirmation': password_confirmation,
        //   'address': address,
        //   "phones": [
        //     {'\"phone\"': 123123123},
        //     {'\"phone\"': 1223412344},
        //     {'\"phone\"': 666666}
        //   ].toString(),
        //   'passport': await MultipartFile.fromFile(authController.passport!.path,
        //       filename: authController.passport!.path),
        //   'license': await MultipartFile.fromFile(authController.linces!.path,
        //       filename: authController.linces!.path),
        // }
        ),
  );
  if (response != null) {
    // log(response.data);
    await SPHelper.spHelper.setToken(response.data['object']['token']);
    await SPHelper.spHelper.setType(response.data['object']['type']);

    Helper.hideLoading();

    // myGet.Get.offAll(() => MainView());
    getOtpDataSource(email: email, isFirst: true);
  } else {
    Helper.hideLoading();
    // BotToast.closeAllLoading();
  }
}
