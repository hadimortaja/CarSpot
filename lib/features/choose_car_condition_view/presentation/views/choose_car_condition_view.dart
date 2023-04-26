import 'dart:math';

import 'package:car_rental/core/controllers/app_controller.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';

import '../../../cars_view/data/data_sources/products_by_category_data_source.dart';

class ChooseCarConditionView extends StatelessWidget {
  String? id;
  ChooseCarConditionView({this.id});
  List<String> models = [
    "New".tr,
    "Used".tr,
  ];
  UploadAdsController uploadAdsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        bottomNavigationBar: Container(
          height: 80.h,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.w),
                child: CustomButton(
                  onTap: () {
                    if (id != null) {
                      getProductsByCategoryDataSource(
                        1,
                        true,
                        id!,
                        condition: uploadAdsController.indexCondition == 0
                            ? "New"
                            : "Used",
                      );
                    }
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
        body: GetBuilder<UploadAdsController>(
          init: UploadAdsController(),
          builder: (controller) {
            return Column(
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                        "Car Condition",
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
                      SizedBox(
                        height: 25.h,
                      ),
                      SizedBox(
                        width: Get.width,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: models.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                controller.setIndexCondition(index);
                                controller.condition.value = models[index];
                                print(controller.condition.value);
                                // controller.getCitiesSelect.value =
                                //     authController
                                //         .getCitiesData.value.data![index];
                                // print(controller.getCitiesSelect.value.name);
                              },
                              child: Container(
                                width: Get.width,
                                height: 46.h,
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xffFF0000)
                                          .withOpacity(0.10),
                                      offset: Offset(0, 2),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 13.w),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          models[index],
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        Icon(
                                          Icons.check,
                                          size: 20.r,
                                          color:
                                              controller.indexCondition == index
                                                  ? AppColors.primaryColor
                                                  : Colors.transparent,
                                        )
                                      ]),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ))
              ],
            );
          },
        ));
  }
}
