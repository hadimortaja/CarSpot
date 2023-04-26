import 'dart:io';

import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/features/car_paint_color_view/data/models/colors_model.dart';
import 'package:car_rental/features/choose_brand_view/data/models/brands_model.dart';
import 'package:car_rental/features/choose_car_model_view.dart/data/models/car_models_model.dart';
import 'package:car_rental/features/choose_car_service_view/data/data_souces/cities_data_source.dart';
import 'package:car_rental/features/choose_car_year_view/data/models/production_year_model.dart';
import 'package:car_rental/features/choose_country_view/data/model/cities_model.dart';
import 'package:car_rental/features/choose_service_view/data/models/services_model.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/models/categories_ads_model.dart';
import 'package:car_rental/features/upload_truck_view/data/model/truck_brands_model.dart';
import 'package:car_rental/features/upload_truck_view/data/model/truck_models_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  UploadAdsController uploadAdsController = Get.find();
  int index = 0;
  File? passport;
  File? linces;

  chooseImage(int type, ImageSource imageSource) async {
    File? file = await Helper.imagePickerExample(imageSource);
    if (type == 0) {
      this.passport = file;
      Get.back();
    } else {
      this.linces = file;
      Get.back();
    }
    update(['image']);
  }

  cleanImage() {
    this.passport = null;
    this.linces = null;
  }

  setIndex(int value) {
    this.index = value;
    update();
  }

  int indexService = -1;

  setIndexService(int value) {
    this.indexService = value;
    update();
  }

  int indexCity = -1;

  setIndexCity(int value) {
    this.indexCity = value;
    update();
  }

  //Service
  Rx<ServicesModel> getServicesData = ServicesModel().obs;
  Rx<DataService> getServiceSelect = DataService().obs;

  // int? serviceId;

  // setServiceId(int value) {
  //   this.serviceId = value;
  //   update();
  // }

  //Cities
  Rx<CitiesModel> getCitiesData = CitiesModel().obs;
  Rx<DataCity> getCitiesSelect = DataCity().obs;

  //Brands
  Rx<BrandsModel> getBrandsData = BrandsModel().obs;
  Rx<DataBrand> getBrabdSelect = DataBrand().obs;
  RxList<DataBrand> searchData = List<DataBrand>.empty().obs;

  //Models
  Rx<CarModelsModel> getCarModelsData = CarModelsModel().obs;
  Rx<DataCarModel> getCarModelSelect = DataCarModel().obs;

  //Color
  Rx<ColorsModel> getPaintColorData = ColorsModel().obs;
  Rx<DataColors> getColorsSelect = DataColors().obs;
  //Brands Truck
  Rx<TruckBrandsModel> getTruckBrandsData = TruckBrandsModel().obs;
  Rx<DataTruckBrands> getTruckBrandsSelect = DataTruckBrands().obs;
  //Truck Model
  Rx<TruckModelsModel> getTruckModelsData = TruckModelsModel().obs;
  Rx<DataTruckModel> getTruckModelSelect = DataTruckModel().obs;

  cleanFilter() {
    getBrabdSelect.value = DataBrand();
    getCitiesSelect.value = DataCity();
    getTruckModelSelect.value = DataTruckModel();
    getTruckBrandsSelect.value = DataTruckBrands();
    getCarModelSelect.value = DataCarModel();
    getColorsSelect.value = DataColors();
    uploadAdsController.condition.value = "";
    uploadAdsController.year.value = "";
    uploadAdsController.vehicleType.value = "";
    uploadAdsController.numberType.value = "";
    uploadAdsController.simType.value = "";
    uploadAdsController.getProductionYearSelect.value = DataYear();
    uploadAdsController.setIndexCondition(-1);
    uploadAdsController.setIndexBrand(-1);
    uploadAdsController.setIndexColor(-1);
    uploadAdsController.setIndexModel(-1);
    uploadAdsController.setIndexTruckBrand(-1);
    uploadAdsController.setIndexTruckModel(-1);
    uploadAdsController.setIndexYear(-1);
    uploadAdsController.getCategoriesSelect1.value = DataCategoryAds();
    uploadAdsController.getCategoriesSelect2.value = DataCategoryAds();
  }
}
