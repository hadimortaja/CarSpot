import 'dart:math';

import 'package:car_rental/core/controllers/app_controller.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';

import '../../../cars_view/data/data_sources/products_by_category_data_source.dart';

class ChooseCarYearView extends StatelessWidget {
  String? id;
  ChooseCarYearView({this.id});
  // List<String> years = [
  //   "1980".tr,
  //   "1981".tr,
  //   "1982".tr,
  //   "1983".tr,
  //   "1984".tr,
  //   "1985".tr,
  //   "1986".tr,
  //   "1987".tr,
  //   "1988".tr,
  //   "1989".tr,
  //   "1990".tr,
  //   "1991".tr,
  //   "1992".tr,
  //   "1993".tr,
  //   "1994".tr,
  //   "1995".tr,
  //   "1996".tr,
  //   "1997".tr,
  //   "1998".tr,
  //   "1999".tr,
  //   "2000".tr,
  //   "2001".tr,
  //   "2002".tr,
  //   "2003".tr,
  //   "2004".tr,
  //   "2005".tr,
  //   "2006".tr,
  //   "2007".tr,
  //   "2008".tr,
  //   "2009".tr,
  //   "2010".tr,
  //   "2011".tr,
  //   "2012".tr,
  //   "2013".tr,
  //   "2014".tr,
  //   "2015".tr,
  //   "2016".tr,
  //   "2017".tr,
  //   "2018".tr,
  //   "2019".tr,
  //   "2020".tr,
  //   "2021".tr,
  //   "2022".tr,
  //   "2023".tr,
  //   "2024".tr,
  //   "2025".tr,
  //   "2026".tr,
  //   "2027".tr,
  //   "2028".tr,
  //   "2029".tr,
  //   "2030".tr,
  // ];

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
                      getProductsByCategoryDataSource(1, true, id!,
                          year: uploadAdsController
                              .getProductionYearSelect.value.name
                              .toString());
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
                        "Production Year",
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
                Obx(() {
                  return uploadAdsController.getProductionYearData.value.code ==
                          null
                      ? Helper.loading()
                      : uploadAdsController
                                  .getProductionYearData.value.data!.length ==
                              0
                          ? CustomText(
                              "There is No Production Years",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            )
                          : Expanded(
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
                                      itemCount: uploadAdsController
                                          .getProductionYearData
                                          .value
                                          .data!
                                          .length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.setIndexYear(index);
                                            // controller.year.value = years[index];

                                            print(controller.year.value);
                                            controller.getProductionYearSelect
                                                    .value =
                                                uploadAdsController
                                                    .getProductionYearData
                                                    .value
                                                    .data![index];
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
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 13.w),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CustomText(
                                                      uploadAdsController
                                                          .getProductionYearData
                                                          .value
                                                          .data![index]
                                                          .name,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    Icon(
                                                      Icons.check,
                                                      size: 20.r,
                                                      color: controller
                                                                  .indexYear ==
                                                              index
                                                          ? AppColors
                                                              .primaryColor
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
                            ));
                })
              ],
            );
          },
        ));
  }
}
