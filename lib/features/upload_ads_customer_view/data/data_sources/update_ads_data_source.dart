import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/app_controller.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/value/colors.dart';
import 'package:car_rental/features/my_ads_view/data/data_sources/my_ads_data_source.dart';
import 'package:get/get.dart' as myGet;
import 'package:dio/dio.dart';
import 'package:path/path.dart';

UploadAdsController uploadAdsController = myGet.Get.find();
AppController appController = myGet.Get.find();
updateAdsDataSource({
  String? category_id,
  String? second_category,
  String? city_id,
  String? brand_id,
  String? style_id,
  String? color_id,
  String? name,
  File? photo_main,
  String? price,
  String? content,
  String? type_product,
  String? condition,
  String? production_year,
  String? kilometer,
  String? address,
  String? whatsapp,
  String? description,
  String? phone,
  String? status,
  String? number_type,
  String? vehicle_type,
  String? vehicle_number,
  String? code,
  String? photo_link,
  // File? photo_ads,
  String? service_id,
  String? price_daily,
  String? price_monthly,
  String? price_yearly,
  String? sim_type,
  String? product_id,
}) async {
  Helper.showLoading();
  Map<String, dynamic> mapimages = {};
  List<MultipartFile> imageList = List<MultipartFile>.empty(growable: true);

  for (var i = 0; i < uploadAdsController.imagesAds!.length; i++) {
    imageList.add(
      await MultipartFile.fromFile(
        uploadAdsController.imagesAds![i].path,
        filename: basename(uploadAdsController.imagesAds![i].path),
      ),
    );
  }
  for (var i = 0; i < imageList.length; i++) {
    mapimages["photo_ads[$i]"] = imageList[i];
  }

  print("ssssssssssssssssssssssssssssssss" +
      {
        'category_id': category_id,
        'city_id': city_id,
        'brand_id': brand_id,
        'style_id': style_id,
        'second_category': second_category,
        'color_id': color_id,
        'name': name,
        'photo_main': uploadAdsController.imagesAds!.length == 0
            ? ""
            : await MultipartFile.fromFile(
                uploadAdsController.imagesAds![0].path,
                filename: uploadAdsController.imagesAds![0].path,
              ),
        'price': price,
        'content': description,
        'type_product': type_product,
        'condition': condition,
        'production_year': production_year,
        'kilometer': kilometer,
        'address': address,
        'whatsapp': whatsapp,
        'description': description,
        'phone': phone,
        ...mapimages,
        'service_id': service_id,
        'plan_id': "3",
        'number_type': number_type,
        'vehicle_type': vehicle_type,
        'vehicle_number': vehicle_number,
        'code': code,
        'photo_link': photo_link,
        'price_daily': price_daily,
        'price_monthly': price_monthly,
        'price_yearly': price_yearly,
        "status": "1",
        "sim_type": sim_type,
      }.toString());

  dynamic response = await Apis.apis.post(
    'api/ads_update',
    formData: FormData.fromMap({
      // 'category_id':'1',
      // 'city_id':'3',
      // 'brand_id':'384',
      // 'style_id':'5527',
      // 'color_id':'2',
      // 'name':'ddd',
      // 'price':'20200',
      // 'content':'dhcadhcaca',
      // 'type_product':'for_sale',
      // 'condition':'New',
      // 'production_year':'2022',
      // 'kilometer':'20000',
      // 'address':'aaa',
      // 'whatsapp':'444444444444444',
      // 'description':'dsdsdsdsd',
      // 'phone':'1212121',
//status:1
//sim_type:1
//number_type:Normal
//vehicle_type:Motorcycle
//vehicle_number:123124
//code:21
//       plan_id:3
      'product_id': product_id,
      'category_id': category_id,
      'city_id': city_id,
      'brand_id': brand_id,
      'style_id': style_id,
      'color_id': color_id,
      'second_category': second_category,
      'name': name,
      'photo_main': uploadAdsController.imagesAds!.length == 0
          ? null
          : await MultipartFile.fromFile(
              uploadAdsController.imagesAds![0].path,
              filename: basename(uploadAdsController.imagesAds![0].path),
            ),
      'price': price,
      'content': description,
      'type_product': type_product,
      'condition': condition,
      'production_year': production_year,
      'kilometer': kilometer,
      'address': address,
      'whatsapp': whatsapp,
      'description': description,
      'phone': phone,
      'status': status,
      ...mapimages,
      'service_id': service_id,
      // 'plan_id': "1",
      'number_type': number_type,
      'vehicle_type': vehicle_type,
      'vehicle_number': vehicle_number,
      'code': code,
      'photo_link': photo_link,
      'price_daily': price_daily,
      'price_monthly': price_monthly,
      'price_yearly': price_yearly,
      'sim_type': sim_type,
    }),
  );
  // log(uploadAdsController.imagesAds![0].path);

  if (response != null) {
    myGet.Get.back();
    myGet.Get.back();
    myGet.Get.back();

    myAdsDataSource(1, true);
    appController.controller.animateTo(2);
    BotToast.showText(
        text: "Ads Updated Successfully", contentColor: AppColors.green);
    log(response.toString());

    // await SPHelper.spHelper.setToken(response.data['object']['token']);
    // await SPHelper.spHelper.setType(response.data['object']['type']);

    Helper.hideLoading();

    // myGet.Get.offAll(() => MainView());
    // getOtpDataSource(email: email);
  } else {
    myAdsDataSource(1, true);

    Helper.hideLoading();
    myGet.Get.back();
  }
}
