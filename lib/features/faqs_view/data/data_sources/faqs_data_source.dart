import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/value/colors.dart';
import 'package:car_rental/features/cars_view/data/models/products_by_category_model.dart';
import 'package:car_rental/features/cars_view/data/models/vendors_by_category_model.dart';
import 'package:car_rental/features/faqs_view/data/model/faqs_model.dart';
import 'package:car_rental/features/notification_view/data/models/notifications_model.dart';
import 'package:car_rental/features/search_view/data/models/search_model.dart';
import 'package:get/get.dart';

HomeController homeController = Get.find();
faqsDataSource() async {
  homeController.getFaqsData.value = FaqsModel();

  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_faqs',
  );
  if (response != null) {
    // homeController.getSearchData.value = SearchModel.fromJson(response.data);
    homeController.getFaqsData.value = FaqsModel.fromJson(response.data);
  } else {}
}
