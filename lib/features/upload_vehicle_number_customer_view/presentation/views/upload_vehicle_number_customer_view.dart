import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/cached_network_image.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/core/widgets/custom_text_form_field.dart';
import 'package:car_rental/features/car_paint_color_view/presentation/views/car_paint_color_view.dart';
import 'package:car_rental/features/choose_brand_view/presentation/views/choose_brand_view.dart';
import 'package:car_rental/features/choose_car_condition_view/presentation/views/choose_car_condition_view.dart';
import 'package:car_rental/features/choose_car_model_view.dart/presentation/views/choose_car_model_view.dart';
import 'package:car_rental/features/choose_country_view/data/data_souces/cities_data_source.dart';
import 'package:car_rental/features/choose_country_view/presentation/views/choose_country_view.dart';
import 'package:car_rental/features/choose_plan_view/presentation/views/chosse_plan_view.dart';
import 'package:car_rental/features/number_type_view/presentation/views/number_type_view.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_profile_data_source.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/data_sources/upload_ads_data_source.dart';
import 'package:car_rental/features/upload_car_view/data/data_sources/choose_plan_data_source.dart';
import 'package:car_rental/features/upload_car_view/presentation/widgets/stepper_car.dart';
import 'package:car_rental/features/upload_car_view/presentation/widgets/upload_widget.dart';
import 'package:car_rental/features/upload_vehicle_number_customer_view/widgets/stepper_vehicle_number.dart';
import 'package:car_rental/features/vehicle_type_view/presentation/views/vehicle_type_view.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';

class UploadVehicleNumberCustomerView extends StatelessWidget {
  UploadAdsController uploadAdsController = Get.find();

  final formKey = GlobalKey<FormState>();

  final formKey1 = GlobalKey<FormState>();

  validation(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return 'This field is required*'.tr;
    }
  }

  ScreenshotController screenshotController = ScreenshotController();

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
                    onTap: () async {
                      if (controller.indexVehicleNumberStepper == 0) {
                        if (uploadAdsController.vehicleType.value == "" ||
                            authController.getCitiesSelect.value.name == null ||
                            uploadAdsController.numberType == "") {
                          BotToast.showText(text: "Please Fill All Fields".tr);
                        } else {
                          formKey.currentState!.save();
                          controller.setIndexVehicleNumberStepper(1);
                        }
                      } else if (controller.indexVehicleNumberStepper == 1) {
                        if (formKey1.currentState!.validate()) {
                          formKey1.currentState!.save();
                          getProfileDataSource();
                          // print(whatsapp);
                          // print(desc);
                          controller.setIndexVehicleNumberStepper(2);
                        }
                      } else {
                        await screenshotController
                            .capture()
                            .then((Uint8List? uint8list) async {
                          final tempDir = await getTemporaryDirectory();
                          File file =
                              await File('${tempDir.path}/image.png').create();
                          file.writeAsBytesSync(uint8list!);
                          uploadAdsController.imagesAds!.add(file);
                          log(file.toString());
                          log(uploadAdsController.imagesAds!.length.toString());
                        }).catchError(
                          (onError) {
                            log(onError);
                          },
                        );
                        choosePlanDataSource();
                        Get.to(() => ChoosePlanView(
                              categoryId: "4",
                            ));
                      }
                    },
                    width: 329.w,
                    height: 59.h,
                    title: controller.indexVehicleNumberStepper == 2
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
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          controller.indexVehicleNumberStepper == 1
                              ? "Set Contact Information"
                              : "Vehicle Number",
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
                  StepperVehicleNumber(controller.indexVehicleNumberStepper),
                  SizedBox(
                    height: 20.h,
                  ),
                  Obx(() {
                    return Expanded(
                        child: SingleChildScrollView(
                            child: controller.indexVehicleNumberStepper == 0
                                ? Form(
                                    key: formKey,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            UploadWidget(
                                              isBlack: controller
                                                      .vehicleType.value !=
                                                  "",
                                              title: controller
                                                          .vehicleType.value ==
                                                      ""
                                                  ? "Vehicle Type"
                                                  : controller
                                                      .vehicleType.value,
                                              onTap: () {
                                                controller.setIndexType(-1);
                                                Get.to(() => VehcileTypeView(
                                                      isAdd: true,
                                                    ));
                                              },
                                            ),
                                            UploadWidget(
                                              isBlack: authController
                                                      .getCitiesSelect
                                                      .value
                                                      .name !=
                                                  null,
                                              onTap: () {
                                                citiesDataSource();
                                                Get.to(
                                                    () => ChooseCountryView());
                                              },
                                              title: authController
                                                              .getCitiesSelect
                                                              .value
                                                              .name ==
                                                          null &&
                                                      authController
                                                              .getCitiesSelect
                                                              .value
                                                              .nameEn ==
                                                          null
                                                  ? "City"
                                                  : SPHelper.spHelper
                                                              .getLanguage() ==
                                                          "en"
                                                      ? authController
                                                          .getCitiesSelect
                                                          .value
                                                          .nameEn
                                                      : authController
                                                          .getCitiesSelect
                                                          .value
                                                          .name,
                                            ),
                                            UploadWidget(
                                              isBlack: uploadAdsController
                                                      .numberType.value !=
                                                  "",
                                              title: uploadAdsController
                                                          .numberType.value ==
                                                      ""
                                                  ? "Number Type"
                                                  : uploadAdsController
                                                      .numberType.value,
                                              onTap: () {
                                                Get.to(() => NumberTypeView(
                                                      isAdd: true,
                                                    ));
                                              },
                                            ),
                                            CustomTextFormField(
                                              height: 2,
                                              hint: "Vehicle Number",
                                              onSaved: uploadAdsController
                                                  .setvNumberV,
                                              validator: validation,
                                              textInputType:
                                                  TextInputType.number,
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            uploadAdsController
                                                        .indexNumberType ==
                                                    0
                                                ? SizedBox()
                                                : CustomTextFormField(
                                                    height: 2,
                                                    hint: "Code",
                                                    onSaved: uploadAdsController
                                                        .setCodeV,
                                                    // validator: validation,
                                                  ),
                                            uploadAdsController
                                                        .indexNumberType ==
                                                    0
                                                ? SizedBox()
                                                : SizedBox(
                                                    height: 20.h,
                                                  ),
                                            CustomTextFormField(
                                              height: 2,
                                              hint: "Price",
                                              onSaved:
                                                  uploadAdsController.setPriceV,
                                              validator: validation,
                                              textInputType:
                                                  TextInputType.number,
                                              suffix: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w),
                                                child: CustomText(
                                                  "AED",
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            ),
                                          ]),
                                    ),
                                  )
                                : controller.indexVehicleNumberStepper == 1
                                    ? Form(
                                        key: formKey1,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.w),
                                          child: Column(
                                            children: [
                                              CustomTextFormField(
                                                hint: "Mobile Number",
                                                height: 2,
                                                validator: validation,
                                                onSaved: uploadAdsController
                                                    .setMobileV,
                                                textInputType:
                                                    TextInputType.number,
                                                suffix: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w),
                                                  child: CustomSvgImage(
                                                    imageName: "call",
                                                    color:
                                                        AppColors.primaryColor,
                                                    height: 22.h,
                                                    width: 22.w,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              CustomTextFormField(
                                                hint: "Whatsapp Number",
                                                height: 2,
                                                validator: validation,
                                                onSaved: uploadAdsController
                                                    .setWhatsV,
                                                textInputType:
                                                    TextInputType.number,
                                                suffix: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w),
                                                  child: CustomSvgImage(
                                                    imageName: "whatsapp",
                                                    color:
                                                        AppColors.primaryColor,
                                                    height: 20.h,
                                                    width: 20.w,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
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
                                                onSaved: uploadAdsController
                                                    .setDescV,
                                                validator: validation,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                  profileController
                                                      .getProfileData
                                                      .value
                                                      .data!
                                                      .name!,
                                                  fontSize: 16.sp,
                                                  fontFamily: "tajawalb",
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Screenshot(
                                            controller: screenshotController,
                                            child: Container(
                                              width: Get.width,
                                              height: 200.h,
                                              child: Center(
                                                  child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w,
                                                ),
                                                child: Stack(
                                                  children: [
                                                    uploadAdsController
                                                                .indexType ==
                                                            1
                                                        ? Container(
                                                            width: Get.width,
                                                            height: Get.height,
                                                            child: Image.network(
                                                                authController
                                                                    .getCitiesSelect
                                                                    .value
                                                                    .motorPlat
                                                                    .toString()),
                                                          )
                                                        : Container(
                                                            width: 350.w,
                                                            height: authController.getCitiesSelect.value.id.toString() ==
                                                                            "4" &&
                                                                        uploadAdsController.indexNumberType ==
                                                                            0 ||
                                                                    authController
                                                                            .getCitiesSelect
                                                                            .value
                                                                            .id
                                                                            .toString() ==
                                                                        "5" ||
                                                                    authController
                                                                            .getCitiesSelect
                                                                            .value
                                                                            .id
                                                                            .toString() ==
                                                                        "8"
                                                                ? 160.h
                                                                : 80.h,
                                                            child: uploadAdsController.indexNumberType ==
                                                                    0
                                                                ? CachedNetworkImageShare(
                                                                    authController.getCitiesSelect.value.id.toString() ==
                                                                                "5" ||
                                                                            authController.getCitiesSelect.value.id.toString() ==
                                                                                "6"
                                                                        ? authController
                                                                            .getCitiesSelect
                                                                            .value
                                                                            .normalPlat
                                                                        : authController
                                                                            .getCitiesSelect
                                                                            .value
                                                                            .classicPlat,
                                                                    100.h,
                                                                    372.w,
                                                                    1,
                                                                  )
                                                                : CachedNetworkImageShare(
                                                                    authController
                                                                        .getCitiesSelect
                                                                        .value
                                                                        .normalPlat!,
                                                                    100.h,
                                                                    372.w,
                                                                    1),
                                                          ),
                                                    uploadAdsController
                                                                .indexType ==
                                                            1
                                                        ? Stack(
                                                            children: [
                                                              Positioned(
                                                                top: 60.h,
                                                                left: 80.w,
                                                                child: Row(
                                                                  children: [
                                                                    CustomText(
                                                                      uploadAdsController
                                                                          .codeV,
                                                                      fontSize:
                                                                          24.sp,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Positioned(
                                                                top: 120.h,
                                                                right: 110.w,
                                                                child: Row(
                                                                  children: [
                                                                    CustomText(
                                                                      uploadAdsController
                                                                          .vNumber,
                                                                      fontSize:
                                                                          24.sp,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : uploadAdsController
                                                                    .indexNumberType ==
                                                                1
                                                            ? authController
                                                                            .getCitiesSelect
                                                                            .value
                                                                            .id
                                                                            .toString() ==
                                                                        "1" &&
                                                                    SPHelper.spHelper
                                                                            .getLanguage() ==
                                                                        "en"
                                                                ? Container(
                                                                    width:
                                                                        372.w,
                                                                    height:
                                                                        80.h,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              14.w),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          CustomText(
                                                                            uploadAdsController.codeV,
                                                                            fontSize:
                                                                                35.sp,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                50.w,
                                                                          ),
                                                                          CustomText(
                                                                            uploadAdsController.vNumber,
                                                                            fontSize:
                                                                                35.sp,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                : authController.getCitiesSelect.value.id.toString() ==
                                                                            "1" &&
                                                                        SPHelper.spHelper.getLanguage() ==
                                                                            "ar"
                                                                    ? Container(
                                                                        width:
                                                                            372.w,
                                                                        height:
                                                                            80.h,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 14.w),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              CustomText(
                                                                                uploadAdsController.vNumber,
                                                                                fontSize: 35.sp,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 50.w,
                                                                              ),
                                                                              CustomText(
                                                                                uploadAdsController.codeV,
                                                                                fontSize: 35.sp,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 30.w,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : authController.getCitiesSelect.value.id.toString() ==
                                                                                "2" &&
                                                                            SPHelper.spHelper.getLanguage() ==
                                                                                "en"
                                                                        ? Container(
                                                                            width:
                                                                                372.w,
                                                                            height:
                                                                                95.h,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.only(left: 45.w, right: 80.w),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  CustomText(
                                                                                    uploadAdsController.codeV,
                                                                                    fontSize: 35.sp,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 20.w,
                                                                                  ),
                                                                                  CustomText(
                                                                                    uploadAdsController.vNumber,
                                                                                    fontSize: 35.sp,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : authController.getCitiesSelect.value.id.toString() == "2" &&
                                                                                SPHelper.spHelper.getLanguage() == "ar"
                                                                            ? Container(
                                                                                width: 372.w,
                                                                                height: 95.h,
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(left: 45.w, right: 80.w),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      CustomText(
                                                                                        uploadAdsController.vNumber,
                                                                                        fontSize: 35.sp,
                                                                                      ),
                                                                                      CustomText(
                                                                                        uploadAdsController.codeV,
                                                                                        fontSize: 35.sp,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            : authController.getCitiesSelect.value.id.toString() == "2" && SPHelper.spHelper.getLanguage() == "en"
                                                                                ? Container(
                                                                                    width: 372.w,
                                                                                    height: 80.h,
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.only(left: 20.w, right: 80.w),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          CustomText(
                                                                                            uploadAdsController.vNumber,
                                                                                            fontSize: 35.sp,
                                                                                          ),
                                                                                          CustomText(
                                                                                            uploadAdsController.codeV,
                                                                                            fontSize: 35.sp,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : authController.getCitiesSelect.value.id.toString() == "3" && SPHelper.spHelper.getLanguage() == "en"
                                                                                    ? Container(
                                                                                        width: 372.w,
                                                                                        height: 80.h,
                                                                                        child: Row(
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              width: 20.w,
                                                                                            ),
                                                                                            CustomText(
                                                                                              uploadAdsController.codeV,
                                                                                              fontSize: 35.sp,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 160.w,
                                                                                            ),
                                                                                            CustomText(
                                                                                              uploadAdsController.vNumber,
                                                                                              fontSize: 35.sp,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      )
                                                                                    : authController.getCitiesSelect.value.id.toString() == "3" && SPHelper.spHelper.getLanguage() == "ar"
                                                                                        ? Container(
                                                                                            width: 372.w,
                                                                                            height: 80.h,
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: [
                                                                                                CustomText(
                                                                                                  uploadAdsController.vNumber,
                                                                                                  fontSize: 35.sp,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: 150.w,
                                                                                                ),
                                                                                                CustomText(
                                                                                                  uploadAdsController.codeV,
                                                                                                  fontSize: 35.sp,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: 20.w,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          )
                                                                                        : authController.getCitiesSelect.value.id.toString() == "4" && SPHelper.spHelper.getLanguage() == "en"
                                                                                            ? Container(
                                                                                                width: 372.w,
                                                                                                height: 80.h,
                                                                                                child: Row(
                                                                                                  children: [
                                                                                                    SizedBox(
                                                                                                      width: 35.h,
                                                                                                    ),
                                                                                                    CustomText(
                                                                                                      uploadAdsController.codeV,
                                                                                                      fontSize: 35.sp,
                                                                                                      color: AppColors.whiteColor,
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      width: 130.h,
                                                                                                    ),
                                                                                                    CustomText(
                                                                                                      uploadAdsController.vNumber,
                                                                                                      fontSize: 35.sp,
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              )
                                                                                            : authController.getCitiesSelect.value.id.toString() == "4" && SPHelper.spHelper.getLanguage() == "ar"
                                                                                                ? Container(
                                                                                                    width: 372.w,
                                                                                                    height: 80.h,
                                                                                                    child: Row(
                                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                                      children: [
                                                                                                        CustomText(
                                                                                                          uploadAdsController.vNumber,
                                                                                                          fontSize: 35.sp,
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          width: 130.h,
                                                                                                        ),
                                                                                                        CustomText(
                                                                                                          uploadAdsController.codeV,
                                                                                                          fontSize: 35.sp,
                                                                                                          color: AppColors.whiteColor,
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          width: 39.h,
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  )
                                                                                                : authController.getCitiesSelect.value.id.toString() == "5" && SPHelper.spHelper.getLanguage() == "en"
                                                                                                    ? Container(
                                                                                                        width: 372.w,
                                                                                                        height: 80.h,
                                                                                                        child: Row(
                                                                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                          children: [
                                                                                                            SizedBox(
                                                                                                              width: 40.w,
                                                                                                            ),
                                                                                                            CustomText(
                                                                                                              uploadAdsController.codeV,
                                                                                                              fontSize: 35.sp,
                                                                                                              color: AppColors.black,
                                                                                                            ),
                                                                                                            SizedBox(
                                                                                                              width: 130.h,
                                                                                                            ),
                                                                                                            CustomText(
                                                                                                              uploadAdsController.vNumber,
                                                                                                              fontSize: 35.sp,
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      )
                                                                                                    : authController.getCitiesSelect.value.id.toString() == "5" && SPHelper.spHelper.getLanguage() == "ar"
                                                                                                        ? Container(
                                                                                                            width: 372.w,
                                                                                                            height: 80.h,
                                                                                                            child: Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                              children: [
                                                                                                                CustomText(
                                                                                                                  uploadAdsController.vNumber,
                                                                                                                  fontSize: 35.sp,
                                                                                                                ),
                                                                                                                SizedBox(
                                                                                                                  width: 130.h,
                                                                                                                ),
                                                                                                                CustomText(
                                                                                                                  uploadAdsController.codeV,
                                                                                                                  fontSize: 35.sp,
                                                                                                                  color: AppColors.black,
                                                                                                                ),
                                                                                                                SizedBox(
                                                                                                                  width: 40.w,
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          )
                                                                                                        : authController.getCitiesSelect.value.id.toString() == "6" && SPHelper.spHelper.getLanguage() == "en"
                                                                                                            ? Container(
                                                                                                                width: 372.w,
                                                                                                                height: 80.h,
                                                                                                                child: Row(
                                                                                                                  children: [
                                                                                                                    SizedBox(
                                                                                                                      width: 20.h,
                                                                                                                    ),
                                                                                                                    CustomText(
                                                                                                                      uploadAdsController.codeV,
                                                                                                                      fontSize: 35.sp,
                                                                                                                      color: AppColors.black,
                                                                                                                    ),
                                                                                                                    SizedBox(
                                                                                                                      width: 130.h,
                                                                                                                    ),
                                                                                                                    CustomText(
                                                                                                                      uploadAdsController.vNumber,
                                                                                                                      fontSize: 35.sp,
                                                                                                                    ),
                                                                                                                  ],
                                                                                                                ),
                                                                                                              )
                                                                                                            : authController.getCitiesSelect.value.id.toString() == "6" && SPHelper.spHelper.getLanguage() == "ar"
                                                                                                                ? Container(
                                                                                                                    width: 372.w,
                                                                                                                    height: 80.h,
                                                                                                                    child: Row(
                                                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                                                      children: [
                                                                                                                        CustomText(
                                                                                                                          uploadAdsController.vNumber,
                                                                                                                          fontSize: 35.sp,
                                                                                                                        ),
                                                                                                                        SizedBox(
                                                                                                                          width: 130.w,
                                                                                                                        ),
                                                                                                                        CustomText(
                                                                                                                          uploadAdsController.codeV,
                                                                                                                          fontSize: 35.sp,
                                                                                                                          color: AppColors.black,
                                                                                                                        ),
                                                                                                                        SizedBox(
                                                                                                                          width: 30.w,
                                                                                                                        ),
                                                                                                                      ],
                                                                                                                    ),
                                                                                                                  )
                                                                                                                : authController.getCitiesSelect.value.id.toString() == "8" && SPHelper.spHelper.getLanguage() == "en"
                                                                                                                    ? Container(
                                                                                                                        width: 372.w,
                                                                                                                        height: 95.h,
                                                                                                                        child: Row(
                                                                                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                          children: [
                                                                                                                            SizedBox(
                                                                                                                              width: 40.w,
                                                                                                                            ),
                                                                                                                            CustomText(
                                                                                                                              uploadAdsController.codeV,
                                                                                                                              fontSize: 35.sp,
                                                                                                                              color: AppColors.black,
                                                                                                                            ),
                                                                                                                            SizedBox(
                                                                                                                              width: 20.w,
                                                                                                                            ),
                                                                                                                            CustomText(
                                                                                                                              uploadAdsController.vNumber,
                                                                                                                              fontSize: 35.sp,
                                                                                                                            ),
                                                                                                                          ],
                                                                                                                        ),
                                                                                                                      )
                                                                                                                    : authController.getCitiesSelect.value.id.toString() == "8" && SPHelper.spHelper.getLanguage() == "ar"
                                                                                                                        ? Container(
                                                                                                                            width: 372.w,
                                                                                                                            height: 95.h,
                                                                                                                            child: Row(
                                                                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                              children: [
                                                                                                                                CustomText(
                                                                                                                                  uploadAdsController.vNumber,
                                                                                                                                  fontSize: 35.sp,
                                                                                                                                ),
                                                                                                                                SizedBox(
                                                                                                                                  width: 20.w,
                                                                                                                                ),
                                                                                                                                CustomText(
                                                                                                                                  uploadAdsController.codeV,
                                                                                                                                  fontSize: 35.sp,
                                                                                                                                  color: AppColors.black,
                                                                                                                                ),
                                                                                                                              ],
                                                                                                                            ),
                                                                                                                          )
                                                                                                                        : SizedBox()
                                                            // classic
                                                            : authController.getCitiesSelect.value.id.toString() == "1"
                                                                ? Container(
                                                                    width:
                                                                        372.w,
                                                                    height:
                                                                        80.h,
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              15.h,
                                                                        ),
                                                                        CustomText(
                                                                          uploadAdsController.codeV ??
                                                                              "",
                                                                          fontSize:
                                                                              18.sp,
                                                                          color:
                                                                              AppColors.whiteColor,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              100.h,
                                                                        ),
                                                                        CustomText(
                                                                          uploadAdsController
                                                                              .vNumber,
                                                                          fontSize:
                                                                              24.sp,
                                                                          color:
                                                                              AppColors.whiteColor,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                : authController.getCitiesSelect.value.id.toString() == "2"
                                                                    ? Container(
                                                                        // color: AppColors
                                                                        //     .red,
                                                                        width:
                                                                            320.w,
                                                                        height:
                                                                            80.h,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            // SizedBox(
                                                                            //   width: 10.h,
                                                                            // ),
                                                                            // CustomText(
                                                                            //   uploadAdsController.codeV,
                                                                            //   fontSize: 24.sp,
                                                                            //   color: AppColors.black,
                                                                            // ),
                                                                            // SizedBox(
                                                                            //   width: 20.h,
                                                                            // ),
                                                                            CustomText(
                                                                            uploadAdsController.vNumber,
                                                                              fontSize: 24.sp,
                                                                              color: AppColors.black,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    : authController.getCitiesSelect.value.id.toString() == "3"
                                                                        ? Container(
                                                                            width:
                                                                                372.w,
                                                                            height:
                                                                                80.h,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                // SizedBox(
                                                                                //   width:
                                                                                //       10.h,
                                                                                // ),
                                                                                // CustomText(
                                                                                //   code,
                                                                                //   fontSize:
                                                                                //       18.sp,
                                                                                //   color: AppColors
                                                                                //       .whiteColor,
                                                                                // ),

                                                                                CustomText(
                                                                                  uploadAdsController.vNumber,
                                                                                  fontSize: 24.sp,
                                                                                  color: AppColors.whiteColor,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        : authController.getCitiesSelect.value.id.toString() == "4" && SPHelper.spHelper.getLanguage() == "en"
                                                                            ? Container(
                                                                                width: Get.width,
                                                                                height: 160.h,
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(bottom: 60.h, left: 50.w, right: 40.w),
                                                                                  child: Row(
                                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      CustomText(
                                                                                        uploadAdsController.vNumber,
                                                                                        fontSize: 22.sp,
                                                                                        color: AppColors.black,
                                                                                      ),
                                                                                      CustomText(
                                                                                        Helper().replaceEnglishNumber(uploadAdsController.vNumber!),
                                                                                        fontSize: 22.sp,
                                                                                        color: AppColors.black,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            : authController.getCitiesSelect.value.id.toString() == "4" && SPHelper.spHelper.getLanguage() == "ar"
                                                                                ? Container(
                                                                                    width: Get.width,
                                                                                    height: 160.h,
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.only(bottom: 60.h, left: 50.w, right: 40.w),
                                                                                      child: Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          CustomText(
                                                                                            Helper().replaceEnglishNumber(uploadAdsController.vNumber!),
                                                                                            fontSize: 22.sp,
                                                                                            color: AppColors.black,
                                                                                          ),
                                                                                          CustomText(
                                                                                            uploadAdsController.vNumber,
                                                                                            fontSize: 22.sp,
                                                                                            color: AppColors.black,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : authController.getCitiesSelect.value.id.toString() == "5"
                                                                                    ? Container(
                                                                                        width: 372.w,
                                                                                        height: 80.h,
                                                                                        child: Row(
                                                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              width: 30.h,
                                                                                            ),
                                                                                            CustomText(
                                                                                              uploadAdsController.codeV,
                                                                                              fontSize: 24.sp,
                                                                                              color: AppColors.black,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 150.h,
                                                                                            ),
                                                                                            CustomText(
                                                                                              uploadAdsController.vNumber,
                                                                                              fontSize: 24.sp,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      )
                                                                                    : authController.getCitiesSelect.value.id.toString() == "6"
                                                                                        ? Container(
                                                                                            width: 372.w,
                                                                                            height: 80.h,
                                                                                            child: Row(
                                                                                              children: [
                                                                                                SizedBox(
                                                                                                  width: 20.h,
                                                                                                ),
                                                                                                CustomText(
                                                                                                  uploadAdsController.codeV,
                                                                                                  fontSize: 24.sp,
                                                                                                  color: AppColors.black,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: 130.h,
                                                                                                ),
                                                                                                CustomText(
                                                                                                  uploadAdsController.vNumber,
                                                                                                  fontSize: 24.sp,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          )
                                                                                        : authController.getCitiesSelect.value.id.toString() == "8"
                                                                                            ? Container(
                                                                                                width: 372.w,
                                                                                                height: 100.h,
                                                                                                child: Row(
                                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    CustomText(
                                                                                                      uploadAdsController.codeV,
                                                                                                      fontSize: 24.sp,
                                                                                                      color: AppColors.black,
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      width: 20.h,
                                                                                                    ),
                                                                                                    CustomText(
                                                                                                      uploadAdsController.vNumber,
                                                                                                      fontSize: 24.sp,
                                                                                                      color: AppColors.whiteColor,
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              )
                                                                                            : SizedBox()
                                                  ],
                                                ),
                                              )),
                                            ),
                                          )

                                          // CustomPngImage(
                                          //   width: Get.width,
                                          //   height: 126.h,
                                          //   imageName: "number",
                                          ,
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
                                                  "Vehicle Number Details",
                                                  fontSize: 16.sp,
                                                  fontFamily: "tajawalb",
                                                ),
                                                SizedBox(
                                                  height: 16.h,
                                                ),
                                                Row(
                                                  children: [
                                                    CustomText(
                                                      "Vehicle Type",
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors.grey,
                                                    ),
                                                    Spacer(),
                                                    CustomText(
                                                      uploadAdsController
                                                          .vehicleType.value,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 14.h,
                                                ),
                                                Row(
                                                  children: [
                                                    CustomText(
                                                      "City",
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors.grey,
                                                    ),
                                                    Spacer(),
                                                    CustomText(
                                                      SPHelper.spHelper
                                                                  .getLanguage() ==
                                                              "en"
                                                          ? authController
                                                              .getCitiesSelect
                                                              .value
                                                              .nameEn
                                                          : authController
                                                              .getCitiesSelect
                                                              .value
                                                              .name,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 14.h,
                                                ),
                                                Row(
                                                  children: [
                                                    CustomText(
                                                      "Number Type",
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors.grey,
                                                    ),
                                                    Spacer(),
                                                    CustomText(
                                                      uploadAdsController
                                                          .numberType.value,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 14.h,
                                                ),
                                                uploadAdsController
                                                            .indexNumberType ==
                                                        0
                                                    ? SizedBox()
                                                    : Row(
                                                        children: [
                                                          CustomText(
                                                            "Code",
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                AppColors.grey,
                                                          ),
                                                          Spacer(),
                                                          CustomText(
                                                            uploadAdsController
                                                                    .codeV ??
                                                                "",
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ],
                                                      ),
                                                SizedBox(
                                                  height: 14.h,
                                                ),
                                                Row(
                                                  children: [
                                                    CustomText(
                                                      "Vehicle Number",
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors.grey,
                                                    ),
                                                    Spacer(),
                                                    CustomText(
                                                      uploadAdsController
                                                          .vNumber,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors.grey,
                                                    ),
                                                    Spacer(),
                                                    CustomText(
                                                      uploadAdsController
                                                          .mobileV,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors.grey,
                                                    ),
                                                    Spacer(),
                                                    CustomText(
                                                      uploadAdsController
                                                          .whatsV,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 27.h,
                                                ),
                                                CustomText(
                                                  "Description",
                                                  fontSize: 16.sp,
                                                  fontFamily: "tajawalb",
                                                ),
                                                SizedBox(
                                                  height: 14.h,
                                                ),
                                                CustomText(
                                                  uploadAdsController.descV,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )));
                  })
                ]);
          }),
    );
  }
}
