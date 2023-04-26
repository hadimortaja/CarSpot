import 'dart:math';

import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/choose_gellery_or_camera_sheet.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChooseProfilePicView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 100.h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.w),
              child: CustomButton(
                onTap: () {
                  Get.to(() => ChooseProfilePicView());
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 70.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                "Skip",
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          SizedBox(
            height: 21.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CustomText(
                    "Put a Profile Picture",
                    fontSize: 27.sp,
                    fontFamily: "tajawalb",
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  CustomText(
                    "Please put your logo ? Upload it now.",
                    fontSize: 15.sp,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 127.h,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CustomSvgImage(
                        imageName: "Icon awesome-user-circle",
                        height: 175.h,
                      ),
                      Positioned(
                        bottom: -10.h,
                        right: 12.w,
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15.r)),
                              ),
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return ChooseCameraOrGellerySheet();
                              },
                            );
                          },
                          child: Container(
                            height: 74.h,
                            width: 74.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.whiteColor,
                                border: Border.all(color: AppColors.grey)),
                            child: Center(
                              child: Container(
                                height: 34.h,
                                width: 34.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryColor),
                                child: Center(
                                    child: CustomSvgImage(
                                  imageName: "add_icon",
                                  height: 16.h,
                                )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
