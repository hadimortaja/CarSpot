import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/features/profile_view/data/models/profile_model.dart';
import 'package:car_rental/features/upload_car_view/data/models/plan_model.dart';
import 'package:get/get.dart';

UploadAdsController uploadAdsController = Get.find();
choosePlanDataSource() async {
  uploadAdsController.getPlansData.value = PlansModel();
  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_plans',
  );
  if (response != null) {
    uploadAdsController.getPlansData.value = PlansModel.fromJson(response.data);
  } else {}
}
