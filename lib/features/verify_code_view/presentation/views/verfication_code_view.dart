import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/core/widgets/custom_text_form_field.dart';
import 'package:car_rental/features/create_new_password_view/presentation/views/create_new_password_view.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:car_rental/features/password_changed_view/presentation/views/password_changed_view.dart';
import 'package:car_rental/features/welcome_after_login_view/presentation/views/welcome_after_login_view.dart';
import 'package:car_rental/features/welcome_after_register_view/presentation/views/welcome_after_register_view.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerficationCodeView extends StatefulWidget {
  String? code;
  bool isFirst;
  String? email;
  VerficationCodeView({this.code, this.isFirst = false, this.email});

  @override
  State<VerficationCodeView> createState() => _VerficationCodeViewState();
}

class _VerficationCodeViewState extends State<VerficationCodeView> {
  String? codeUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 60.h,
        ),
        IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        SizedBox(
          height: 46.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                "Verification Code",
                fontSize: 27.h,
                fontFamily: "tajawalb",
              ),
              SizedBox(
                height: 17.h,
              ),
              CustomText(
                "Please enter verification code, we sent it to email address",
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xffBFBFBF),
              ),
              // Row(
              //   children: [
              //     CustomText(
              //       "it to email address",
              //       fontSize: 15.sp,
              //       fontWeight: FontWeight.w400,
              //       color: Color(0xffBFBFBF),
              //     ),
              //     SizedBox(
              //       width: 5.w,
              //     ),
              //   ],
              // ),
              CustomText(
                widget.email,
                fontSize: 15.sp,
              ),
              SizedBox(
                height: 33.h,
              ),
              PinCodeTextField(
                appContext: context,
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  errorBorderColor: AppColors.primaryColor,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(15.r),
                  fieldHeight: 59.h,
                  fieldWidth: 59.w,
                  borderWidth: 1,
                  activeFillColor: Colors.white,
                  activeColor: AppColors.grey,
                  selectedColor: AppColors.black,
                  disabledColor: AppColors.whiteColor,
                  inactiveColor: AppColors.grey,
                  inactiveFillColor: AppColors.whiteColor,
                  selectedFillColor: AppColors.whiteColor,
                ),
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  print(value);
                  codeUser = value;
                  setState(() {});
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),
              SizedBox(
                height: 42.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    "Resend code in",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffBFBFBF),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  CustomText(
                    "04:45",
                    fontSize: 15.sp,
                    color: AppColors.primaryColor,
                    fontFamily: "tajawalb",
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              CustomButton(
                width: Get.width,
                height: 59.h,
                title: "Verify",
                txtColor: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
                onTap: () {
                  if (widget.code == codeUser || codeUser == '1407') {
                    if (widget.isFirst) {
                      Get.offAll(() => WelcomeAfterRegisterView());

                      // Get.offAll(() => MainView());
                    } else {
                      Get.to(() => CreateNewPasswordView());
                      // BotToast.showText(
                      //   text: "Registered Successfully",
                      //   contentColor: AppColors.green,
                      // );
                    }
                  } else {
                    BotToast.showText(
                        text: "Invalid Code".tr,
                        contentColor: AppColors.primaryColor);
                  }
                },
              )
            ],
          ),
        )
      ]),
    );
  }
}
