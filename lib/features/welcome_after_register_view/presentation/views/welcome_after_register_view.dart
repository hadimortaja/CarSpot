import 'dart:convert';

import 'package:car_rental/core/controllers/app_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WelcomeAfterRegisterView extends StatelessWidget {
  AppController appController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 140.w,
                height: 140.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor.withOpacity(0.20)),
                child: Center(
                    child: Container(
                  width: 76.w,
                  height: 76.h,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x1a000000),
                        offset: Offset(0, 3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                      child: Icon(
                    Icons.check,
                    size: 40.r,
                    color: AppColors.primaryColor,
                  )),
                )),
              ),
              SizedBox(
                height: 50.h,
              ),
              CustomText(
                "Hey ! Welcome ",
                fontSize: 27.h,
                fontFamily: "tajawalb",
              ),
              SizedBox(
                height: 14.h,
              ),
              CustomText(
                "Nice to see you. Let's find your\nfavorite service!",
                fontSize: 15.h,
                color: AppColors.grey,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 170.h,
              ),
              CustomButton(
                onTap: () {
                  appController.setIndexScreen(0);
                  Get.offAll(() => MainView());
                },
                width: Get.width,
                height: 60.h,
                title: "Back To Home",
                txtColor: AppColors.whiteColor,
              )
            ]),
      ),
    );
  }
}
