import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/features/vendor_profile_view/data/models/vendor_profile_model.dart';
import 'package:get/get.dart' as myGet;
import 'package:get/get.dart';

ProfileController profileController = Get.find();
getVendorProfileDataSource(String id, int page, bool isFirst) async {
  isFirst
      ? profileController.getVendorProfileByIdData.value = VendorProfileModel1()
      : '';
  isFirst ? print('') : Helper.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_vendors_by_id/$id',
  );
  if (response != null) {
    profileController.getVendorProfileByIdData.value =
        VendorProfileModel1.fromJson(response.data);
    isFirst ? profileController.allProfileList.clear() : print('');
    profileController.allProfileList.addAll(
      VendorProfileModel1.fromJson(response.data).data!.advertisements!.data!,
    );
  } else {}
}
