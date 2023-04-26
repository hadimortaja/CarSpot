import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/core/widgets/custom_text_form_field.dart';
import 'package:car_rental/features/calculator_view/data/data_sources/calculate_data_source.dart';
import 'package:car_rental/features/car_paint_color_view/presentation/views/car_paint_color_view.dart';
import 'package:car_rental/features/choose_brand_view/presentation/views/choose_brand_view.dart';
import 'package:car_rental/features/choose_car_condition_view/presentation/views/choose_car_condition_view.dart';
import 'package:car_rental/features/choose_car_model_view.dart/presentation/views/choose_car_model_view.dart';
import 'package:car_rental/features/choose_country_view/data/data_souces/cities_data_source.dart';
import 'package:car_rental/features/choose_country_view/presentation/views/choose_country_view.dart';
import 'package:car_rental/features/number_type_view/presentation/views/number_type_view.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_profile_data_source.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/data_sources/update_ads_data_source.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/data_sources/upload_ads_data_source.dart';
import 'package:car_rental/features/upload_car_view/data/data_sources/choose_plan_data_source.dart';
import 'package:car_rental/features/upload_car_view/presentation/widgets/stepper_car.dart';
import 'package:car_rental/features/upload_car_view/presentation/widgets/upload_widget.dart';
import 'package:car_rental/features/upload_vehicle_number_customer_view/widgets/stepper_vehicle_number.dart';
import 'package:car_rental/features/vehicle_type_view/presentation/views/vehicle_type_view.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UpdateVehicleNumberCustomerView extends StatelessWidget {
  UploadAdsController uploadAdsController = Get.find();
  String? vNumber, code, mobile, whats, desc, price;

  final formKey = GlobalKey<FormState>();

  final formKey1 = GlobalKey<FormState>();

  validation(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return 'This field is required*'.tr;
    }
  }

  setvNumber(String value) {
    this.vNumber = value;
  }

  setCode(String value) {
    this.code = value;
  }

  setMobile(String value) {
    this.mobile = value;
  }

  setWhats(String value) {
    this.whats = value;
  }

  setDesc(String value) {
    this.desc = value;
  }

  setPrice(String value) {
    this.price = value;
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
                      if (controller.indexVehicleNumberStepper == 0) {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          controller.setIndexVehicleNumberStepper(1);
                        }
                      } else if (controller.indexVehicleNumberStepper == 1) {
                        // if (formKey1.currentState!.validate()) {
                        formKey1.currentState!.save();
                        getProfileDataSource();
                        print(mobile);
                        // print(whatsapp);
                        // print(desc);
                        controller.setIndexVehicleNumberStepper(2);
                        // }
                      } else {
                        updateAdsDataSource(
                            product_id: homeController
                                .getProductByIdData.value.data!.id
                                .toString(),
                            category_id: "4",
                            address: authController.getCitiesSelect.value.name,
                            // condition: uploadAdsController.condition.value,
                            content: desc,
                            description: desc,
                            phone: mobile.toString(),
                            price: price.toString(),
                            vehicle_type: uploadAdsController.vehicleType.value,
                            city_id: authController.getCitiesSelect.value.id
                                .toString(),
                            code: code.toString(),
                            vehicle_number: vNumber.toString(),
                            number_type: uploadAdsController.numberType.value,

                            // service_id: "1",

                            whatsapp: whats);
                      }
                    },
                    width: 329.w,
                    height: 59.h,
                    title: controller.indexVehicleNumberStepper == 2
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
                              : "Update Vehicle Number",
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
                    return homeController.getProductByIdData.value.code == null
                        ? Helper.loading()
                        : Expanded(
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
                                                  title: controller.vehicleType
                                                              .value ==
                                                          ""
                                                      ? "Vehicle Type"
                                                      : controller
                                                          .vehicleType.value,
                                                  onTap: () {
                                                    controller.setIndexType(-1);
                                                    Get.to(
                                                        () => VehcileTypeView(
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
                                                    Get.to(() =>
                                                        ChooseCountryView());
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
                                                ),
                                                UploadWidget(
                                                  isBlack: uploadAdsController
                                                          .numberType.value !=
                                                      "",
                                                  title: uploadAdsController
                                                              .numberType
                                                              .value ==
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
                                                  onSaved: setvNumber,
                                                  validator: validation,
                                                  initial: homeController
                                                      .getProductByIdData
                                                      .value
                                                      .data!
                                                      .vehicleNumber,
                                                  textInputType:
                                                      TextInputType.number,
                                                ),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                CustomTextFormField(
                                                  height: 2,
                                                  hint: "Code",
                                                  onSaved: setCode,
                                                  // validator: validation,
                                                  initial: homeController
                                                      .getProductByIdData
                                                      .value
                                                      .data!
                                                      .code,
                                                ),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                CustomTextFormField(
                                                  height: 2,
                                                  hint: "Price",
                                                  onSaved: setPrice,
                                                  validator: validation,
                                                  initial: homeController
                                                      .getProductByIdData
                                                      .value
                                                      .data!
                                                      .price!,
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
                                                    onSaved: setMobile,
                                                    initial: homeController
                                                        .getProductByIdData
                                                        .value
                                                        .data!
                                                        .phone!,
                                                    textInputType:
                                                        TextInputType.number,
                                                    suffix: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w),
                                                      child: CustomSvgImage(
                                                        imageName: "call",
                                                        color: AppColors
                                                            .primaryColor,
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
                                                    textInputType:
                                                        TextInputType.number,
                                                    suffix: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w),
                                                      child: CustomSvgImage(
                                                        imageName: "whatsapp",
                                                        color: AppColors
                                                            .primaryColor,
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
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: AppColors
                                                                    .grey),
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      CustomText(
                                                        "Description",
                                                        fontSize: 8.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                              Container(
                                                width: Get.width,
                                                height: 200.h,
                                                child: Center(
                                                    child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12.w,
                                                  ),
                                                  child: Container(
                                                    width: Get.width,
                                                    height: 80.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                        border: Border.all(
                                                            color:
                                                                AppColors.black,
                                                            width: 2.w)),
                                                    child: authController
                                                                .getCitiesSelect
                                                                .value
                                                                .id
                                                                .toString() ==
                                                            "1"
                                                        ? Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        12.w),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  CustomText(
                                                                    code ?? "X",
                                                                    fontSize:
                                                                        27.sp,
                                                                  ),
                                                                  CustomText(
                                                                    vNumber ??
                                                                        "XXXXX",
                                                                    fontSize:
                                                                        27.sp,
                                                                  ),
                                                                  Image.network(
                                                                    authController
                                                                        .getCitiesSelect
                                                                        .value
                                                                        .logo!,
                                                                  ),
                                                                  // CachedNetworkImageShare(
                                                                  //     homeController
                                                                  //         .getProductByIdData
                                                                  //         .value
                                                                  //         .data!
                                                                  //         .city!
                                                                  //         .logo,
                                                                  //     80,
                                                                  //     60,
                                                                  //     1)
                                                                ]),
                                                          )
                                                        : authController
                                                                    .getCitiesSelect
                                                                    .value
                                                                    .id
                                                                    .toString() ==
                                                                "2"
                                                            ? Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            20.w),
                                                                child: Row(
                                                                    children: [
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Image
                                                                              .network(
                                                                            authController.getCitiesSelect.value.logo!,
                                                                            height:
                                                                                40.h,
                                                                          ),
                                                                          CustomText(
                                                                            code ??
                                                                                "X",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            60.w,
                                                                      ),
                                                                      CustomText(
                                                                          vNumber ??
                                                                              "XXXXX"),
                                                                    ]),
                                                              )
                                                            : authController
                                                                        .getCitiesSelect
                                                                        .value
                                                                        .id
                                                                        .toString() ==
                                                                    "3"
                                                                ?
//3
                                                                Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            20.w),
                                                                    child: Row(
                                                                        children: [
                                                                          CustomText(
                                                                            code ??
                                                                                "X",
                                                                            fontSize:
                                                                                33.sp,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                20.w,
                                                                          ),
                                                                          Image
                                                                              .network(
                                                                            authController.getCitiesSelect.value.logo!,
                                                                            height:
                                                                                60.h,
                                                                          ),
                                                                          Spacer(),
                                                                          CustomText(
                                                                            vNumber ??
                                                                                "XXXXX",
                                                                            fontSize:
                                                                                33.sp,
                                                                          ),
                                                                        ]),
                                                                  )
                                                                : authController
                                                                            .getCitiesSelect
                                                                            .value
                                                                            .id
                                                                            .toString() ==
                                                                        "4"
                                                                    ?

                                                                    //4
                                                                    Row(
                                                                        children: [
                                                                            Container(
                                                                              width: 60.w,
                                                                              height: Get.height,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.only(
                                                                                    topLeft: Radius.circular(5.r),
                                                                                    bottomLeft: Radius.circular(5.r),
                                                                                  ),
                                                                                  color: AppColors.primaryColor),
                                                                              child: Center(
                                                                                child: CustomText(
                                                                                  code ?? "X",
                                                                                  fontSize: 33.sp,
                                                                                  color: AppColors.whiteColor,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 20.w,
                                                                            ),
                                                                            Image.network(
                                                                              authController.getCitiesSelect.value.logo!,
                                                                              height: 60.h,
                                                                            ),
                                                                            Spacer(),
                                                                            CustomText(
                                                                              vNumber ?? "XXXXX",
                                                                              fontSize: 33.sp,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 20.w,
                                                                            ),
                                                                          ])
                                                                    : authController.getCitiesSelect.value.id.toString() ==
                                                                            "5"
                                                                        ? Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 12.w),
                                                                            child:
                                                                                Row(children: [
                                                                              CustomText(
                                                                                code ?? "X",
                                                                                fontSize: 33.sp,
                                                                                color: AppColors.black,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 20.w,
                                                                              ),
                                                                              Image.network(
                                                                                authController.getCitiesSelect.value.logo!,
                                                                                height: 60.h,
                                                                              ),
                                                                              Spacer(),
                                                                              CustomText(
                                                                                vNumber ?? "XXXXX",
                                                                                fontSize: 33.sp,
                                                                              ),
                                                                            ]),
                                                                          )
                                                                        :
                                                                        //6
                                                                        Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 12.w),
                                                                            child:
                                                                                Row(children: [
                                                                              CustomText(
                                                                                code ?? "X",
                                                                                fontSize: 33.sp,
                                                                                color: AppColors.black,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 20.w,
                                                                              ),
                                                                              Image.network(
                                                                                authController.getCitiesSelect.value.logo!,
                                                                                height: 60.h,
                                                                              ),
                                                                              Spacer(),
                                                                              CustomText(
                                                                                vNumber ?? "XXXXX",
                                                                                fontSize: 33.sp,
                                                                              ),
                                                                            ]),
                                                                          ),
                                                  ),
                                                )),
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
                                                              .vehicleType
                                                              .value,
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
                                                          authController
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
                                                    Row(
                                                      children: [
                                                        CustomText(
                                                          "Code",
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AppColors.grey,
                                                        ),
                                                        Spacer(),
                                                        CustomText(
                                                          code,
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
                                                          vNumber,
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
                                                          "Mobile Number ",
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AppColors.grey,
                                                        ),
                                                        Spacer(),
                                                        CustomText(
                                                          mobile,
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
                                                          whats,
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
                                                      whats,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
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
