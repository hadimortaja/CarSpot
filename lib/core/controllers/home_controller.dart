import 'package:car_rental/features/calculator_view/data/models/calculate_model.dart';
import 'package:car_rental/features/car_ad_sale_view/data/models/product_by_id_model.dart';
import 'package:car_rental/features/cars_view/data/models/products_by_category_model.dart';
import 'package:car_rental/features/cars_view/data/models/vendors_by_category_model.dart';
import 'package:car_rental/features/choose_country_view/data/model/cities_model.dart';
import 'package:car_rental/features/choose_service_view/data/models/services_model.dart';
import 'package:car_rental/features/faqs_view/data/model/faqs_model.dart';
import 'package:car_rental/features/home_view/data/models/banner_model.dart';
import 'package:car_rental/features/home_view/data/models/categories_model.dart';
import 'package:car_rental/features/home_view/data/models/most_popular_model.dart';
import 'package:car_rental/features/notification_view/data/models/notifications_model.dart';
import 'package:car_rental/features/search_view/data/models/search_model.dart';
import 'package:car_rental/features/sold_out_view/data/models/sold_out_model.dart';
import 'package:car_rental/features/sold_out_view/presentation/views/sold_out_view.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //Categories
  Rx<CategoriesModel> getCategoriesData = CategoriesModel().obs;

  //Most Popular
  Rx<MostPopularModel> getMostPopularData = MostPopularModel().obs;
  Rx<BannerModel> getHomeBanners = BannerModel().obs;

  String countryValue = "All";

  //Search
  Rx<SearchModel> getSearchData = SearchModel().obs;
  RxList<DataSearch> allSearchList = List<DataSearch>.empty().obs;

//Product By Id
  Rx<ProductByIDModel> getProductByIdData = ProductByIDModel().obs;

  //Products By Category
  Rx<ProductsByCategoryModel> getProductsData = ProductsByCategoryModel().obs;
  RxList<DataProducts> allProductsList = List<DataProducts>.empty().obs;

  //Bendors By Category
  Rx<VendorsByCategoryModel> getVendorsData = VendorsByCategoryModel().obs;
  RxList<DataVendors> allVendorsList = List<DataVendors>.empty().obs;
  //Bendors By Category
  Rx<NotificationsModel> getNotificationsData = NotificationsModel().obs;
  RxList<DataNotifications> allNotificationsList =
      List<DataNotifications>.empty().obs;

  //Faqs
  Rx<FaqsModel> getFaqsData = FaqsModel().obs;
  Rx<CalculateModel> getCalculateData = CalculateModel().obs;
  Rx<SoldOutModel> getSoldOutData = SoldOutModel().obs;


  RxInt indexCity = (-1).obs;
  setIndexCity(int index) {
    this.indexCity.value = index;
    update();
  }
  RxInt indexNumber = (-1).obs;
  setIndexNumber(int index) {
    this.indexNumber.value = index;
    update();
  }
}
