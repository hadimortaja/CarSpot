import 'package:car_rental/core/controllers/app_controller.dart';
import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/cached_network_image.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/core/widgets/custom_text_form_field.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:car_rental/features/my_information_view_vendor/data/data_sources/set_profile_data_source.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../choose_gender_view/presentation/views/choose_gender_view.dart';

class MyInformationView extends StatelessWidget {
  ProfileController profileController = Get.find();
  final formKey = GlobalKey<FormState>();
  validation(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return 'This field is required*'.tr;
    }
  }

  String? name, email, description;
  setName(String name) {
    this.name = name;
  }

  setEmail(String email) {
    this.email = email;
  }

  setDescription(String description) {
    this.description = description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
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
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                CustomText(
                  "Basic Information",
                  fontSize: 22.sp,
                  fontFamily: "tajawalb",
                ),
                GestureDetector(
                  onTap: () {
                    // formKey.currentState!.save();
                    setProfileDataSource(
                        name: name ??
                            profileController.getProfileData.value.data!.name,
                        description: description ??
                            profileController
                                .getProfileData.value.data!.description,
                        email: email ??
                            profileController.getProfileData.value.data!.email);

                    print("name = $name");
                    print("email = $email");
                    print("description = $description");
                  },
                  child: CustomText(
                    "Save",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          GetBuilder<AppController>(
              init: AppController(),
              initState: (_) {},
              builder: (controller) {
                return profileController.getProfileData.value.code == null
                    ? Helper.loading()
                    : Expanded(
                        child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 29.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomPngImage(
                                      imageName: controller.indexGender == 0
                                          ? "male_image"
                                          : "female_image",
                                      height: 111.h,
                                      width: 111.w,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                CustomTextFormField(
                                  hint: "Ahmed_salem",
                                  initial: profileController
                                      .getProfileData.value.data!.name!,
                                  onSaved: setName,
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                CustomTextFormField(
                                  onTap: () {
                                    Get.to(() => ChooseGenderView());
                                    // print(controller.gender);
                                  },
                                  hint: "Please select your gender",
                                  isTime: true,
                                  initial: controller.indexGender == 0
                                      ? "Male"
                                      : "Female",
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                CustomTextFormField(
                                  hint: "Ahmedsalem@gmail.com",
                                  initial: profileController
                                      .getProfileData.value.data!.email!,
                                  onSaved: setEmail,
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 5.h,
                                      width: 5.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.grey),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    CustomText(
                                      "Description",
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.grey,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                CustomTextFormField(
                                  hint:
                                      """Lorem ipsum dolor sit amet. Nam perferendis
       ipsum sit temporibus nisi eum placeat sunt est
       dolor maxime sed libero odit""",
                                  maxLines: 4,
                                  onSaved: setDescription,
                                  validator: validation,
                                  initial: profileController.getProfileData
                                          .value.data!.description! ??
                                      "",
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 36.h,
                                ),
                                CustomText(
                                  "Delete this account",
                                  fontSize: 22.sp,
                                  fontFamily: "tajawalb",
                                ),
                                SizedBox(
                                  height: 36.h,
                                ),
                                CustomButton(
                                  onTap: () {
                                    Get.dialog(Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 205.w,
                                          height: 264.h,
                                          decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(25.r)),
                                          child: Column(children: [
                                            SizedBox(
                                              height: 30.h,
                                            ),
                                            Container(
                                                height: 55.h,
                                                width: 55.w,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors
                                                        .primaryColor
                                                        .withOpacity(0.20)),
                                                child: Center(
                                                  child: Container(
                                                    height: 37.h,
                                                    width: 37.w,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColors
                                                            .primaryColor),
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.close,
                                                      color:
                                                          AppColors.whiteColor,
                                                    )),
                                                  ),
                                                )),
                                            SizedBox(
                                              height: 26.h,
                                            ),
                                            CustomText(
                                              "Warning !",
                                              fontSize: 22.sp,
                                              fontFamily: "tajawalb",
                                            ),
                                            CustomText(
                                              "Are you sure you want\nDelete your account ?",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.grey,
                                              textAlign: TextAlign.center,
                                            ),
                                            Spacer(),
                                            Divider(),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 28.w,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      //  controller
                                                      //     .setIndexScreen(0);
                                                      Get.back();
                                                      Get.back();

                                                      SPHelper.spHelper
                                                          .setToken("");
                                                      Get.offAll(
                                                          () => MainView());
                                                    },
                                                    child: CustomText(
                                                      "Yes",
                                                      fontSize: 22.sp,
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontFamily: "tajawalb",
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 0.09.w,
                                                    height: 50.h,
                                                    decoration: BoxDecoration(
                                                        color: AppColors.grey),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    child: CustomText(
                                                      "No",
                                                      fontSize: 22.sp,
                                                      fontFamily: "tajawalb",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ]),
                                        ),
                                      ],
                                    ));
                                  },
                                  width: Get.width,
                                  height: 59.h,
                                  borderColor: AppColors.primaryColor,
                                  btnColor: Colors.white,
                                  title: "Yes, Delete my account",
                                  txtColor: AppColors.primaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                SizedBox(
                                  height: 36.h,
                                ),
                              ],
                            )),
                      );
              })
        ]),
      ),
    );
  }
}
