import 'dart:math';

import 'package:car_rental/core/controllers/app_controller.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/services/translations/internationalization.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';

class ChooseLanguageView extends StatelessWidget {
  AuthController authController = Get.find();
  List<String> languages = ["Arabic".tr, "English".tr];
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
                    InternationalizationService.updateLanguage(
                        SPHelper.spHelper.getLanguage()!);
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
        body: GetBuilder<AppController>(
          init: AppController(),
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
                        "Language",
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
                          itemCount: languages.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                controller.setIndexLanguage(index);
                                SPHelper.spHelper
                                    .setLanguage(index == 0 ? "ar" : "en");
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
                                          languages[index],
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        Icon(
                                          Icons.check,
                                          size: 20.r,
                                          color: InternationalizationService
                                                          .getCurrentLocal()
                                                      .languageCode ==
                                                  (index == 0 ? "ar" : "en")
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
