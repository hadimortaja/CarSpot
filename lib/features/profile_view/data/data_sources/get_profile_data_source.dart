import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/features/profile_view/data/models/profile_model.dart';
import 'package:get/get.dart';

ProfileController profileController = Get.find();
getProfileDataSource() async {
  // homeController.getHomeBanners.value = BannerModel();
  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_profile',
    
  );
  if (response != null) {
    profileController.getProfileData.value =
        ProfileModel.fromJson(response.data);
  } else {}
}
