import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/services/dynamic_link.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/cached_network_image.dart';
import 'package:car_rental/features/car_ad_sale_view/data/data_sources/get_product_by_id_data_source.dart';
import 'package:car_rental/features/car_ad_sale_view/presentation/views/car_ad_sale_view.dart';
import 'package:car_rental/features/car_paint_color_view/data/data_sources/paint_color_data_source.dart';
import 'package:car_rental/features/my_ads_view/data/data_sources/delete_ads_data_source.dart';
import 'package:car_rental/features/my_ads_view/data/data_sources/make_sold_out_data_source.dart';
import 'package:car_rental/features/my_ads_view/data/data_sources/my_ads_data_source.dart';
import 'package:car_rental/features/my_ads_view/data/data_sources/republish_ad_data_source.dart';
import 'package:car_rental/features/update_car_for_rent_view/presentation/views/update_car_for_rent_view.dart';
import 'package:car_rental/features/update_car_part_view/presentation/views/update_car_parts_view.dart';
import 'package:car_rental/features/update_car_service_view/presentation/views/update_car_service_view.dart';
import 'package:car_rental/features/update_car_view/presentation/views/update_car_view.dart';
import 'package:car_rental/features/update_mobile_number_view/presentation/views/update_mobile_number_customer_view.dart';
import 'package:car_rental/features/update_truck_view/presentation/views/update_truck_view.dart';
import 'package:car_rental/features/update_vehicle_number_customer_view/presentation/views/update_vehicle_number_customer_view.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/models/categories_ads_model.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class MyAdsView extends StatelessWidget {
  List<int> status = [0, 1, 2, 0];
  List<String> images = [
    "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?cs=srgb&dl=pexels-mike-b-170811.jpg&fm=jpg",
    "https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80",
    "https://images.unsplash.com/photo-1494976388531-d1058494cdd8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8&w=1000&q=80",
    "https://imageio.forbes.com/specials-images/imageserve/5d35eacaf1176b0008974b54/2020-Chevrolet-Corvette-Stingray/0x0.jpg?format=jpg&crop=4560,2565,x790,y784,safe&width=960",
  ];
  List<String> titles = ["Wrong ad".tr, "Sold out already".tr, "Other".tr];
  UploadAdsController uploadAdsController = Get.find();
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 62.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              "My Ads",
              fontSize: 22.sp,
              fontFamily: "tajawalb",
            )
          ],
        ),
        SizedBox(
          height: 29.h,
        ),
        Obx(() {
          return uploadAdsController.getMyAdsData.value.code == null
              ? Helper.loading()
              : uploadAdsController.getMyAdsData.value.data!.data!.length == 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 140.w,
                              height: 140.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      AppColors.primaryColor.withOpacity(0.20)),
                              child: Center(
                                  child: CustomSvgImage(
                                imageName: "no_ads",
                                height: 77.h,
                              )),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            CustomText(
                              "No Any Ad !",
                              fontSize: 27.sp,
                            ),
                            CustomText(
                              "Please try to put ads\nto appear here",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ],
                    )
                  : Expanded(
                      child: LazyLoadScrollView(
                        onEndOfPage: () {
                          print(uploadAdsController
                              .getMyAdsData.value.data!.currentPage);
                          print(uploadAdsController
                              .getMyAdsData.value.data!.lastPage);

                          log('ennd');

                          if (uploadAdsController
                                  .getMyAdsData.value.data!.currentPage !=
                              uploadAdsController
                                  .getMyAdsData.value.data!.lastPage) {
                            myAdsDataSource(
                                uploadAdsController
                                        .getMyAdsData.value.data!.currentPage! +
                                    1,
                                false);
                            // Apis.apis.getAllNews(
                            //   appController.allNewsApp.value.currentPage! + 1,
                            //   false,
                            // );
                          }
                        },
                        child: SizedBox(
                          width: Get.width,
                          child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              itemCount: uploadAdsController.allAdsList.length,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    getProductById(uploadAdsController
                                        .allAdsList[index].id
                                        .toString());

                                    Get.to(() => CarAdSaleView(
                                          id: uploadAdsController
                                              .allAdsList[index].id
                                              .toString(),
                                        ));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0x1aff0000),
                                              offset: Offset(0, 4),
                                              blurRadius: 6,
                                            ),
                                          ],
                                        ),
                                        child: Column(children: [
                                          Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              uploadAdsController
                                                          .allAdsList[index]
                                                          .category ==
                                                      null
                                                  ? Container()
                                                  : uploadAdsController
                                                              .allAdsList[index]
                                                              .category!
                                                              .id
                                                              .toString() ==
                                                          "3"
                                                      ? Container(
                                                          width: Get.width,
                                                          height: 168.h,
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .whiteColor),
                                                          child: Center(
                                                              child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20.w),
                                                            child: Container(
                                                              width: 375.w,
                                                              height: 80.h,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(15
                                                                              .r),
                                                                  border: Border.all(
                                                                      color: Color(
                                                                          0xff524188),
                                                                      width:
                                                                          3)),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            12.w),
                                                                child: Row(
                                                                    children: [
                                                                      uploadAdsController.allAdsList[index].simType.toString() ==
                                                                              "1"
                                                                          ? CustomSvgImage(
                                                                              imageName: "etisalat-seeklogo.com",
                                                                              height: 20.h,
                                                                            )
                                                                          : CustomSvgImage(
                                                                              imageName: "du-company-logo-1",
                                                                              height: 40.h,
                                                                            ),
                                                                      SizedBox(
                                                                        width:
                                                                            30.w,
                                                                      ),
                                                                      CustomText(uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .phone),
                                                                    ]),
                                                              ),
                                                            ),
                                                          )),
                                                        )
                                                      : uploadAdsController
                                                                  .allAdsList[
                                                                      index]
                                                                  .category!
                                                                  .id
                                                                  .toString() ==
                                                              "4"
                                                          ? Container(
                                                              width: Get.width,
                                                              height: 168.h,
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .whiteColor),
                                                              child: Center(
                                                                  child:
                                                                      Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            16.w),
                                                                child: uploadAdsController.allAdsList[index].photo !=
                                                                        null
                                                                    ? CachedNetworkImageShare(
                                                                        uploadAdsController
                                                                            .allAdsList[index]
                                                                            .photo!,
                                                                        168.h,
                                                                        Get.width,
                                                                        1)
                                                                    : SizedBox(),
                                                              )),
                                                            )
                                                          : uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .category!
                                                                      .id
                                                                      .toString() ==
                                                                  "6"
                                                              ? Container(
                                                                  width:
                                                                      Get.width,
                                                                  height: 168.h,
                                                                  child: Center(
                                                                    child: Image.network(uploadAdsController
                                                                        .allAdsList[
                                                                            index]
                                                                        .brand!
                                                                        .logo!),
                                                                  ),
                                                                )
                                                              : CachedNetworkImageShare(
                                                                  uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .photo ??
                                                                      "",
                                                                  168,
                                                                  Get.width,
                                                                  15,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                              Container(
                                                width: 35.w,
                                                height: 168.h,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black
                                                        .withOpacity(0.23),
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    15.r),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15.r))),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15.h),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            PanaraConfirmDialog
                                                                .show(
                                                              context,
                                                              title: "",
                                                              message:
                                                                  "Would you like to re-publish this advertisement?"
                                                                      .tr,
                                                              confirmButtonText:
                                                                  "Confirm".tr,
                                                              cancelButtonText:
                                                                  "Cancel".tr,
                                                              onTapCancel: () {
                                                                Get.back();
                                                              },
                                                              onTapConfirm: () {
                                                                if (uploadAdsController
                                                                        .allAdsList[
                                                                            index]
                                                                        .republish! <
                                                                    uploadAdsController
                                                                        .allAdsList[
                                                                            index]
                                                                        .plan!
                                                                        .resentCount!) {
                                                                  Get.back();

                                                                  republishProductDataSource(uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                                } else {
                                                                  BotToast.showText(
                                                                      text: "You Cannot make Republish"
                                                                          .tr);
                                                                }
                                                              },
                                                              panaraDialogType:
                                                                  PanaraDialogType
                                                                      .custom,
                                                              barrierDismissible:
                                                                  false,
                                                              color: AppColors
                                                                  .primaryColor,
                                                            );
                                                          },
                                                          child: CustomSvgImage(
                                                            imageName:
                                                                "repeat_icon",
                                                            height: 18.h,
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            uploadAdsController
                                                                .setIndexStepper(
                                                                    0);
                                                            uploadAdsController
                                                                .setIndexCarServicesStepper(
                                                                    0);
                                                            uploadAdsController
                                                                .setIndexCarPartsStepper(
                                                                    0);
                                                            uploadAdsController
                                                                .setIndexMobileNumberStepper(
                                                                    0);
                                                            uploadAdsController
                                                                .setIndexVehicleNumberStepper(
                                                                    0);
                                                            uploadAdsController
                                                                .imagesAds!
                                                                .clear();
                                                            authController
                                                                .cleanFilter();
                                                            getProductById(
                                                                uploadAdsController
                                                                    .allAdsList[
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                            if (uploadAdsController
                                                                    .allAdsList[
                                                                        index]
                                                                    .category!
                                                                    .id
                                                                    .toString() ==
                                                                "1") {
                                                              uploadAdsController
                                                                      .getProductionYearSelect
                                                                      .value
                                                                      .name =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .productionYear!;
                                                              uploadAdsController
                                                                      .condition
                                                                      .value =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .condition!;
                                                              //brand
                                                              authController
                                                                      .getBrabdSelect
                                                                      .value
                                                                      .name =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .brand!
                                                                      .name;
                                                              authController
                                                                      .getBrabdSelect
                                                                      .value
                                                                      .id =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .brand!
                                                                      .id;
                                                              //model
                                                              authController
                                                                      .getCarModelSelect
                                                                      .value
                                                                      .name =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .style!
                                                                      .name;
                                                              authController
                                                                      .getCarModelSelect
                                                                      .value
                                                                      .id =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .style!
                                                                      .id;
                                                              //color
                                                              authController
                                                                      .getColorsSelect
                                                                      .value
                                                                      .name =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .color!
                                                                      .name;
                                                              authController
                                                                      .getColorsSelect
                                                                      .value
                                                                      .id =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .color!
                                                                      .id;
                                                              //city
                                                              authController
                                                                      .getCitiesSelect
                                                                      .value
                                                                      .name =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .city!
                                                                      .name;
                                                              authController
                                                                      .getCitiesSelect
                                                                      .value
                                                                      .id =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .city!
                                                                      .id;
                                                              uploadAdsController
                                                                      .picturesUpdate
                                                                      .value =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .pictures!;
                                                              Get.to(() =>
                                                                  UpdateCarView());
                                                            } else if (uploadAdsController
                                                                    .allAdsList[
                                                                        index]
                                                                    .category!
                                                                    .id
                                                                    .toString() ==
                                                                "2") {
                                                              //brand
                                                              authController
                                                                      .getTruckBrandsSelect
                                                                      .value
                                                                      .name =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .brand!
                                                                      .name!;
                                                              authController
                                                                      .getTruckBrandsSelect
                                                                      .value
                                                                      .id =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .brand!
                                                                      .id!;
                                                              //model
                                                              authController
                                                                      .getTruckModelSelect
                                                                      .value
                                                                      .name =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .style!
                                                                      .name!;
                                                              authController
                                                                      .getTruckModelSelect
                                                                      .value
                                                                      .id =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .style!
                                                                      .id!;
                                                              //color
                                                              if (SPHelper
                                                                      .spHelper
                                                                      .getLanguage() ==
                                                                  "en") {
                                                                authController
                                                                        .getColorsSelect
                                                                        .value
                                                                        .nameEn =
                                                                    uploadAdsController
                                                                        .allAdsList[
                                                                            index]
                                                                        .color!
                                                                        .nameEn!;
                                                                authController
                                                                        .getColorsSelect
                                                                        .value
                                                                        .id =
                                                                    uploadAdsController
                                                                        .allAdsList[
                                                                            index]
                                                                        .color!
                                                                        .id!;
                                                              } else {
                                                                authController
                                                                        .getColorsSelect
                                                                        .value
                                                                        .name =
                                                                    uploadAdsController
                                                                        .allAdsList[
                                                                            index]
                                                                        .color!
                                                                        .name!;
                                                                authController
                                                                        .getColorsSelect
                                                                        .value
                                                                        .id =
                                                                    uploadAdsController
                                                                        .allAdsList[
                                                                            index]
                                                                        .color!
                                                                        .id!;
                                                              }

                                                              uploadAdsController
                                                                      .getProductionYearSelect
                                                                      .value
                                                                      .name =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .productionYear!;
                                                              uploadAdsController
                                                                      .condition
                                                                      .value =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .condition!;
                                                              //city
                                                              authController
                                                                      .getCitiesSelect
                                                                      .value
                                                                      .name =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .city!
                                                                      .name;
                                                              authController
                                                                      .getCitiesSelect
                                                                      .value
                                                                      .id =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .city!
                                                                      .id;
                                                              uploadAdsController
                                                                      .picturesUpdate
                                                                      .value =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .pictures!;
                                                              Get.to(() =>
                                                                  UpdateTruckView());
                                                            } else if (uploadAdsController
                                                                    .allAdsList[
                                                                        index]
                                                                    .category!
                                                                    .id
                                                                    .toString() ==
                                                                "3") {
                                                              uploadAdsController
                                                                  .simType
                                                                  .value = uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .simType
                                                                          .toString() ==
                                                                      "1"
                                                                  ? "Etisalat"
                                                                  : "Du";
                                                              uploadAdsController
                                                                      .condition
                                                                      .value =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .condition!;

                                                              Get.to(() =>
                                                                  UpdateMobileNumberCustomerView());
                                                            } else if (uploadAdsController
                                                                    .allAdsList[
                                                                        index]
                                                                    .category!
                                                                    .id
                                                                    .toString() ==
                                                                "4") {
                                                              uploadAdsController
                                                                      .vehicleType
                                                                      .value =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .vehicleType!;
                                                              //city
                                                              authController
                                                                      .getCitiesSelect
                                                                      .value
                                                                      .name =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .city!
                                                                      .name;
                                                              authController
                                                                      .getCitiesSelect
                                                                      .value
                                                                      .id =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .city!
                                                                      .id;
                                                              authController
                                                                      .getCitiesSelect
                                                                      .value
                                                                      .logo =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .city!
                                                                      .logo;

                                                              //
                                                              uploadAdsController
                                                                      .numberType
                                                                      .value =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .numberType!;
                                                              Get.to(() =>
                                                                  UpdateVehicleNumberCustomerView());
                                                            } else if (uploadAdsController
                                                                    .allAdsList[
                                                                        index]
                                                                    .category!
                                                                    .id
                                                                    .toString() ==
                                                                "6") {
                                                              //brand
                                                              authController
                                                                      .getBrabdSelect
                                                                      .value
                                                                      .name =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .brand!
                                                                      .name;
                                                              authController
                                                                      .getBrabdSelect
                                                                      .value
                                                                      .id =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .brand!
                                                                      .id;
                                                              authController
                                                                      .getBrabdSelect
                                                                      .value
                                                                      .logo =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .brand!
                                                                      .logo;
                                                              //city
                                                              authController
                                                                      .getCitiesSelect
                                                                      .value
                                                                      .name =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .city!
                                                                      .name;
                                                              authController
                                                                      .getCitiesSelect
                                                                      .value
                                                                      .id =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .city!
                                                                      .id;
                                                              authController
                                                                      .getCitiesSelect
                                                                      .value
                                                                      .logo =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .city!
                                                                      .logo;
                                                              Get.to(() =>
                                                                  UpdateCarPartsView());
                                                            } else if (uploadAdsController
                                                                    .allAdsList[
                                                                        index]
                                                                    .category!
                                                                    .id
                                                                    .toString() ==
                                                                "9") {
                                                              //brand
                                                              authController
                                                                      .getBrabdSelect
                                                                      .value
                                                                      .name =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .brand!
                                                                      .name!;
                                                              authController
                                                                      .getBrabdSelect
                                                                      .value
                                                                      .id =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .brand!
                                                                      .id!;
                                                              //model
                                                              authController
                                                                      .getCarModelSelect
                                                                      .value
                                                                      .name =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .style!
                                                                      .name!;
                                                              authController
                                                                      .getCarModelSelect
                                                                      .value
                                                                      .id =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .style!
                                                                      .id!;
                                                              //color
                                                              authController
                                                                      .getColorsSelect
                                                                      .value
                                                                      .name =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .color!
                                                                      .name!;
                                                              authController
                                                                      .getColorsSelect
                                                                      .value
                                                                      .id =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .color!
                                                                      .id!;

                                                              uploadAdsController
                                                                      .getProductionYearSelect
                                                                      .value
                                                                      .name =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .productionYear!;
                                                              uploadAdsController
                                                                      .condition
                                                                      .value =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .condition!;
                                                              //city
                                                              authController
                                                                      .getCitiesSelect
                                                                      .value
                                                                      .name =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .city!
                                                                      .name;
                                                              authController
                                                                      .getCitiesSelect
                                                                      .value
                                                                      .id =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .city!
                                                                      .id;
                                                              uploadAdsController
                                                                      .picturesUpdate
                                                                      .value =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .pictures!;
                                                              Get.to(() =>
                                                                  UpdateCarForRentView());
                                                            } else if (uploadAdsController
                                                                        .allAdsList[
                                                                            index]
                                                                        .category!
                                                                        .id
                                                                        .toString() ==
                                                                    "5" ||
                                                                uploadAdsController
                                                                        .allAdsList[
                                                                            index]
                                                                        .category!
                                                                        .id
                                                                        .toString() ==
                                                                    "7") {
                                                              uploadAdsController
                                                                      .getCategoriesSelect1
                                                                      .value =
                                                                  DataCategoryAds();
                                                              uploadAdsController
                                                                      .getCategoriesSelect2
                                                                      .value =
                                                                  DataCategoryAds();
                                                              uploadAdsController
                                                                      .picturesUpdate
                                                                      .value =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .pictures!;
                                                              uploadAdsController
                                                                      .getCategoriesSelect1
                                                                      .value =
                                                                  uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .category!;
                                                              uploadAdsController
                                                                  .getCategoriesSelect2
                                                                  .value = uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .secondCategory ==
                                                                      null
                                                                  ? DataCategoryAds()
                                                                  : DataCategoryAds(
                                                                      id: 7,
                                                                      name:
                                                                          "Car Cars");

                                                              Get.to(() =>
                                                                  UpdateCarServiceView());
                                                            }
                                                          },
                                                          child: CustomSvgImage(
                                                            imageName:
                                                                "edit_icon",
                                                            height: 18.h,
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            log("ttttt");
                                                            DynamicLinkService().createDynamicLink(
                                                                id: uploadAdsController
                                                                    .allAdsList[
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                                imageUrl: uploadAdsController
                                                                        .allAdsList[
                                                                            index]
                                                                        .photo ??
                                                                    "",
                                                                title: uploadAdsController
                                                                        .allAdsList[
                                                                            index]
                                                                        .name ??
                                                                    "",
                                                                description: uploadAdsController
                                                                        .allAdsList[
                                                                            index]
                                                                        .description ??
                                                                    "");
                                                          },
                                                          child: CustomSvgImage(
                                                            imageName:
                                                                "share_icon",
                                                            height: 18.h,
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            uploadAdsController
                                                                .setIndexDelete(
                                                                    1);
                                                            // uploadAdsController
                                                            //                 .allAdsList[
                                                            //                     index]
                                                            //                 .category!
                                                            //                 .id
                                                            //                 .toString() ==
                                                            //             "1"
                                                            //                 .toString() ||
                                                            //         uploadAdsController
                                                            //                 .allAdsList[
                                                            //                     index]
                                                            //                 .category!
                                                            //                 .id
                                                            //                 .toString() ==
                                                            //             "2"
                                                            Get.dialog(
                                                                barrierDismissible:
                                                                    false,
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          205.w,
                                                                      height:
                                                                          300.h,
                                                                      decoration: BoxDecoration(
                                                                          color: AppColors
                                                                              .whiteColor,
                                                                          borderRadius:
                                                                              BorderRadius.circular(25.r)),
                                                                      child: Column(
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 30.h,
                                                                            ),
                                                                            Container(
                                                                                height: 55.h,
                                                                                width: 55.w,
                                                                                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColor.withOpacity(0.20)),
                                                                                child: Center(
                                                                                  child: Container(
                                                                                    height: 37.h,
                                                                                    width: 37.w,
                                                                                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColor),
                                                                                    child: Center(
                                                                                        child: Icon(
                                                                                      Icons.close,
                                                                                      color: AppColors.whiteColor,
                                                                                    )),
                                                                                  ),
                                                                                )),
                                                                            SizedBox(
                                                                              height: 26.h,
                                                                            ),
                                                                            CustomText(
                                                                              "Warning !",
                                                                              fontSize: 22.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              // fontFamily:
                                                                              //     "tajawalb",
                                                                            ),
                                                                            CustomText(
                                                                              "Are you sure you want\ndelete your ad ?",
                                                                              fontSize: 15.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: AppColors.grey,
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 11.h,
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                showModalBottomSheet(
                                                                                  isDismissible: true,
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return Column(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          height: 16.h,
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              GestureDetector(
                                                                                                onTap: () {
                                                                                                  Get.back();
                                                                                                },
                                                                                                child: CustomText(
                                                                                                  "Cancel",
                                                                                                  fontSize: 16.w,
                                                                                                  color: AppColors.primaryColor,
                                                                                                  fontWeight: FontWeight.w400,
                                                                                                ),
                                                                                              ),
                                                                                              GestureDetector(
                                                                                                onTap: () {
                                                                                                  Get.back();
                                                                                                },
                                                                                                child: CustomText(
                                                                                                  "Done",
                                                                                                  fontSize: 16.w,
                                                                                                  color: AppColors.primaryColor,
                                                                                                  fontWeight: FontWeight.w400,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 30.h,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: Get.width,
                                                                                          height: 150.h,
                                                                                          child: ListView.builder(
                                                                                            shrinkWrap: true,
                                                                                            primary: false,
                                                                                            itemCount: titles.length,
                                                                                            itemBuilder: (context, index) {
                                                                                              return Obx(() => GestureDetector(
                                                                                                    onTap: () {
                                                                                                      uploadAdsController.indexvalue.value = titles[index];
                                                                                                      uploadAdsController.setIndexDelete(index);
                                                                                                      print(uploadAdsController.indexvalue.value);
                                                                                                    },
                                                                                                    child: Column(
                                                                                                      children: [
                                                                                                        Padding(
                                                                                                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                                                                                                          child: Container(
                                                                                                              width: Get.width,
                                                                                                              height: 34.h,
                                                                                                              decoration: BoxDecoration(color: uploadAdsController.indexDelete.value == index ? Color(0xff747480).withOpacity(0.23) : Colors.transparent, borderRadius: BorderRadius.circular(8.r)),
                                                                                                              child: Center(
                                                                                                                  child: CustomText(
                                                                                                                titles[index],
                                                                                                                fontSize: 12.sp,
                                                                                                                fontWeight: FontWeight.w400,
                                                                                                                color: uploadAdsController.indexDelete.value == index ? AppColors.black : AppColors.grey,
                                                                                                              ))),
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          height: 8.h,
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ));
                                                                                            },
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    );
                                                                                  },
                                                                                );
                                                                              },
                                                                              child: Padding(
                                                                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                                                child: Container(
                                                                                  height: 28.h,
                                                                                  decoration: BoxDecoration(
                                                                                      border: Border.all(
                                                                                        color: AppColors.grey,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(15.r)),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                                                                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                                      Icon(
                                                                                        Icons.keyboard_arrow_down,
                                                                                        size: 10.r,
                                                                                        color: Colors.transparent,
                                                                                      ),
                                                                                      Obx(
                                                                                        () => CustomText(
                                                                                          uploadAdsController.indexvalue.value == "" ? titles[1] : uploadAdsController.indexvalue.value,
                                                                                          fontSize: 12.sp,
                                                                                          color: AppColors.black,
                                                                                          fontWeight: FontWeight.w400,
                                                                                        ),
                                                                                      ),
                                                                                      Icon(
                                                                                        Icons.keyboard_arrow_down,
                                                                                        size: 20.r,
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                    ]),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Spacer(),
                                                                            Divider(),
                                                                            Padding(
                                                                              padding: EdgeInsets.symmetric(
                                                                                horizontal: 28.w,
                                                                              ),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  GestureDetector(
                                                                                    onTap: () {
                                                                                      Get.back();
                                                                                      if (uploadAdsController.indexDelete == 1) {
                                                                                        makeSoldOutDataSource(uploadAdsController.allAdsList[index].id.toString());
                                                                                        deleteAdsDataSource(uploadAdsController.allAdsList[index].id.toString());
                                                                                      } else {
                                                                                        deleteAdsDataSource(uploadAdsController.allAdsList[index].id.toString());
                                                                                      }
                                                                                    },
                                                                                    child: CustomText(
                                                                                      "Yes",
                                                                                      fontSize: 22.sp,
                                                                                      color: AppColors.primaryColor,
                                                                                      fontFamily: "tajawalb",
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 0.09.w,
                                                                                    height: 50.h,
                                                                                    decoration: BoxDecoration(color: AppColors.grey),
                                                                                  ),
                                                                                  GestureDetector(
                                                                                    onTap: () {
                                                                                      Get.back();
                                                                                    },
                                                                                    child: CustomText(
                                                                                      "No",
                                                                                      fontSize: 22.sp,
                                                                                      fontFamily: "tajawalb",
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ]),
                                                                    ),
                                                                  ],
                                                                ));
                                                            // : Get.dialog(
                                                            //     Column(
                                                            //       mainAxisAlignment:
                                                            //           MainAxisAlignment
                                                            //               .center,
                                                            //       children: [
                                                            //         Container(
                                                            //           width:
                                                            //               205.w,
                                                            //           height:
                                                            //               264.h,
                                                            //           decoration: BoxDecoration(
                                                            //               color: AppColors.whiteColor,
                                                            //               borderRadius: BorderRadius.circular(25.r)),
                                                            //           child:
                                                            //               Column(children: [
                                                            //             SizedBox(
                                                            //               height: 30.h,
                                                            //             ),
                                                            //             Container(
                                                            //                 height: 55.h,
                                                            //                 width: 55.w,
                                                            //                 decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColor.withOpacity(0.20)),
                                                            //                 child: Center(
                                                            //                   child: Container(
                                                            //                     height: 37.h,
                                                            //                     width: 37.w,
                                                            //                     decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColor),
                                                            //                     child: Center(
                                                            //                         child: Icon(
                                                            //                       Icons.close,
                                                            //                       color: AppColors.whiteColor,
                                                            //                     )),
                                                            //                   ),
                                                            //                 )),
                                                            //             SizedBox(
                                                            //               height: 26.h,
                                                            //             ),
                                                            //             CustomText(
                                                            //               "Warning !",
                                                            //               fontSize: 22.sp,
                                                            //               fontWeight: FontWeight.w400,
                                                            //               // fontFamily:
                                                            //               //     "tajawalb",
                                                            //             ),
                                                            //             CustomText(
                                                            //               "Are you sure you want\ndelete your ad ?",
                                                            //               fontSize: 15.sp,
                                                            //               fontWeight: FontWeight.w400,
                                                            //               color: AppColors.grey,
                                                            //               textAlign: TextAlign.center,
                                                            //             ),
                                                            //             Spacer(),
                                                            //             Divider(),
                                                            //             Padding(
                                                            //               padding: EdgeInsets.symmetric(
                                                            //                 horizontal: 28.w,
                                                            //               ),
                                                            //               child: Row(
                                                            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            //                 children: [
                                                            //                   GestureDetector(
                                                            //                     onTap: () {
                                                            //                       Get.back();
                                                            //                       deleteAdsDataSource(uploadAdsController.allAdsList[index].id.toString());
                                                            //                     },
                                                            //                     child: CustomText(
                                                            //                       "Yes",
                                                            //                       fontSize: 22.sp,
                                                            //                       color: AppColors.primaryColor,
                                                            //                       fontFamily: "tajawalb",
                                                            //                     ),
                                                            //                   ),
                                                            //                   Container(
                                                            //                     width: 0.09.w,
                                                            //                     height: 50.h,
                                                            //                     decoration: BoxDecoration(color: AppColors.grey),
                                                            //                   ),
                                                            //                   GestureDetector(
                                                            //                     onTap: () {
                                                            //                       Get.back();
                                                            //                     },
                                                            //                     child: CustomText(
                                                            //                       "No",
                                                            //                       fontSize: 22.sp,
                                                            //                       fontFamily: "tajawalb",
                                                            //                     ),
                                                            //                   ),
                                                            //                 ],
                                                            //               ),
                                                            //             )
                                                            //           ]),
                                                            //         ),
                                                            //       ],
                                                            //     ),
                                                            //     barrierDismissible:
                                                            //         false);
                                                          },
                                                          child: CustomSvgImage(
                                                            imageName:
                                                                "delete_icon",
                                                            height: 18.h,
                                                          ),
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: -7.h,
                                                child: Container(
                                                  width: Get.width,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      if (uploadAdsController
                                                              .allAdsList[index]
                                                              .plan !=
                                                          null)
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .whiteColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: uploadAdsController
                                                                            .allAdsList[
                                                                                index]
                                                                            .plan!
                                                                            .id
                                                                            .toString() ==
                                                                        "2"
                                                                    ? AppColors
                                                                        .green
                                                                    : uploadAdsController.allAdsList[index].plan!.id.toString() ==
                                                                            "1"
                                                                        ? Color(
                                                                            0xffFBAA30)
                                                                        : AppColors
                                                                            .red,
                                                                offset: Offset(
                                                                    0, 0),
                                                                blurRadius: 2,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5.w,
                                                                    vertical:
                                                                        3.h),
                                                            child: Row(
                                                              children: [
                                                                CustomSvgImage(
                                                                  imageName:
                                                                      "taj",
                                                                  color:
                                                                      AppColors
                                                                          .grey,
                                                                  height: 10.h,
                                                                ),
                                                                SizedBox(
                                                                  width: 5.w,
                                                                ),
                                                                CustomText(
                                                                    uploadAdsController
                                                                        .allAdsList[
                                                                            index]
                                                                        .plan!
                                                                        .title!,
                                                                    fontSize:
                                                                        12.sp,

                                                                    // fontFamily: "tajawalb",
                                                                    color: AppColors
                                                                        .grey),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          uploadAdsController.allAdsList[index]
                                                      .category!.id
                                                      .toString() ==
                                                  "6"
                                              ? SizedBox()
                                              : SizedBox(
                                                  height: 10.h,
                                                ),
                                          uploadAdsController.allAdsList[index]
                                                          .category!.id
                                                          .toString() ==
                                                      "6" ||
                                                  uploadAdsController
                                                          .allAdsList[index]
                                                          .category!
                                                          .id
                                                          .toString() ==
                                                      "5" ||
                                                  uploadAdsController
                                                          .allAdsList[index]
                                                          .category!
                                                          .id
                                                          .toString() ==
                                                      "7"
                                              ? SizedBox()
                                              : Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.w),
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .category!
                                                                          .id
                                                                          .toString() ==
                                                                      "3" ||
                                                                  uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .category!
                                                                          .id
                                                                          .toString() ==
                                                                      "4"
                                                              ? Row(
                                                                  children: [
                                                                    CustomSvgImage(
                                                                      imageName:
                                                                          "location_icon",
                                                                      height:
                                                                          10.h,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          10.w,
                                                                    ),
                                                                    CustomText(
                                                                      SPHelper.spHelper.getLanguage() ==
                                                                              "en"
                                                                          ? uploadAdsController
                                                                              .allAdsList[
                                                                                  index]
                                                                              .city!
                                                                              .nameEn
                                                                          : uploadAdsController.allAdsList[index].city!.name ??
                                                                              "",
                                                                      fontSize:
                                                                          10.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ],
                                                                )
                                                              : Row(
                                                                  children: [
                                                                    CustomSvgImage(
                                                                      imageName:
                                                                          "title_icon",
                                                                      height:
                                                                          10.h,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          10.w,
                                                                    ),
                                                                    CustomText(
                                                                      uploadAdsController.allAdsList[index].name.toString().length > 20
                                                                          ? uploadAdsController.allAdsList[index].name.toString().substring(0, 20) +
                                                                              "..."
                                                                          : uploadAdsController
                                                                              .allAdsList[index]
                                                                              .name
                                                                              .toString(),
                                                                      fontSize:
                                                                          10.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ],
                                                                ),
                                                          uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .category!
                                                                          .id
                                                                          .toString() ==
                                                                      "3" ||
                                                                  uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .category!
                                                                          .id
                                                                          .toString() ==
                                                                      "4"
                                                              ? SizedBox()
                                                              : SizedBox(
                                                                  height: 13.h,
                                                                ),
                                                          uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .category!
                                                                          .id
                                                                          .toString() ==
                                                                      "3" ||
                                                                  uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .category!
                                                                          .id
                                                                          .toString() ==
                                                                      "4"
                                                              ? SizedBox()
                                                              : Row(
                                                                  children: [
                                                                    CustomSvgImage(
                                                                      imageName:
                                                                          "date_icon",
                                                                      height:
                                                                          10.h,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          10.w,
                                                                    ),
                                                                    CustomText(
                                                                      uploadAdsController
                                                                              .allAdsList[index]
                                                                              .productionYear ??
                                                                          "",
                                                                      fontSize:
                                                                          10.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ],
                                                                ),
                                                          uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .category!
                                                                          .id
                                                                          .toString() ==
                                                                      "3" ||
                                                                  uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .category!
                                                                          .id
                                                                          .toString() ==
                                                                      "4"
                                                              ? SizedBox()
                                                              : SizedBox(
                                                                  height: 13.h,
                                                                ),
                                                          uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .category!
                                                                          .id
                                                                          .toString() ==
                                                                      "3" ||
                                                                  uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .category!
                                                                          .id
                                                                          .toString() ==
                                                                      "4"
                                                              ? SizedBox()
                                                              : Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    CustomSvgImage(
                                                                      imageName:
                                                                          "color_icon",
                                                                      height:
                                                                          12.h,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          10.w,
                                                                    ),
                                                                    if (uploadAdsController
                                                                            .allAdsList[index]
                                                                            .color !=
                                                                        null)
                                                                      CustomText(
                                                                        SPHelper.spHelper.getLanguage() ==
                                                                                "en"
                                                                            ? uploadAdsController.allAdsList[index].color!.nameEn
                                                                            : uploadAdsController.allAdsList[index].color!.name,
                                                                        fontSize:
                                                                            10.sp,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                  ],
                                                                ),
                                                          SizedBox(
                                                            height: 13.h,
                                                          ),
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              CustomSvgImage(
                                                                imageName:
                                                                    "price_icon",
                                                                height: 8.h,
                                                              ),
                                                              SizedBox(
                                                                width: 10.w,
                                                              ),
                                                              uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .categoryId
                                                                          .toString() ==
                                                                      "9"
                                                                  ? CustomText(
                                                                      "${uploadAdsController.allAdsList[index].priceDaily} AED/Daily",
                                                                      fontSize:
                                                                          10.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    )
                                                                  : CustomText(
                                                                      "${uploadAdsController.allAdsList[index].price} AED",
                                                                      fontSize:
                                                                          10.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 13.h,
                                                          ),
                                                          uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .category!
                                                                          .id
                                                                          .toString() ==
                                                                      "3" ||
                                                                  uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .category!
                                                                          .id
                                                                          .toString() ==
                                                                      "4"
                                                              ? SizedBox()
                                                              : Row(
                                                                  children: [
                                                                    CustomSvgImage(
                                                                      imageName:
                                                                          "location_icon",
                                                                      height:
                                                                          10.h,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          10.w,
                                                                    ),
                                                                    CustomText(
                                                                      SPHelper.spHelper.getLanguage() ==
                                                                              "en"
                                                                          ? uploadAdsController
                                                                              .allAdsList[
                                                                                  index]
                                                                              .city!
                                                                              .nameEn
                                                                          : uploadAdsController.allAdsList[index].city!.name ??
                                                                              "",
                                                                      fontSize:
                                                                          10.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ],
                                                                ),
                                                          SizedBox(
                                                            height: 13.h,
                                                          ),
                                                          uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .category!
                                                                          .id
                                                                          .toString() ==
                                                                      "3" ||
                                                                  uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .category!
                                                                          .id
                                                                          .toString() ==
                                                                      "4"
                                                              ? SizedBox()
                                                              : Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    CustomSvgImage(
                                                                      imageName:
                                                                          "time_icon",
                                                                      height:
                                                                          10.h,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          10.w,
                                                                    ),
                                                                    CustomText(
                                                                      uploadAdsController
                                                                          .allAdsList[
                                                                              index]
                                                                          .createdAt
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              10),
                                                                      fontSize:
                                                                          10.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ],
                                                                ),
                                                          uploadAdsController
                                                                      .allAdsList[
                                                                          index]
                                                                      .category!
                                                                      .id
                                                                      .toString() ==
                                                                  "7"
                                                              ? SizedBox()
                                                              : SizedBox(
                                                                  height: 13.h,
                                                                ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                        ]),
                                      ),
                                      SizedBox(
                                        height: 23.h,
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    );
        })
      ]),
    );
  }
}
