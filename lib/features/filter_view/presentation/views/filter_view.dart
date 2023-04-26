import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/features/cars_view/data/data_sources/products_by_category_data_source.dart';
import 'package:car_rental/features/choose_brand_view/data/data_sources/get_brands_data_source.dart';
import 'package:car_rental/features/choose_brand_view/presentation/views/choose_brand_view.dart';
import 'package:car_rental/features/choose_car_condition_view/presentation/views/choose_car_condition_view.dart';
import 'package:car_rental/features/choose_car_model_view.dart/data/data_sources/get_cars_model_data_source.dart';
import 'package:car_rental/features/choose_car_model_view.dart/presentation/views/choose_car_model_view.dart';
import 'package:car_rental/features/choose_car_year_view/data/data_sources/production_year_data_source.dart';
import 'package:car_rental/features/choose_car_year_view/presentation/views/choose_car_year_view.dart';
import 'package:car_rental/features/choose_country_view/data/data_souces/cities_data_source.dart';
import 'package:car_rental/features/choose_country_view/presentation/views/choose_country_view.dart';
import 'package:car_rental/features/my_ads_view/data/data_sources/my_ads_data_source.dart';
import 'package:car_rental/features/sim_type_view/presentation/views/sim_type_view.dart';
import 'package:car_rental/features/vehicle_type_view/presentation/views/vehicle_type_view.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterView extends StatefulWidget {
  String id;
  FilterView(this.id);
  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  AuthController authController = Get.find();
  UploadAdsController uploadAdsController = Get.find();
  SfRangeValues _values = SfRangeValues(15000.0, 300000.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 60.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Get.back();
                },
              ),
              CustomText(
                "Filters",
                fontFamily: "tajawalb",
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.transparent,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Expanded(
            child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                "Price Range :",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 12.h,
              ),
              SfRangeSlider(
                min: 2000.0,
                max: 5000000.0,
                values: _values,
                showTicks: false,
                showLabels: false,
                enableTooltip: true,
                minorTicksPerInterval: 1000,
                stepSize: 500,
                activeColor: AppColors.primaryColor,
                inactiveColor: AppColors.grey,
                onChanged: (SfRangeValues values) {
                  setState(() {
                    _values = values;
                  });
                },
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  CustomText(
                    "From :",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomText(
                    " 5000 ",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomText(
                    "AED",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  Spacer(),
                  CustomText(
                    "To :",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomText(
                    " 5000000 ",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomText(
                    "AED",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Obx(() {
                return Column(
                  children: [
                    widget.id == "1" || widget.id == "2" || widget.id == "9"
                        ? Row(
                            children: [
                              CustomText(
                                "Brand :",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  getBrandsDataSource();
                                  Get.to(() => ChooseBrandView());
                                },
                                child: Container(
                                  width: 117.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xffBFBFBF),
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(18.r)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 12.r,
                                            color: Colors.transparent,
                                          ),
                                          CustomText(
                                            authController.getBrabdSelect.value
                                                        .name ==
                                                    null
                                                ? "All"
                                                : authController
                                                    .getBrabdSelect.value.name,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 12.r,
                                          ),
                                        ]),
                                  ),
                                ),
                              )
                            ],
                          )
                        : widget.id == "3"
                            ? Row(
                                children: [
                                  CustomText(
                                    "Sim Type :",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      uploadAdsController.setIndexSimType(-1);
                                      Get.to(() => SimTypeView());
                                    },
                                    child: Container(
                                      width: 117.w,
                                      height: 35.h,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xffBFBFBF),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(18.r)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 12.r,
                                                color: Colors.transparent,
                                              ),
                                              CustomText(
                                                uploadAdsController
                                                            .simType.value ==
                                                        ""
                                                    ? "All"
                                                    : uploadAdsController
                                                        .simType.value,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 12.r,
                                              ),
                                            ]),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : widget.id == "4"
                                ? Row(
                                    children: [
                                      CustomText(
                                        "Vehicle Type",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          // uploadAdsController.vehicleType(-1);
                                          Get.to(() => VehcileTypeView());
                                        },
                                        child: Container(
                                          width: 117.w,
                                          height: 35.h,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color(0xffBFBFBF),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(18.r)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.w),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 12.r,
                                                    color: Colors.transparent,
                                                  ),
                                                  CustomText(
                                                    uploadAdsController
                                                                .vehicleType
                                                                .value ==
                                                            ""
                                                        ? "All"
                                                        : uploadAdsController
                                                            .vehicleType.value,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 12.r,
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : SizedBox(),
                    widget.id == "3"
                        ? SizedBox()
                        : SizedBox(
                            height: 40.h,
                          ),
                    widget.id == "3"
                        ? SizedBox()
                        : widget.id == "4"
                            ? Row(
                                children: [
                                  CustomText(
                                    "Number Type",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      // getCarsModelDataSource(authController
                                      //     .getBrabdSelect.value.id
                                      //     .toString());
                                      // Get.to(() => ChooseCarModelView());
                                    },
                                    child: Container(
                                      width: 117.w,
                                      height: 35.h,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xffBFBFBF),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(18.r)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 12.r,
                                                color: Colors.transparent,
                                              ),
                                              CustomText(
                                                uploadAdsController
                                                            .numberType.value !=
                                                        ""
                                                    ? uploadAdsController
                                                        .numberType.value
                                                    : "All",
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 12.r,
                                              ),
                                            ]),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  CustomText(
                                    "Model :",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      getCarsModelDataSource(authController
                                          .getBrabdSelect.value.id
                                          .toString());
                                      Get.to(() => ChooseCarModelView());
                                    },
                                    child: Container(
                                      width: 117.w,
                                      height: 35.h,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xffBFBFBF),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(18.r)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 12.r,
                                                color: Colors.transparent,
                                              ),
                                              CustomText(
                                                authController.getCarModelSelect
                                                            .value.name !=
                                                        null
                                                    ? authController
                                                        .getCarModelSelect
                                                        .value
                                                        .name
                                                    : "All",
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 12.r,
                                              ),
                                            ]),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                    widget.id == "3" || widget.id == "4"
                        ? SizedBox()
                        : SizedBox(
                            height: 40.h,
                          ),
                    widget.id == "3" || widget.id == "4"
                        ? SizedBox()
                        : Row(
                            children: [
                              CustomText(
                                "Production Year :",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  productionYearDataSource();
                                  Get.to(() => ChooseCarYearView());
                                },
                                child: Container(
                                  width: 117.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xffBFBFBF),
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(18.r)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 12.r,
                                            color: Colors.transparent,
                                          ),
                                          CustomText(
                                            uploadAdsController
                                                        .getProductionYearSelect
                                                        .value
                                                        .name !=
                                                    null
                                                ? uploadAdsController
                                                    .getProductionYearSelect
                                                    .value
                                                    .name
                                                : "All",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 12.r,
                                          ),
                                        ]),
                                  ),
                                ),
                              )
                            ],
                          ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      children: [
                        CustomText(
                          "Location :",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            // ();
                            citiesDataSource();
                            Get.to(() => ChooseCountryView());
                          },
                          child: Container(
                            width: 117.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffBFBFBF),
                                ),
                                borderRadius: BorderRadius.circular(18.r)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12.r,
                                      color: Colors.transparent,
                                    ),
                                    CustomText(
                                      authController
                                                  .getCitiesSelect.value.name !=
                                              null
                                          ? SPHelper.spHelper.getLanguage() ==
                                                  "en"
                                              ? authController
                                                  .getCitiesSelect.value.nameEn
                                              : authController
                                                  .getCitiesSelect.value.name
                                          : "All",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12.r,
                                    ),
                                  ]),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    if (widget.id != "9")
                      Row(
                        children: [
                          CustomText(
                            "Condition :",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => ChooseCarConditionView());
                            },
                            child: Container(
                              width: 117.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffBFBFBF),
                                  ),
                                  borderRadius: BorderRadius.circular(18.r)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12.r,
                                        color: Colors.transparent,
                                      ),
                                      CustomText(
                                        uploadAdsController.condition.value !=
                                                ""
                                            ? uploadAdsController
                                                .condition.value
                                            : "All",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12.r,
                                      ),
                                    ]),
                              ),
                            ),
                          )
                        ],
                      ),
                  ],
                );
              }),
              SizedBox(
                height: 100.h,
              ),
              CustomButton(
                width: Get.width,
                height: 59.h,
                title: "Filter",
                onTap: () {
                  getProductsByCategoryDataSource(
                    1,
                    true,
                    widget.id,
                    brand: authController.getBrabdSelect.value.id.toString(),
                    from_price: _values.start.toString(),
                    to_price: _values.end.toString(),
                  );
                  Get.back();
                },
              )
            ],
          ),
        ))
      ]),
    );
  }
}
