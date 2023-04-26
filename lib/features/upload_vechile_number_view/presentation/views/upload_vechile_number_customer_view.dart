import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/core/widgets/custom_text_form_field.dart';
import 'package:car_rental/features/car_paint_color_view/presentation/views/car_paint_color_view.dart';
import 'package:car_rental/features/choose_brand_view/presentation/views/choose_brand_view.dart';
import 'package:car_rental/features/choose_car_condition_view/presentation/views/choose_car_condition_view.dart';
import 'package:car_rental/features/choose_car_model_view.dart/presentation/views/choose_car_model_view.dart';
import 'package:car_rental/features/choose_country_view/data/data_souces/cities_data_source.dart';
import 'package:car_rental/features/choose_country_view/presentation/views/choose_country_view.dart';
import 'package:car_rental/features/number_type_view/presentation/views/number_type_view.dart';
import 'package:car_rental/features/upload_car_view/presentation/widgets/stepper_car.dart';
import 'package:car_rental/features/upload_car_view/presentation/widgets/upload_widget.dart';
import 'package:car_rental/features/upload_vehicle_number_customer_view/widgets/stepper_vehicle_number.dart';
import 'package:car_rental/features/vehicle_type_view/presentation/views/vehicle_type_view.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UploadVechileNumberCustomerView extends StatelessWidget {
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
                      if (controller.indexVehicleNumberStepper == 0) {
                        controller.setIndexVehicleNumberStepper(1);
                      } else if (controller.indexVehicleNumberStepper == 1) {
                        controller.setIndexVehicleNumberStepper(2);
                      } else {
                        Get.back();
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
                  Expanded(
                      child: SingleChildScrollView(
                          child: controller.indexVehicleNumberStepper == 0
                              ? Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        UploadWidget(
                                          title: "Vehicle Type",
                                          onTap: () {
                                            Get.to(() => VehcileTypeView());
                                          },
                                        ),
                                        UploadWidget(
                                          onTap: () {
                                            citiesDataSource();
                                            Get.to(() => ChooseCountryView());
                                          },
                                          title: "City",
                                        ),
                                        UploadWidget(
                                          title: "Number Type",
                                          onTap: () {
                                            Get.to(() => NumberTypeView());
                                          },
                                        ),
                                        UploadWidget(
                                          onTap: () {},
                                          title: "Vehicle Number",
                                        ),
                                        CustomTextFormField(
                                          height: 2,
                                          hint: "Code",
                                        ),
                                      ]),
                                )
                              : controller.indexVehicleNumberStepper == 1
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: Get.width,
                                            height: 59.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                                border: Border.all(
                                                    color: AppColors.grey)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w),
                                              child: Row(children: [
                                                Expanded(
                                                    child: TextFormField(
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText:
                                                          "Your Mobile Number"
                                                              .tr,
                                                      helperStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AppColors.grey,
                                                          fontFamily: "tajawal",
                                                          fontSize: 15.sp)),
                                                )),
                                                CustomSvgImage(
                                                  imageName: "call",
                                                  color: AppColors.primaryColor,
                                                  height: 22.h,
                                                  width: 22.w,
                                                ),
                                              ]),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.h,
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
                                                "Optional",
                                                fontSize: 8.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.grey,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Container(
                                            width: Get.width,
                                            height: 59.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                                border: Border.all(
                                                    color: AppColors.grey)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w),
                                              child: Row(children: [
                                                Expanded(
                                                    child: TextFormField(
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: "Your Whatsapp",
                                                      helperStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AppColors.grey,
                                                          fontFamily: "tajawal",
                                                          fontSize: 15.sp)),
                                                )),
                                                CustomSvgImage(
                                                  imageName: "whatsapp",
                                                  color: AppColors.primaryColor,
                                                  height: 20.h,
                                                  width: 20.w,
                                                ),
                                              ]),
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
                                            hint: "",
                                            maxLines: 4,
                                            minLines: 1,
                                            textInputType:
                                                TextInputType.multiline,
                                          ),
                                        ],
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
                                                "Ahmed7082",
                                                fontSize: 16.sp,
                                                fontFamily: "tajawalb",
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        CustomPngImage(
                                          width: Get.width,
                                          height: 126.h,
                                          imageName: "number",
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
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.grey,
                                                  ),
                                                  Spacer(),
                                                  CustomText(
                                                    "Vehicle Type",
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
                                                    "Dubai",
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
                                                    "Number Type",
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.grey,
                                                  ),
                                                  Spacer(),
                                                  CustomText(
                                                    "Classic",
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
                                                    "Code",
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.grey,
                                                  ),
                                                  Spacer(),
                                                  CustomText(
                                                    "W",
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
                                                    "Vehicle Number",
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.grey,
                                                  ),
                                                  Spacer(),
                                                  CustomText(
                                                    "1959 ",
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
                                                    "+971582826443",
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
                                                    "+971557775532",
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ],
                                              ),
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
