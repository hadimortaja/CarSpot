import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:car_rental/features/my_ads_view/data/data_sources/my_ads_data_source.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_profile_data_source.dart';
import 'package:car_rental/features/welcome_after_login_view/presentation/views/welcome_after_login_view.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;

helpDataSource({
  String? name,
  String? email,
  String? phone,
  String? body,
}) async {
  // BotToast.showLoading();
  Helper.showLoading();

  dynamic response = await Apis.apis.post(
    'api/support',
    formData: FormData.fromMap(
        {'name': name, 'email': email, 'phone': phone, 'body': body}),
  );
  if (response != null) {
    BotToast.showText(text: "Message Sent");
    Helper.hideLoading();

    myGet.Get.back();
  } else {
    Helper.hideLoading();
  }
}
