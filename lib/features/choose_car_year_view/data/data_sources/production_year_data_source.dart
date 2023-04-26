import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/features/choose_brand_view/data/models/brands_model.dart';
import 'package:car_rental/features/choose_car_model_view.dart/data/models/car_models_model.dart';
import 'package:car_rental/features/choose_car_year_view/data/models/production_year_model.dart';
import 'package:get/get.dart';

UploadAdsController uploadAdsController = Get.find();
productionYearDataSource() async {
  uploadAdsController.getProductionYearData.value = ProductionYearsModel();
  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_years',
  );
  if (response != null) {
    uploadAdsController.getProductionYearData.value =
        ProductionYearsModel.fromJson(response.data);
  } else {}
}
