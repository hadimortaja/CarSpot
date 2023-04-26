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

setWorkTimeDataSource({
  String? work_times,

}) async {
   Helper.showLoading();
  dynamic response = await Apis.apis.post(
    'api/set_work_time',
    formData: FormData.fromMap({
      'work_times': work_times,

    }),
  );
  if (response != null) {

myGet.Get.back();
BotToast.showText(text: response.data['message']);
    // BotToast.closeAllLoading();
    print(response.data);
    Helper.hideLoading();

   } else {
    Helper.hideLoading();
  }
}
