import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/value/colors.dart';
import 'package:car_rental/features/cars_view/data/models/products_by_category_model.dart';
import 'package:car_rental/features/cars_view/data/models/vendors_by_category_model.dart';
import 'package:car_rental/features/notification_view/data/models/notifications_model.dart';
import 'package:car_rental/features/search_view/data/models/search_model.dart';
import 'package:get/get.dart';

HomeController homeController = Get.find();
notificationsDataSource(
  int page,
  bool isFirst,
) async {
  isFirst
      ? homeController.getNotificationsData.value = NotificationsModel()
      : '';
  isFirst ? print('') : Helper.showLoading();

  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_notifications?page=$page',
  );
  if (response != null) {
    // homeController.getSearchData.value = SearchModel.fromJson(response.data);
    homeController.getNotificationsData.value =
        NotificationsModel.fromJson(response.data);
    isFirst ? homeController.allNotificationsList.clear() : print('');
    homeController.allNotificationsList.addAll(
      NotificationsModel.fromJson(response.data).data!.data!,
    );
    print(homeController.allNotificationsList.length);
    isFirst ? print('') : Helper.hideLoading();
  } else {}
}
