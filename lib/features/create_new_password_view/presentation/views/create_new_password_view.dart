import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/core/widgets/custom_text_form_field.dart';
import 'package:car_rental/features/password_changed_view/presentation/views/password_changed_view.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CreateNewPasswordView extends StatelessWidget {
  String? password, confirmPassword;
  setPassword(String value) {
    this.password = value;
  }

  setConfirmPassword(String value) {
    this.confirmPassword = value;
  }

  final formKey = GlobalKey<FormState>();

  validation(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return 'This field is required*'.tr;
    }
  }

  validateConfirmPass(String data) {
    if (confirmPassword == null || confirmPassword == '') {
      return 'This field is required*'.tr;
    } else if (confirmPassword != password) {
      return 'The passwords do not match'.tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  "Create New Password",
                  fontSize: 27.sp,
                  fontFamily: "tajawalb",
                ),
                SizedBox(
                  height: 17.h,
                ),
                CustomText(
                  "Please enter the new password",
                  fontSize: 15.sp,
                  color: AppColors.grey,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 23.h,
                ),
                CustomText(
                  "New Password",
                  fontSize: 15.sp,
                  color: Color(0XFFBFBFBF),
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 9.h,
                ),
                CustomTextFormField(hint: "New Password"),
                SizedBox(
                  height: 43.h,
                ),
                CustomText(
                  "Confirm Password",
                  fontSize: 15.sp,
                  color: Color(0XFFBFBFBF),
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 9.h,
                ),
                CustomTextFormField(
                  hint: "Confirm Password",
                  onSaved: setConfirmPassword,
                ),
                SizedBox(
                  height: 80.h,
                ),
                CustomButton(
                  onTap: () {
                    Get.to(() => PasswordChangedView());
                  },
                  width: Get.width,
                  height: 59.h,
                  title: "Continue",
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
