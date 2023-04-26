import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/core/widgets/custom_text_form_field.dart';
import 'package:car_rental/features/calculator_view/data/data_sources/calculate_data_source.dart';
import 'package:car_rental/features/choose_brand_view/data/data_sources/get_brands_data_source.dart';
import 'package:car_rental/features/choose_brand_view/presentation/views/choose_brand_view.dart';
import 'package:car_rental/features/choose_car_condition_view/presentation/views/choose_car_condition_view.dart';
import 'package:car_rental/features/choose_country_view/data/data_souces/cities_data_source.dart';
import 'package:car_rental/features/choose_country_view/presentation/views/choose_country_view.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_profile_data_source.dart';
import 'package:car_rental/features/sim_type_view/presentation/views/sim_type_view.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/data_sources/update_ads_data_source.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/data_sources/upload_ads_data_source.dart';
import 'package:car_rental/features/upload_car_parts_view/presentation/widgets/stepper_car_parts.dart';
import 'package:car_rental/features/upload_car_view/data/data_sources/choose_plan_data_source.dart';
import 'package:car_rental/features/upload_car_view/presentation/widgets/upload_widget.dart';
import 'package:car_rental/features/upload_mobile_number_customer_view/presentation/widgets/stepper_mobile_number.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UpdateCarPartsView extends StatefulWidget {
  @override
  State<UpdateCarPartsView> createState() => _UpdateCarPartsViewState();
}

class _UpdateCarPartsViewState extends State<UpdateCarPartsView> {
  ProfileController profileController = Get.find();
  UploadAdsController uploadAdsController = Get.find();
  AuthController authController = Get.find();
  String? mobile, whatsapp, desc;

  final formKey = GlobalKey<FormState>();

  final formKey1 = GlobalKey<FormState>();

  validation(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return 'This field is required*'.tr;
    }
  }

  setMobile(String value) {
    this.mobile = value;
  }

  setWhats(String value) {
    this.whatsapp = value;
  }

  setDesc(String value) {
    this.desc = value;
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
                      if (controller.indexCarPartsStepper == 0) {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          controller.setIndexCarPartsStepper(1);
                        }
                      } else if (controller.indexCarPartsStepper == 1) {
                        updateAdsDataSource(
                            product_id: homeController
                                .getProductByIdData.value.data!.id
                                .toString(),
                            category_id: "6",
                            city_id: authController.getCitiesSelect.value.id
                                .toString(),
                            address: uploadAdsController.address,
                            content: desc,
                            description: desc,
                            phone: mobile,
                            brand_id: authController.getBrabdSelect.value.id
                                .toString(),
                            photo_link: authController.getBrabdSelect.value.logo
                                .toString(),

                            // service_id: "1",

                            whatsapp: whatsapp);
                      } else {}
                    },
                    width: 329.w,
                    height: 59.h,
                    title: controller.indexCarPartsStepper == 1
                        ? "Update Now"
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
                      controller.indexCarPartsStepper == 0
                          ? "Update Car Parts"
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
              StepperCarParts(controller.indexCarPartsStepper),
              SizedBox(
                height: 30.h,
              ),
              Obx(() {
                return homeController.getProductByIdData.value.code == null
                    ? Helper.loading()
                    : Expanded(
                        child: SingleChildScrollView(
                            child: controller.indexCarPartsStepper == 0
                                ? Form(
                                    key: formKey,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Column(children: [
                                        UploadWidget(
                                          onTap: () {
                                            authController.searchData.clear();
                                            getBrandsDataSource();
                                            controller.setIndexBrand(-1);
                                            Get.to(() => ChooseBrandView());
                                          },
                                          title: authController.getBrabdSelect
                                                      .value.name ==
                                                  null
                                              ? "Brand Car Parts"
                                              : authController
                                                  .getBrabdSelect.value.name,
                                          isBlack: authController
                                                  .getBrabdSelect.value.name !=
                                              null,
                                        ),
                                        Obx(() => UploadWidget(
                                              onTap: () {
                                                citiesDataSource();
                                                authController.setIndexCity(-1);
                                                Get.to(
                                                    () => ChooseCountryView());
                                              },
                                              title: authController
                                                          .getCitiesSelect
                                                          .value
                                                          .name ==
                                                      null
                                                  ? "City"
                                                  : authController
                                                      .getCitiesSelect
                                                      .value
                                                      .name,
                                              isBlack: authController
                                                      .getCitiesSelect
                                                      .value
                                                      .name !=
                                                  null,
                                            )),
                                        CustomTextFormField(
                                          textInputType: TextInputType.number,
                                          hint: "Mobile Number",
                                          height: 2,
                                          validator: validation,
                                          onSaved: setMobile,
                                          initial: homeController
                                              .getProductByIdData
                                              .value
                                              .data!
                                              .phone!,
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
                                          height: 20.h,
                                        ),
                                        CustomTextFormField(
                                          hint: "Whatsapp Number",
                                          height: 2,
                                          validator: validation,
                                          onSaved: setWhats,
                                          initial: homeController
                                              .getProductByIdData
                                              .value
                                              .data!
                                              .whatsapp!,
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
                                          onSaved: setDesc,
                                          validator: validation,
                                          initial: homeController
                                              .getProductByIdData
                                              .value
                                              .data!
                                              .description!,
                                          textInputType:
                                              TextInputType.multiline,
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                      ]),
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
                                            child: Image.network(
                                          authController
                                              .getBrabdSelect.value.logo!,
                                          height: 150.h,
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
                                              "Car Parts Details",
                                              fontSize: 16.sp,
                                              fontFamily: "tajawalb",
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Row(
                                              children: [
                                                CustomText(
                                                  "Brand Car Parts",
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey,
                                                ),
                                                Spacer(),
                                                CustomText(
                                                  authController.getBrabdSelect
                                                      .value.name,
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
                                                  "Mobile Number ",
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey,
                                                ),
                                                Spacer(),
                                                CustomText(
                                                  mobile,
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
                                                  whatsapp,
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
                                                  "City",
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey,
                                                ),
                                                Spacer(),
                                                CustomText(
                                                  authController.getCitiesSelect
                                                      .value.name,
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
                                              desc,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.grey,
                                            )
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
