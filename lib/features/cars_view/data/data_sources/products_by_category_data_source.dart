import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/value/colors.dart';
import 'package:car_rental/features/cars_view/data/models/products_by_category_model.dart';
import 'package:car_rental/features/search_view/data/models/search_model.dart';
import 'package:get/get.dart';

HomeController homeController = Get.find();
getProductsByCategoryDataSource(int page, bool isFirst, String id,
    {String? brand = "",
    String? city = "",
    String? model = "",
    String? year = "",
    String? from_price = "",
    String? to_price = "",
    String? condition = "",
    String? sim_type = "",
    String? sort = "",
    String? sortMethod = "",
    String? number_type = "",
    String? vehicle_type = ""}) async {
  isFirst
      ? homeController.getProductsData.value = ProductsByCategoryModel()
      : '';
  isFirst ? print('') : Helper.showLoading();

  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
      'api/get_products_by_category/$id?page=$page&brand_id=$brand&city_id=$city&model_id=$model&production_year=$year&from_price=$from_price&to_price=$to_price&condition=$condition&sim_type=$sim_type&sort=$sort&sort_method=$sortMethod&number_type=$number_type&vehicle_type=$vehicle_type');
  if (response != null) {
    // homeController.getSearchData.value = SearchModel.fromJson(response.data);
    homeController.getProductsData.value =
        ProductsByCategoryModel.fromJson(response.data);
    isFirst ? homeController.allProductsList.clear() : print('');
    homeController.allProductsList.addAll(
      ProductsByCategoryModel.fromJson(response.data).data!.data!,
    );
    print(homeController.allProductsList.length);
    isFirst ? print('') : Helper.hideLoading();
  } else {}
}
