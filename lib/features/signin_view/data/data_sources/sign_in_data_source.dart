import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/services/notification_firebase.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:car_rental/features/my_ads_view/data/data_sources/my_ads_data_source.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_profile_data_source.dart';
import 'package:car_rental/features/welcome_after_login_view/presentation/views/welcome_after_login_view.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;

signInDataSource({
  String? email,
  String? password,
}) async {
  String fcmToken =await NotificationHelper().getToken();
  // BotToast.showLoading();
  Helper.showLoading();
  dynamic response = await Apis.apis.post(
    'api/login',
    formData: FormData.fromMap({
      'email': email,
      'password': password,
      'fcm_token':fcmToken,
    }),
  );
  if (response != null) {
    await SPHelper.spHelper.setToken(response.data['object']['token']);
    await SPHelper.spHelper.setType(response.data['object']['type']);

    // BotToast.closeAllLoading();
    Helper.hideLoading();
    getProfileDataSource();
    myAdsDataSource(1, true);
    myGet.Get.offAll(() => WelcomeAfterLoginView());
  } else {
    Helper.hideLoading();
  }
}
