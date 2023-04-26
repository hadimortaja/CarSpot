import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/core/widgets/custom_text_form_field.dart';
import 'package:car_rental/features/choose_car_condition_view/presentation/views/choose_car_condition_view.dart';
import 'package:car_rental/features/choose_plan_view/presentation/views/chosse_plan_view.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_profile_data_source.dart';
import 'package:car_rental/features/sim_type_view/presentation/views/sim_type_view.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/data_sources/upload_ads_data_source.dart';
import 'package:car_rental/features/upload_car_view/data/data_sources/choose_plan_data_source.dart';
import 'package:car_rental/features/upload_car_view/presentation/widgets/upload_widget.dart';
import 'package:car_rental/features/upload_mobile_number_customer_view/presentation/widgets/stepper_mobile_number.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UploadMobileNumberCustomerView extends StatefulWidget {
  @override
  State<UploadMobileNumberCustomerView> createState() =>
      _UploadMobileNumberCustomerViewState();
}

class _UploadMobileNumberCustomerViewState
    extends State<UploadMobileNumberCustomerView> {
  ProfileController profileController = Get.find();
  UploadAdsController uploadAdsController = Get.find();

  final formKey = GlobalKey<FormState>();

  final formKey1 = GlobalKey<FormState>();

  validation(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return 'This field is required*'.tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          width: Get.width,
          height: 100.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<UploadAdsController>(
                init: UploadAdsController(),
                builder: (controller) {
                  return CustomButton(
                    onTap: () {
                      if (controller.indexMobileNumberStepper == 0) {
                        if (uploadAdsController.condition.value == "" ||
                            uploadAdsController.simType == "") {
                          BotToast.showText(text: "Please Fill All Fields");
                        } else if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          controller.setIndexMobileNumberStepper(1);
                        }
                      } else if (controller.indexMobileNumberStepper == 1) {
                        if (formKey1.currentState!.validate()) {
                          formKey1.currentState!.save();
                          getProfileDataSource();
                          // print(whatsapp);
                          // print(desc);
                          controller.setIndexMobileNumberStepper(2);
                        }
                      } else {
                        print("ttttttttttt ${uploadAdsController.simType}");
                        print("ttttt ${uploadAdsController.indexSimType}");
                        choosePlanDataSource();
                        Get.to(() => ChoosePlanView(
                              categoryId: "3",
                            ));
                      }
                    },
                    width: 329.w,
                    height: 59.h,
                    title: controller.indexMobileNumberStepper == 2
                        ? "Publish Now"
                        : "Continue",
                  );
                },
              ),
            ],
          )),
      body: GetBuilder<UploadAdsController>(
          init: UploadAdsController(),
          builder: (controller) {
            return Column(children: [
              SizedBox(
                height: 60.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    CustomText(
                      controller.indexMobileNumberStepper == 0
                          ? "Mobile Number"
                          : controller.indexMobileNumberStepper == 1
                              ? "Set Contact Information"
                              : "Check Your Ad",
                      fontSize: 22.sp,
                      fontFamily: "tajawalb",
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              StepperMobileNumber(controller.indexMobileNumberStepper),
              SizedBox(
                height: 30.h,
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: controller.indexMobileNumberStepper == 0
                          ? Form(
                              key: formKey,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Column(children: [
                                  UploadWidget(
                                    onTap: () {
                                      controller.setIndexSimType(-1);
                                      Get.to(() => SimTypeView(
                                            isAdd: true,
                                          ));
                                    },
                                    title:
                                        uploadAdsController.simType.value == ""
                                            ? "SIM Card"
                                            : uploadAdsController.simType.value,
                                    isBlack:
                                        uploadAdsController.simType.value != "",
                                  ),
                                  CustomTextFormField(
                                    hint: "Write Number",
                                    height: 2,
                                    validator: validation,
                                    onSaved: uploadAdsController.setPhoneM,
                                    textInputType: TextInputType.number,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  UploadWidget(
                                    isBlack:
                                        uploadAdsController.condition.value !=
                                            "",
                                    onTap: () {
                                      uploadAdsController.setIndexCondition(-1);
                                      Get.to(() => ChooseCarConditionView());
                                    },
                                    title: uploadAdsController
                                                .condition.value ==
                                            ""
                                        ? "Condition"
                                        : uploadAdsController.condition.value,
                                  ),
                                  CustomTextFormField(
                                    hint: "Price",
                                    height: 2,
                                    validator: validation,
                                    onSaved: uploadAdsController.setPriceM,
                                    textInputType: TextInputType.number,
                                  ),
                                ]),
                              ),
                            )
                          : controller.indexMobileNumberStepper == 1
                              ? Form(
                                  key: formKey1,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    child: Column(
                                      children: [
                                        CustomTextFormField(
                                          hint: "Mobile Number",
                                          height: 2,
                                          validator: validation,
                                          onSaved:
                                              uploadAdsController.setMobileM,
                                          textInputType: TextInputType.number,
                                          suffix: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: CustomSvgImage(
                                              imageName: "call",
                                              color: AppColors.primaryColor,
                                              height: 22.h,
                                              width: 22.w,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        CustomTextFormField(
                                          hint: "Whatsapp Number",
                                          height: 2,
                                          validator: validation,
                                          onSaved:
                                              uploadAdsController.setWhatsM,
                                          textInputType: TextInputType.number,
                                          suffix: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: CustomSvgImage(
                                              imageName: "whatsapp",
                                              color: AppColors.primaryColor,
                                              height: 20.h,
                                              width: 20.w,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 17.h,
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
                                          hint: "Description",
                                          maxLines: 4,
                                          minLines: 1,
                                          onSaved: uploadAdsController.setDescM,
                                          validator: validation,
                                          textInputType:
                                              TextInputType.multiline,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Row(
                                        children: [
                                          CustomPngImage(
                                            imageName: "male_image",
                                            height: 37.h,
                                            width: 37.w,
                                          ),
                                          SizedBox(
                                            width: 22.w,
                                          ),
                                          CustomText(
                                            profileController.getProfileData
                                                .value.data!.name,
                                            fontSize: 16.sp,
                                            fontFamily: "tajawalb",
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Container(
                                      width: Get.width,
                                      height: 272.h,
                                      decoration: BoxDecoration(
                                          color: AppColors.whiteColor),
                                      child: Center(
                                          child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        child: Container(
                                          width: 375.w,
                                          height: 80.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                              border: Border.all(
                                                  color: Color(0xff524188),
                                                  width: 3)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.w),
                                            child: Row(children: [
                                              uploadAdsController
                                                          .simType.value ==
                                                      "Etisalat"
                                                  ? CustomSvgImage(
                                                      imageName:
                                                          "etisalat-seeklogo.com",
                                                      height: 30.h,
                                                    )
                                                  : CustomSvgImage(
                                                      imageName:
                                                          "du-company-logo-1",
                                                      height: 40.h,
                                                    ),
                                              SizedBox(
                                                width: 40.w,
                                              ),
                                              CustomText(
                                                  uploadAdsController.phoneM),
                                              // uploadAdsController
                                              //             .simType.value ==
                                              //         "Etisalat"
                                              //     ? CustomSvgImage(
                                              //         imageName:
                                              //             "etisalat-seeklogo.com",
                                              //         height: 20.h,
                                              //         color: Colors
                                              //             .transparent,
                                              //       )
                                              //     : CustomSvgImage(
                                              //         imageName:
                                              //             "du-company-logo-1",
                                              //         height: 40.h,
                                              //         color: Colors
                                              //             .transparent,
                                              //       ),
                                            ]),
                                          ),
                                        ),
                                      )),
                                    ),
                                    SizedBox(
                                      height: 22.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            "Mobile Number Details",
                                            fontSize: 16.sp,
                                            fontFamily: "tajawalb",
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Row(
                                            children: [
                                              CustomText(
                                                "Sim Type",
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.grey,
                                              ),
                                              Spacer(),
                                              CustomText(
                                                uploadAdsController
                                                    .simType.value,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 14.h,
                                          ),
                                          Row(
                                            children: [
                                              CustomText(
                                                "Write Number",
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.grey,
                                              ),
                                              Spacer(),
                                              CustomText(
                                                uploadAdsController.phoneM,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 14.h,
                                          ),
                                          Row(
                                            children: [
                                              CustomText(
                                                "Condition",
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.grey,
                                              ),
                                              Spacer(),
                                              CustomText(
                                                uploadAdsController
                                                    .condition.value,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 14.h,
                                          ),
                                          Row(
                                            children: [
                                              CustomText(
                                                "Price",
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.grey,
                                              ),
                                              Spacer(),
                                              CustomText(
                                                "${uploadAdsController.priceM} AED",
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 27.h,
                                          ),
                                          CustomText(
                                            "Contact Details",
                                            fontSize: 16.sp,
                                            fontFamily: "tajawalb",
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Row(
                                            children: [
                                              CustomText(
                                                "Mobile Number",
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.grey,
                                              ),
                                              Spacer(),
                                              CustomText(
                                                uploadAdsController.mobileM,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 14.h,
                                          ),
                                          Row(
                                            children: [
                                              CustomText(
                                                "Whatsapp",
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.grey,
                                              ),
                                              Spacer(),
                                              CustomText(
                                                uploadAdsController.whatsappM,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 27.h,
                                          ),
                                          CustomText(
                                            "Mobile Number Description",
                                            fontSize: 16.sp,
                                            fontFamily: "tajawalb",
                                          ),
                                          SizedBox(
                                            height: 14.h,
                                          ),
                                          CustomText(
                                            uploadAdsController.descM,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.grey,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ))),
            ]);
          }),
    );
  }
}
