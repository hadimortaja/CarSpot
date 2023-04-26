import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/core/widgets/custom_text_form_field.dart';
import 'package:car_rental/features/help_view/data/data_sources/help_data_source.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HelpView extends StatelessWidget {
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

  String? name, email, phone, body;
  setEmail(String email) {
    this.email = email;
  }

  setName(String name) {
    this.name = name;
  }

  setPhone(String phone) {
    this.phone = phone;
  }

  setBody(String body) {
    this.body = body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(children: [
          SizedBox(
            height: 60.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios)),
                CustomText(
                  "Help & Support",
                  fontSize: 22.sp,
                  fontFamily: "tajawalb",
                ),
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 29.h,
                    ),
                    Container(
                      height: 111.h,
                      width: 111.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffFCB1B1)),
                      child: Center(
                          child: CustomSvgImage(
                        imageName: "support_icon",
                        height: 70.h,
                        width: 70.w,
                      )),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          "Your name :",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomTextFormField(
                          onSaved: setName,
                          validator: validation,
                        ),
                        SizedBox(
                          height: 23.h,
                        ),
                        CustomText(
                          "Email address :",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomTextFormField(
                          onSaved: setEmail,
                          validator: validationEmail,
                        ),
                        SizedBox(
                          height: 23.h,
                        ),
                        CustomText(
                          "Phone number :",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomTextFormField(
                          onSaved: setPhone,
                          validator: validation,
                          textInputType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 23.h,
                        ),
                        CustomText(
                          "Problem description :",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomTextFormField(
                          maxLines: 4,
                          onSaved: setBody,
                          validator: validation,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        CustomButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              helpDataSource(
                                  name: name,
                                  phone: phone,
                                  email: email,
                                  body: body);
                            }
                          },
                          width: Get.width,
                          height: 59.h,
                          btnColor: AppColors.primaryColor,
                          title: "Continue",
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    )
                  ],
                )),
          )
        ]),
      ),
    );
  }
}
