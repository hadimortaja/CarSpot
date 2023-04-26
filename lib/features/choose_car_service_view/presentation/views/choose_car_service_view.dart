import 'dart:math';

import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/features/home_view/data/models/categories_model.dart';
import 'package:car_rental/features/my_ads_view/data/data_sources/my_ads_data_source.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/models/categories_ads_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../cars_view/data/data_sources/products_by_category_data_source.dart';

class ChooseCarServiceView extends StatelessWidget {
  String? id;
  ChooseCarServiceView({this.id});
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          height: 80.h,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.w),
                child: CustomButton(
                  onTap: () {
                    // if (id != null) {
                    //   getProductsByCategoryDataSource(
                    //     1,
                    //     true,
                    //     id!,
                    //     brand:
                    //         authController.getCitiesSelect.value.id.toString(),
                    //   );
                    // }
                    Get.back();
                  },
                  width: Get.width,
                  height: 59.h,
                  btnColor: AppColors.primaryColor,
                  title: "Continue",
                ),
              ),
            ],
          ),
        ),
        body: GetBuilder<AuthController>(
          init: AuthController(),
          builder: (controller) {
            return Column(
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      CustomText(
                        "Car Service",
                        fontFamily: "tajawalb",
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.transparent,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                      //   child: Container(
                      //     width: Get.width,
                      //     height: 37.h,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(5.r),
                      //       color: AppColors.whiteColor,
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: const Color(0x1f414141),
                      //           offset: Offset(0, 4),
                      //           blurRadius: 6,
                      //         ),
                      //       ],
                      //     ),
                      //     child: Padding(
                      //       padding: EdgeInsets.symmetric(horizontal: 17.w),
                      //       child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.end,
                      //           children: [
                      //             Icon(
                      //               Icons.search,
                      //               color: Color(0xffBFBFBF),
                      //               size: 20.r,
                      //             )
                      //           ]),
                      //     ),
                      //   ),
                      // ),

                      // SizedBox(
                      //   height: 25.h,
                      // ),
                      Obx(() {
                        return uploadAdsController
                                    .getCategoriesData.value.status ==
                                null
                            ? Helper.loading()
                            : uploadAdsController
                                        .getCategoriesData.value.data!.length ==
                                    0
                                ? CustomText(
                                    "There is No Services",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  )
                                : SizedBox(
                                    width: Get.width,
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: uploadAdsController
                                          .getCategoriesData.value.data!.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (index == 0) {
                                              if (uploadAdsController
                                                      .getCategoriesSelect1
                                                      .value
                                                      .id ==
                                                  null) {
                                                uploadAdsController
                                                        .getCategoriesSelect1
                                                        .value =
                                                    uploadAdsController
                                                        .getCategoriesData
                                                        .value
                                                        .data![index];
                                              } else {
                                                uploadAdsController
                                                    .getCategoriesSelect1
                                                    .value = DataCategoryAds();
                                              }
                                            } else {
                                              if (uploadAdsController
                                                      .getCategoriesSelect2
                                                      .value
                                                      .id ==
                                                  null) {
                                                uploadAdsController
                                                        .getCategoriesSelect2
                                                        .value =
                                                    uploadAdsController
                                                        .getCategoriesData
                                                        .value
                                                        .data![index];
                                              } else {
                                                uploadAdsController
                                                    .getCategoriesSelect2
                                                    .value = DataCategoryAds();
                                              }
                                            }

                                            print(uploadAdsController
                                                .getCategoriesSelect1
                                                .value
                                                .name);
                                            print(uploadAdsController
                                                .getCategoriesSelect2
                                                .value
                                                .name);
                                          },
                                          child: Obx(() => Container(
                                                width: Get.width,
                                                height: 46.h,
                                                decoration: BoxDecoration(
                                                  color: AppColors.whiteColor,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(
                                                              0xffFF0000)
                                                          .withOpacity(0.10),
                                                      offset: Offset(0, 2),
                                                      blurRadius: 6,
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 13.w),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        CustomText(
                                                          SPHelper.spHelper
                                                                      .getLanguage() ==
                                                                  "ar"
                                                              ? uploadAdsController
                                                                  .getCategoriesData
                                                                  .value
                                                                  .data![index]
                                                                  .name
                                                              : uploadAdsController
                                                                  .getCategoriesData
                                                                  .value
                                                                  .data![index]
                                                                  .nameEn,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        Icon(
                                                          Icons.check,
                                                          size: 20.r,
                                                          color: (index == 0
                                                                  ? uploadAdsController
                                                                          .getCategoriesSelect1
                                                                          .value
                                                                          .id !=
                                                                      null
                                                                  : uploadAdsController
                                                                          .getCategoriesSelect2
                                                                          .value
                                                                          .id !=
                                                                      null)
                                                              ? AppColors
                                                                  .primaryColor
                                                              : Colors
                                                                  .transparent,
                                                        )
                                                      ]),
                                                ),
                                              )),
                                        );
                                      },
                                    ),
                                  );
                      })
                    ],
                  ),
                ))
              ],
            );
          },
        ));
  }
}
