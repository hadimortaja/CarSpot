import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/choose_gellery_or_camera_sheet.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/core/widgets/custom_text_form_field.dart';
import 'package:car_rental/features/choose_country_view/data/data_souces/cities_data_source.dart';
import 'package:car_rental/features/choose_country_view/presentation/views/choose_country_view.dart';
import 'package:car_rental/features/choose_profile_pic_view/presentation/views/choose_profile_pic_view.dart';
import 'package:car_rental/features/create_account_provider/data/data_sources/sign_up_provider_data_source.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

import '../../../upload_car_view/presentation/widgets/upload_widget.dart';

class CreateAccountProviderView extends StatefulWidget {
  @override
  State<CreateAccountProviderView> createState() =>
      _CreateAccountProviderViewState();
}

class _CreateAccountProviderViewState extends State<CreateAccountProviderView> {
  bool isChecked = false;
  List<Map> phones = [];
  int number = 1;
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

  String? name, email, city, address, mobile, password, confirmPassword;
  setName(String name) {
    this.name = name;
  }

  setEmail(String email) {
    this.email = email;
  }

  setCity(String city) {
    this.city = city;
  }

  setAddress(String address) {
    this.address = address;
  }

  setMobile(String mobile) {
    this.mobile = mobile;
  }

  setPassword(String password) {
    this.password = password;
  }

  setConfirmPassword(String confirmPassword) {
    this.confirmPassword = confirmPassword;
  }

  validateConfirmPass(String data) {
    if (confirmPassword == null || confirmPassword == '') {
      return 'This field is required*'.tr;
    } else if (confirmPassword != password) {
      return 'The passwords do not match'.tr;
    }
  }

  final formKey = GlobalKey<FormState>();

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
                  if (isChecked == false) {
                    BotToast.showText(
                      text: "Please Check The Terms",
                      contentColor: AppColors.primaryColor,
                    );
                  } else {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (authController.linces == null ||
                          authController.passport == null) {
                        BotToast.showText(
                            text: "Please Add Photos".tr,
                            contentColor: AppColors.primaryColor,
                            textStyle: TextStyle(
                                fontSize: 12.sp, color: AppColors.whiteColor));
                      } else {
                        signUpProviderDataSource(
                            username: name,
                            email: email,
                            address: address,
                            city_id: authController.getCitiesSelect.value.id
                                .toString(),
                            serviceId: authController.getServiceSelect.value.id
                                .toString(),
                            password: password,
                            password_confirmation: confirmPassword,
                            phoneNumber: phones);
                      }

                      // Get.to(() => ChooseProfilePicView());
                    }
                  }
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
      body: Form(
        key: formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 60.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomText(
                "Create Account",
                fontSize: 27.sp,
                fontFamily: "tajawalb",
              ),
              CustomText(
                "Sign up and get started",
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xffBFBFBF),
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomTextFormField(
                hint: authController.indexService == 0
                    ? "for_cars"
                    : authController.indexService == 1
                        ? "for_trucks"
                        : authController.indexService == 2
                            ? "for_car_services"
                            : authController.indexService == 3
                                ? "for_car_parts"
                                : "Username1",
                validator: validation,
                onSaved: setName,
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomTextFormField(
                hint: "Email Address",
                validator: validationEmail,
                onSaved: setEmail,
              ),
              SizedBox(
                height: 30.h,
              ),

              Obx(
                () => UploadWidget(
                  isBlack: authController.getCitiesSelect.value.name != null ||
                      authController.getCitiesSelect.value.nameEn != null,
                  onTap: () {
                    citiesDataSource();
                    Get.to(() => ChooseCountryView());
                  },
                  title: ((SPHelper.spHelper.getLanguage() == "en"
                              ? authController.getCitiesSelect.value.nameEn
                              : authController.getCitiesSelect.value.name) ==
                          null)
                      ? "City"
                      : SPHelper.spHelper.getLanguage() == "en"
                          ? authController.getCitiesSelect.value.nameEn
                          : authController.getCitiesSelect.value.name,
                ),
              ),
              // Obx(() => GestureDetector(
              //       onTap: () {
              //         citiesDataSource();
              //         Get.to(() => ChooseCountryView());
              //       },
              //       child: Container(
              //         width: Get.width,
              //         height: 55.h,
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(15.r),
              //             border: Border.all(
              //               color: Color(0xffBFBFBF),
              //             )),
              //         child: Padding(
              //             padding: EdgeInsets.symmetric(horizontal: 12.w),
              //             child: Row(children: [
              //               CustomText(
              //                 authController.getCitiesSelect.value.name == null
              //                     ? "City"
              //                     : authController.getCitiesSelect.value.name,
              //                 fontSize: 14.sp,
              //                 fontWeight: FontWeight.w400,
              //                 color:
              //                     authController.getCitiesSelect.value.name ==
              //                             ""
              //                         ? Color(0xffBFBFBF)
              //                         : AppColors.black,
              //               )
              //             ])),
              //       ),
              //     )),

              // GetBuilder<AuthController>(
              //   init: AuthController(),
              //    builder: (_) {
              //     return CustomTextFormField(
              //       validator: validation,
              //       onSaved: setCity,
              //       isTime: true,
              //       initial: _.getCitiesSelect.value.name ?? "",
              //       onTap: () {
              //         citiesDataSource();
              //         Get.to(() => ChooseCountryView());
              //       },
              //       hint: "City",
              //     );
              //   },
              // ),

              CustomTextFormField(
                hint: "Address",
                validator: validation,
                onSaved: setAddress,
              ),
              SizedBox(
                height: 30.h,
              ),
              Column(
                children: List.generate(
                  number,
                  (index) => Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              hint: "Mobile Number",
                              validator:
                                  index == (number - 1) ? (v) {} : validation,
                              onSaved: setMobile,
                              textInputType: TextInputType.number,
                              suffix: GestureDetector(
                                onTap: () {
                                  number++;
                                  setState(() {});
                                  if (mobile != null) {
                                    phones.add({'\"phone\"': '\"$mobile\"'});
                                  }
                                },
                                child: index == (number - 1)
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w),
                                        child: Icon(Icons.check),
                                      )
                                    : Container(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          CustomText(
                            "* Please click on the checkmark to have the number approved ",
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.red,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
              ),

              GetBuilder<AuthController>(
                id: 'image',
                builder: ((controller) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15.r)),
                                  ),
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return ChooseCameraOrGellerySheet(
                                      onTapCamera: () {
                                        controller.chooseImage(
                                            0, ImageSource.camera);
                                      },
                                      onTapGallery: () {
                                        controller.chooseImage(
                                            0, ImageSource.gallery);
                                      },
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: 150.w,
                                height: 59.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: AppColors.primaryColor
                                        .withOpacity(0.20)),
                                child: controller.passport == null
                                    ? Center(
                                        child: CustomSvgImage(
                                          imageName:
                                              "Icon awesome-cloud-upload-alt",
                                          height: 31.h,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        child: Image.file(
                                          controller.passport!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 7.w,
                                  height: 7.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.black),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CustomText(
                                  "Add Emirites ID / Passport",
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15.r)),
                                  ),
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return ChooseCameraOrGellerySheet(
                                      onTapCamera: () {
                                        controller.chooseImage(
                                            1, ImageSource.camera);
                                      },
                                      onTapGallery: () {
                                        controller.chooseImage(
                                            1, ImageSource.gallery);
                                      },
                                    );
                                  },
                                );
                             
                              },
                              child: Container(
                                width: 150.w,
                                height: 59.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: AppColors.primaryColor
                                        .withOpacity(0.20)),
                                child: controller.linces == null
                                    ? Center(
                                        child: CustomSvgImage(
                                          imageName:
                                              "Icon awesome-cloud-upload-alt",
                                          height: 31.h,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        child: Image.file(
                                          controller.linces!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 7.w,
                                  height: 7.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.black),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CustomText(
                                  "Add a Commercial License",
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomTextFormField(
                hint: "Password",
                validator: validation,
                onSaved: setPassword,
                isPassword: true,
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomTextFormField(
                hint: "Confirm Password",
                validator: validateConfirmPass,
                onSaved: setConfirmPassword,
                isPassword: true,
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: Container(
                      width: 17.w,
                      height: 17.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.r),
                          color: isChecked
                              ? AppColors.primaryColor
                              : Color(0xffBFBFBF).withOpacity(0.50)),
                      child: isChecked
                          ? Center(
                              child: Icon(
                              Icons.check,
                              color: AppColors.whiteColor,
                              size: 15.r,
                            ))
                          : SizedBox(),
                    ),
                  ),
                  SizedBox(
                    width: 13.w,
                  ),
                  CustomText(
                    "I agree with the",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomText(
                    " Terms Conditions& Privacy Policy",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
            ]),
          ))
        ]),
      ),
    );
  }
}
