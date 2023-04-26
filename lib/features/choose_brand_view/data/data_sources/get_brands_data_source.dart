import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/features/choose_brand_view/data/models/brands_model.dart';
import 'package:get/get.dart';

AuthController authController = Get.find();
getBrandsDataSource() async {
  authController.getBrandsData.value = BrandsModel();
  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_brands',
  );
  if (response != null) {
    authController.getBrandsData.value = BrandsModel.fromJson(response.data);
  } else {}
}
