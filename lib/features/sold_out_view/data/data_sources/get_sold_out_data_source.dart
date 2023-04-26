import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/features/profile_view/data/models/profile_model.dart';
import 'package:car_rental/features/sold_out_view/data/models/sold_out_model.dart';
import 'package:get/get.dart';

HomeController homeController = Get.find();
getSoldOutDataSource() async {
  homeController.getSoldOutData.value = SoldOutModel();
  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_sold_out',

  );
  if (response != null) {
    homeController.getSoldOutData.value =
        SoldOutModel.fromJson(response.data);
  } else {}
}
