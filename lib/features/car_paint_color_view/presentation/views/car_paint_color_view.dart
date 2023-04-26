import 'dart:math';

import 'package:car_rental/core/controllers/app_controller.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';

class CarPaintColorView extends StatelessWidget {
  AuthController authController = Get.find();
   
  
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
                        "Car Paint Color",
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
                      Obx(() {
                        return authController.getPaintColorData.value.code ==
                                null
                            ? Helper.loading()
                            : authController
                                        .getPaintColorData.value.data!.length ==
                                    0
                                ? Column(
                                    children: [
                                      CustomText(
                                        "There is No Colors Available",
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      )
                                    ],
                                  )
                                : SizedBox(
                                    width: Get.width,
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: authController
                                          .getPaintColorData.value.data!.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.setIndexColor(index);

                                            authController
                                                    .getColorsSelect.value =
                                                authController.getPaintColorData
                                                    .value.data![index];
                                            print(authController
                                                .getColorsSelect.value.name);
                                          },
                                          child: Container(
                                            width: Get.width,
                                            height: 50.h,
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
                                              child: Row(children: [
                                                Container(
                                                  height: 15.h,
                                                  width: 16.w,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.r),
                                                      color: Color(int.parse(
                                                          "0xff" +
                                                              authController
                                                                  .getPaintColorData
                                                                  .value
                                                                  .data![index]
                                                                  .code
                                                                  .toString()
                                                                  .substring(
                                                                      1, 7)))),
                                                  // HexC(0xff${authController.getPaintColorData.value.data![index].code})),
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                CustomText(
                                                SPHelper.spHelper.getLanguage()=="en"?authController
                                                    .getPaintColorData
                                                    .value
                                                    .data![index]
                                                    .nameEn:authController
                                                    .getPaintColorData
                                                    .value
                                                    .data![index]
                                                    .name,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.check,
                                                  size: 20.r,
                                                  color: controller
                                                              .indexColor ==
                                                          index
                                                      ? AppColors.primaryColor
                                                      : Colors.transparent,
                                                )
                                              ]),
                                            ),
                                          ),
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
