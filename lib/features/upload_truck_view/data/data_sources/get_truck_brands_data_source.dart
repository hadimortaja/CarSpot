import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/features/choose_brand_view/data/models/brands_model.dart';
import 'package:car_rental/features/upload_truck_view/data/model/truck_brands_model.dart';
import 'package:get/get.dart';

AuthController authController = Get.find();
getTruckBrandsDataSource() async {
  authController.getTruckBrandsData.value = TruckBrandsModel();
  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_truck_brands',
  );
  if (response != null) {
    authController.getTruckBrandsData.value =
        TruckBrandsModel.fromJson(response.data);
  } else {}
}
