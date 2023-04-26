import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/core/widgets/custom_text_form_field.dart';
import 'package:car_rental/features/choose_method_view/presentation/views/choose_method_view.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:car_rental/features/reset_password_view/presentation/views/reset_password_view.dart';
import 'package:car_rental/features/signin_view/data/data_sources/sign_in_data_source.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignInView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  validation(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return 'This field is required*'.tr;
    }
  }

  static validationEmail(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return 'This field is required*'.tr;
    }
    if (!GetUtils.isEmail(value)) {
      return 'Incorrect email format'.tr;
    }
  }

  String? email, password;
  setEmail(String email) {
    this.email = email;
  }

  setPassword(String password) {
    this.password = password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            Stack(
              children: [
                CustomPngImage(
                  imageName: "login",
                  width: Get.width,
                  height: 427.h,
                ),
                Positioned(
                    top: 30.h,
                    // left: 10.w,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    )),
                Positioned(
                  bottom: 30.h,
                  left: SPHelper.spHelper.getLanguage() == "en" ? 25.w : 0.w,
                  right: SPHelper.spHelper.getLanguage() == "en" ? 0.w : 25.w,
                  child: CustomText(
                    "Hi ! Welcome Back",
                    fontSize: 27.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "tajawalb",
                  ),
                ),
                Positioned(
                  bottom: 0.h,
                  left: SPHelper.spHelper.getLanguage() == "en" ? 25.w : 0.w,
                  right: SPHelper.spHelper.getLanguage() == "en" ? 0.w : 25.w,
                  child: CustomText(
                    "You should log in to your account to can put ads",
                    color: Color(0xffBFBFBF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextFormField(
                      hint: "Username",
                      onSaved: setEmail,
                      validator: validationEmail,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomTextFormField(
                      hint: "Password",
                      isPassword: true,
                      onSaved: setPassword,
                      validator: validation,
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ResetPasswordView());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomText(
                            "Forget Password?",
                            fontSize: 15.sp,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 33.h,
                    ),
                    CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          signInDataSource(email: email, password: password);
                        }
                      },
                      height: 59.h,
                      width: Get.width,
                      title: "Log In",
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ChooseMethodView());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            "Don't have an account? ",
                            fontSize: 15.sp,
                            color: AppColors.borderColor,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          CustomText(
                            "Sign Up",
                            fontSize: 15.sp,
                            color: AppColors.primaryColor,
                            // fontFamily: "tajawalb",
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.off(() => MainView());
                    //   },
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       CustomText(
                    //         "Continue As A Visitor",
                    //         fontSize: 13.sp,
                    //         color: AppColors.primaryColor,
                    //         // fontFamily: "tajawalb",
                    //         fontWeight: FontWeight.w400,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ]),
            )
          ]),
        ),
      ),
    );
  }
}
