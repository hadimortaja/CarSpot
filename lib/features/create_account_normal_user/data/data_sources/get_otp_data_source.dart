import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/value/colors.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:car_rental/features/verify_code_view/presentation/views/verfication_code_view.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;

getOtpDataSource({
  String? email,
  bool? isFirst = false,
}) async {
  Helper.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_otp/$email',
  );
  if (response != null) {
    if (response.data['status'].toString() == "true") {
      isFirst == true
          ? myGet.Get.offAll(
              () => VerficationCodeView(
                code: response.data['data'].toString(),
                isFirst: isFirst!,
                email: email,
              ),
            )
          : myGet.Get.to(
              () => VerficationCodeView(
                code: response.data['data'].toString(),
                isFirst: isFirst!,
                email: email,
              ),
            );
    }
  } else {
    Helper.hideLoading();
    // BotToast.closeAllLoading();
  }
}
