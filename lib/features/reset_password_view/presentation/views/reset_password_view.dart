import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/core/widgets/custom_text_form_field.dart';
import 'package:car_rental/features/reset_password_view/presentation/views/data/data_sources/reset_password_data_source.dart';
import 'package:car_rental/features/verify_code_view/presentation/views/verfication_code_view.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ResetPasswordView extends StatelessWidget {
  String? email;
  final formKey = GlobalKey<FormState>();

  validation(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return 'This field is required*'.tr;
    }
  }

  setEmail(String value) {
    this.email = value;
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
                  "Reset Password",
                  fontSize: 27.h,
                  fontFamily: "tajawalb",
                ),
                CustomText(
                  "Enter your email address, we will send you\nthe confirmation code",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffBFBFBF),
                ),
                SizedBox(
                  height: 33.h,
                ),
                CustomTextFormField(
                  hint: "Email Address",
                  onSaved: setEmail,
                  validator: validation,
                ),
                SizedBox(
                  height: 90.h,
                ),
                CustomButton(
                  width: Get.width,
                  height: 59.h,
                  title: "Send Code",
                  txtColor: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      resetPasswordDataSource(email!);
                    }
                  },
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
