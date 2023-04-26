import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/value/colors.dart';
import 'package:car_rental/features/search_view/data/models/search_model.dart';
import 'package:get/get.dart';

HomeController homeController = Get.find();
searchDataSource(String data, int page, bool isFirst) async {
  isFirst ? homeController.getSearchData.value = SearchModel() : '';
  isFirst ? print('') : Helper.showLoading();

  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_filter?search=$data&page=$page',
  );
  if (response != null) {
    // homeController.getSearchData.value = SearchModel.fromJson(response.data);
    homeController.getSearchData.value = SearchModel.fromJson(response.data);
    isFirst ? homeController.allSearchList.clear() : print('');
    homeController.allSearchList.addAll(
      SearchModel.fromJson(response.data).filters!.data!,
    );
    print(homeController.allSearchList.length);
    isFirst ? print('') : Helper.hideLoading();
  } else {}
}
