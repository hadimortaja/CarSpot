import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/value/colors.dart';
import 'package:car_rental/features/my_ads_view/data/models/my_ads_model.dart';
import 'package:car_rental/features/search_view/data/models/search_model.dart';
import 'package:get/get.dart';

UploadAdsController uploadAdsController = Get.find();
myAdsDataSource(int page, bool isFirst) async {
  isFirst ? uploadAdsController.getMyAdsData.value = MyAdsModel() : '';
  isFirst ? print('') : Helper.showLoading();

  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_my_adverisement?page=$page',
  );
  if (response != null) {
    // homeController.getSearchData.value = SearchModel.fromJson(response.data);
    uploadAdsController.getMyAdsData.value = MyAdsModel.fromJson(response.data);
    isFirst ? uploadAdsController.allAdsList.clear() : print('');
    uploadAdsController.allAdsList.addAll(
      MyAdsModel.fromJson(response.data).data!.data!,
    );
    print(uploadAdsController.allAdsList.length);
    isFirst ? print('') : Helper.hideLoading();
  } else {}
}
