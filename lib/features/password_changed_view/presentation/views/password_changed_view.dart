import 'dart:convert';

import 'package:car_rental/core/controllers/app_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:car_rental/features/signin_view/presentation/views/signin_view.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PasswordChangedView extends StatelessWidget {
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
                    child: CustomPngImage(
                  imageName: "changed",
                  width: 86.w,
                  height: 77.h,
                )),
              ),
              SizedBox(
                height: 50.h,
              ),
              CustomText(
                "Great ! Your Password\nhas been changed",
                fontSize: 27.h,
                fontFamily: "tajawalb",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 170.h,
              ),
              CustomButton(
                onTap: () {
                  Get.offAll(() => SignInView());
                },
                width: Get.width,
                height: 60.h,
                title: "Back To Log In",
                txtColor: AppColors.whiteColor,
              )
            ]),
      ),
    );
  }
}
