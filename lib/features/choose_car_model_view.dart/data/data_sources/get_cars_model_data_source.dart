import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/features/choose_brand_view/data/models/brands_model.dart';
import 'package:car_rental/features/choose_car_model_view.dart/data/models/car_models_model.dart';
import 'package:get/get.dart';

AuthController authController = Get.find();
getCarsModelDataSource(String id) async {
  authController.getCarModelsData.value = CarModelsModel();
  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_models/$id',
  );
  if (response != null) {
    authController.getCarModelsData.value =
        CarModelsModel.fromJson(response.data);
  } else {}
}
