import 'dart:developer';
import 'dart:io';

import 'package:car_rental/features/choose_car_year_view/data/models/production_year_model.dart';
import 'package:car_rental/features/choose_country_view/data/model/cities_model.dart';
import 'package:car_rental/features/choose_service_view/data/models/services_model.dart';
import 'package:car_rental/features/my_ads_view/data/models/my_ads_model.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/models/categories_ads_model.dart';
import 'package:car_rental/features/upload_car_view/data/models/plan_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadAdsController extends GetxController {
  //ْUpload Car Stepper
  int indexStepper = 0;
  List<File>? imagesAds = [];
  RxList<Pictures> picturesUpdate = List<Pictures>.empty().obs;
  setIndexStepper(int value) {
    this.indexStepper = value;
    update();
  }

  //Brands
  int indexBrand = -1;

  setIndexBrand(int value) {
    this.indexBrand = value;
    update();
  }

  int indexTruckBrand = -1;

  setIndexTruckBrand(int value) {
    this.indexTruckBrand = value;
    update();
  }

  //Model
  int indexModel = -1;

  setIndexModel(int value) {
    this.indexModel = value;
    update();
  }

  //Model
  int indexTruckModel = -1;

  setIndexTruckModel(int value) {
    this.indexTruckModel = value;
    update();
  }

  //Car Condition
  int indexCondition = -1;

  setIndexCondition(int value) {
    this.indexCondition = value;
    update();
  }

  RxString condition = "".obs;
  RxString year = "".obs;
  RxString vehicleType = "".obs;

  int indexVehicleType = -1;
  RxString numberType = "".obs;
  RxString simType = "".obs;

  setIndexVehicleType(int value) {
    this.indexVehicleType = value;
     
    update();
  }

  //Car year
  int indexYear = -1;

  setIndexYear(int value) {
    this.indexYear = value;
    update();
  }

  //Car Paint Color
  int indexColor = -1;

  setIndexColor(int value) {
    this.indexColor = value;
    update();
  }

  //ْUpload Vehicle Number Stepper
  int indexVehicleNumberStepper = 0;

  setIndexVehicleNumberStepper(int value) {
    this.indexVehicleNumberStepper = value;
    update();
  }

  //ْIndex car Type
  int indexType = -1;

  setIndexType(int value) {
    this.indexType = value;
    update();
  }

  //ْIndex car Number type
  int indexNumberType = -1;

  setIndexNumberType(int value) {
    this.indexNumberType = value;
    update();
  }

  //ْUpload Mobile Number Stepper
  int indexMobileNumberStepper = 0;

  setIndexMobileNumberStepper(int value) {
    this.indexMobileNumberStepper = value;
    update();
  }

  //ْindexCarPartsStepper
  int indexCarPartsStepper = 0;

  setIndexCarPartsStepper(int value) {
    this.indexCarPartsStepper = value;
    update();
  }

  int indexCarServicesStepper = 0;

  setIndexCarServicesStepper(int value) {
    this.indexCarServicesStepper = value;
    update();
  }

  int indexSimType = 0;

  setIndexSimType(int value) {
    this.indexSimType = value;
    update();
  }

  //My Ads
  Rx<MyAdsModel> getMyAdsData = MyAdsModel().obs;
  RxList<DataAds> allAdsList = List<DataAds>.empty().obs;
  addMultiImageToPost() async {
    imagesAds!.clear();
    List<XFile>? images = await ImagePicker().pickMultiImage(imageQuality: 22);
    log('message $images');
    for (var i = 0; i < images.length; i++) {
      imagesAds!.add(File(images[i].path));
    }

    update();
  }

  //Upload Ads
  String? name;
  setName(String value) {
    this.name = value;
    update();
  }

  // RxString productionYear = "".obs;
  // setProductionYear(String value) {
  //   this.productionYear.value = value;
  //   update();
  // }

  String? Killometers;
  setKillometers(String value) {
    this.Killometers = value;
    update();
  }

  String? price;
  setPrice(String value) {
    this.price = value;
    update();
  }

  String? address;
  setAdress(String value) {
    this.address = value;
    update();
  }

  String? mobile;
  setMobile(String value) {
    this.mobile = value;
    update();
  }

  String? whatsapp;
  setWhatsapp(String value) {
    this.whatsapp = value;
    update();
  }

  String? desc;
  setDesc(String value) {
    this.desc = value;
    update();
  }

  //Categories
  Rx<CategoriesAdsModel> getCategoriesData = CategoriesAdsModel().obs;
  Rx<DataCategoryAds> getCategoriesSelect1 = DataCategoryAds().obs;
  Rx<DataCategoryAds> getCategoriesSelect2 = DataCategoryAds().obs;
  Rx<DataCategoryAds> getCategorySelect = DataCategoryAds().obs;
  Rx<PlansModel> getPlansData = PlansModel().obs;
  Rx<DataPlans> getPlansDataSelect = DataPlans().obs;
  Rx<ProductionYearsModel> getProductionYearData = ProductionYearsModel().obs;
  Rx<DataYear> getProductionYearSelect = DataYear().obs;

  RxInt indexDelete = 1.obs;
  setIndexDelete(int index) {
    this.indexDelete.value = index;
    update();
  }

  RxString indexvalue = "".obs;

  RxString indexSortValue = "".obs;
  RxInt indexSort = 1.obs;
  setIndexSort(int index) {
    this.indexSort.value = index;
    update();
  }

//ْUploadVechileNumber
  String? vNumber, codeV, mobileV, whatsV, descV, priceV;

  setvNumberV(String value) {
    this.vNumber = value;
  }

  setCodeV(String value) {
    this.codeV = value;
  }

  setMobileV(String value) {
    this.mobileV = value;
  }

  setWhatsV(String value) {
    this.whatsV = value;
  }

  setDescV(String value) {
    this.descV = value;
  }

  setPriceV(String value) {
    this.priceV = value;
  }

  //UploadMobileNumber
  String? mobileM, priceM, phoneM, whatsappM, descM;

  setMobileM(String value) {
    this.mobileM = value;
  }

  setPriceM(String value) {
    this.priceM = value;
  }

  setPhoneM(String value) {
    this.phoneM = value;
  }

  setWhatsM(String value) {
    this.whatsappM = value;
  }

  setDescM(String value) {
    this.descM = value;
  }

  //UploadCarForrent
  String? DailyPrice;
  setDailyprice(String value) {
    this.DailyPrice = value;
  }

  String? Monthlyprice;
  setMonthlyprice(String value) {
    this.Monthlyprice = value;
  }

  String? Yearlyprice;
  setYearlypricee(String value) {
    this.Yearlyprice = value;
  }

  //UploadCarService
  String? nameS, descS;

  setNameS(String value) {
    this.nameS = value;
  }

  setDescS(String value) {
    this.descS = value;
  }

  //UploadCarParts
  String? mobileCarParts, whatsappCarParts, descCarParts;
  setmobileCarParts(String value) {
    this.mobileCarParts = value;
  }

  setwhatsappCarParts(String value) {
    this.whatsappCarParts = value;
  }

  setdescCarParts(String value) {
    this.descCarParts = value;
  }
}
