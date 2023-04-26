import 'package:car_rental/core/controllers/app_controller.dart';
import 'package:car_rental/core/value/colors.dart';
import 'package:car_rental/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/widgets/custom_image.dart';

class CustomNavBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      init: AppController(),
      id: "indexScreen",
      builder: (controller) => BottomNavigationBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        currentIndex: controller.indexScreen,
        onTap: controller.setIndexScreen,
        showSelectedLabels: false,
        fixedColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        items: [
          BottomNavigationBarItem(
            activeIcon: Container(
              height: 32.h,
              width: 32.w,
              decoration: BoxDecoration(
                color: const Color(0xffff0000),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x40ff0000),
                    offset: Offset(0, 3),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Center(
                child: CustomSvgImage(
                  imageName: 'homr_car',
                  height: 20.h,
                  width: 16.w,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            icon: Column(
              children: [
                CustomSvgImage(
                  imageName: 'homr_car',
                  height: 20.h,
                  width: 16.w,
                  color: AppColors.grey,
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: 
            Container(
              height: 32.h,
              width: 32.w,
              decoration: BoxDecoration(
                color: const Color(0xffff0000),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x40ff0000),
                    offset: Offset(0, 3),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Center(
                child: CustomSvgImage(
                  imageName: 'notification_car',
                  height: 20.h,
                  width: 16.w,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            icon: Column(
              children: [
                CustomSvgImage(
                  imageName: 'notification_car',
                  height: 20.h,
                  width: 16.w,
                  color: AppColors.grey,
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
                height: 32.h,
                width: 32.w,
                decoration: BoxDecoration(
                  color: const Color(0xffff0000),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x40ff0000),
                      offset: Offset(0, 3),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Center(
                  child: CustomSvgImage(
                    imageName: 'chart_car',
                    height: 20.h,
                    width: 16.w,
                    color: AppColors.whiteColor,
                  ),
                )),
            icon: Column(
              children: [
                CustomSvgImage(
                    imageName: 'chart_car',
                    height: 20.h,
                    width: 16.w,
                    color: Colors.grey),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
                height: 32.h,
                width: 32.w,
                decoration: BoxDecoration(
                  color: const Color(0xffff0000),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x40ff0000),
                      offset: Offset(0, 3),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Center(
                  child: CustomSvgImage(
                    imageName: 'profile_car',
                    height: 20.h,
                    width: 16.w,
                    color: AppColors.whiteColor,
                  ),
                )),
            icon: Column(
              children: [
                CustomSvgImage(
                  imageName: 'profile_car',
                  height: 20.h,
                  width: 16.w,
                  color: AppColors.grey,
                ),
              ],
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
