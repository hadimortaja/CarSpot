import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/features/choose_brand_view/data/models/brands_model.dart';
import 'package:car_rental/features/choose_car_model_view.dart/data/models/car_models_model.dart';
import 'package:car_rental/features/upload_truck_view/data/model/truck_models_model.dart';
import 'package:get/get.dart';

AuthController authController = Get.find();
getTruckModelDataSource(String id) async {
  authController.getTruckModelsData.value = TruckModelsModel();
  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_truck_models/$id',
  );
  if (response != null) {
    authController.getTruckModelsData.value =
        TruckModelsModel.fromJson(response.data);
  } else {}
}
