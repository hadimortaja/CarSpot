import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/features/profile_view/data/models/profile_model.dart';
import 'package:car_rental/features/profile_view/data/models/vendor_profile_model.dart';
import 'package:get/get.dart';

ProfileController profileController = Get.find();
getVendorProfileDataSource() async {
  // profileController.getVendorProfileData.value = VendorProfileModel();
  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_vendor_profile',
  );
  if (response != null) {
    profileController.getVendorProfileData.value =
        VendorProfileModel.fromJson(response.data);
  } else {}
}
