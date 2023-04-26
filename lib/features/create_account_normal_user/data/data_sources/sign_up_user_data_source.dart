import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/services/notification_firebase.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/features/create_account_normal_user/data/data_sources/get_otp_data_source.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;

signUpUserDataSource(
    {String? username,
    String? email,
    String? password,
    String? password_confirmation}) async {
  String fcmToken =await NotificationHelper().getToken();

  Helper.showLoading();

  dynamic response = await Apis.apis.post(
    'api/register_user',
    formData: FormData.fromMap({
      'name': username,
      'username': username,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'fcm_token':fcmToken,

    }),
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
