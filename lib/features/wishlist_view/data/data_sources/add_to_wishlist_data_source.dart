import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:car_rental/features/my_ads_view/data/data_sources/my_ads_data_source.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_profile_data_source.dart';
import 'package:car_rental/features/welcome_after_login_view/presentation/views/welcome_after_login_view.dart';
import 'package:car_rental/features/wishlist_view/data/data_sources/wishlist_data_source.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;

addToWishlistDataSource({
  String? product_id,
}) async {
  // BotToast.showLoading();
  // Helper.showLoading();

  dynamic response = await Apis.apis.post(
    'api/add_to_wishlist',
    formData: FormData.fromMap({
      'product_id': product_id,
    }),
  );
  if (response != null) {
    // BotToast.closeAllLoading();
    // Helper.hideLoading();
    getWishlistDataSource();
  } else {
    Helper.hideLoading();
  }
}
