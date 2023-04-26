import 'dart:io';

import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/features/choose_country_view/data/model/cities_model.dart';
import 'package:car_rental/features/choose_service_view/data/models/services_model.dart';
import 'package:car_rental/features/home_view/data/models/banner_model.dart';
import 'package:car_rental/features/home_view/data/models/categories_model.dart';
import 'package:car_rental/features/home_view/data/models/most_popular_model.dart';
import 'package:car_rental/features/profile_view/data/models/profile_model.dart';
import 'package:car_rental/features/profile_view/data/models/vendor_profile_model.dart';
import 'package:car_rental/features/vendor_profile_view/data/models/vendor_profile_model.dart';
import 'package:car_rental/features/wishlist_view/data/models/wishlist_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  //Get Profile
  Rx<ProfileModel> getProfileData = ProfileModel().obs;
  Rx<VendorProfileModel> getVendorProfileData = VendorProfileModel().obs;
  Rx<WishlistModel> getWishlistData = WishlistModel().obs;

  RxList<Map<String,String>> phonesEdit = List<Map<String,String>>.empty().obs;
  RxList<Map<String,String>> phonesEdit2 = List<Map<String,String>>.empty().obs;

////without token
  Rx<VendorProfileModel1> getVendorProfileByIdData = VendorProfileModel1().obs;
  RxList<DataVendorProfile> allProfileList = List<DataVendorProfile>.empty().obs;

  File? profileImage;

  chooseImage(ImageSource imageSource) async {
    File? file = await Helper.imagePickerExample(imageSource);

    this.profileImage = file;
    Get.back();

    update(['image']);
  }

  cleanImage() {
    this.profileImage = null;
  }

 int indexSelectCalculator =-1.obs;
  setIndexSelectCalculator(int value){
    this.indexSelectCalculator =value;
    update();
  }

}
