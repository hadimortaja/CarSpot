import 'dart:developer';

import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/cached_network_image.dart';
import 'package:car_rental/features/car_ad_sale_view/data/data_sources/get_product_by_id_data_source.dart';
import 'package:car_rental/features/car_ad_sale_view/presentation/views/car_ad_sale_view.dart';
import 'package:car_rental/features/cars_view/data/data_sources/products_by_category_data_source.dart';
import 'package:car_rental/features/cars_view/data/data_sources/vendors_by_category_data_source.dart';
import 'package:car_rental/features/choose_brand_view/data/data_sources/get_brands_data_source.dart';
import 'package:car_rental/features/choose_brand_view/presentation/views/choose_brand_view.dart';
import 'package:car_rental/features/choose_car_condition_view/presentation/views/choose_car_condition_view.dart';
import 'package:car_rental/features/choose_car_model_view.dart/data/data_sources/get_cars_model_data_source.dart';
import 'package:car_rental/features/choose_car_model_view.dart/presentation/views/choose_car_model_view.dart';
import 'package:car_rental/features/choose_car_year_view/data/data_sources/production_year_data_source.dart';
import 'package:car_rental/features/choose_car_year_view/presentation/views/choose_car_year_view.dart';
import 'package:car_rental/features/choose_country_view/data/data_souces/cities_data_source.dart';
import 'package:car_rental/features/choose_country_view/data/model/cities_model.dart';
import 'package:car_rental/features/choose_country_view/presentation/views/choose_country_view.dart';
import 'package:car_rental/features/filter_view/presentation/views/filter_view.dart';
import 'package:car_rental/features/number_type_view/presentation/views/number_type_view.dart';
import 'package:car_rental/features/search_view/presentation/views/search_view.dart';
import 'package:car_rental/features/sim_type_view/presentation/views/sim_type_view.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/data_sources/upload_ads_data_source.dart';
import 'package:car_rental/features/vehicle_type_view/presentation/views/vehicle_type_view.dart';
import 'package:car_rental/features/vendor_profile_view/data/data_sources/vendor_profile_by_id.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

import '../../../vendor_profile_view/presentation/views/vendor_profile_view.dart';

class CarView extends StatefulWidget {
  final String? id;
  CarView(this.id);
  @override
  State<CarView> createState() => _CarViewState();
}

class _CarViewState extends State<CarView> with TickerProviderStateMixin {
  AuthController authController = Get.find();

  UploadAdsController uploadAdsController = Get.find();
  List<String> titles = [
    "City".tr,
    "Brand".tr,
    "Model".tr,
    "Year".tr,
    "Condition".tr
  ];
  List<String> titlesSort = [
    "Oldest to Newest".tr,
    "Default".tr,
    "Newest to Oldest".tr
  ];

  List<String> titlesVechileNumber = [
    "City".tr,
    "Vehicle Type".tr,
    "Number Type".tr,
  ];
  List<String> titlesMobileNumber = [
    "City".tr,
    "Sim Type".tr,
    "Condition".tr,
  ];
  List<String> titlesCarParts = [
    "City".tr,
    "Brand".tr,
  ];

  late TabController _controller;
  var indexTab = 0;
  @override
  void initState() {
    _controller = TabController(vsync: this, length: 2);
    Get.find<AuthController>().cleanFilter();
    super.initState();
  }

  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          // height: 160.h,
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.23),
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: 60.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back_ios)),
                    SizedBox(
                      width: 24.w,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => SearchView());
                        },
                        child: Container(
                          width: Get.width,
                          height: 37.h,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                                color: Color(0xffBFBFBF).withOpacity(0.23)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.23),
                                offset: Offset(0, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomText(
                                    "Search By Name...",
                                    fontSize: 12.sp,
                                    color: AppColors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  Spacer(),
                                  CustomSvgImage(
                                    imageName: "search_icon",
                                    height: 11.h,
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 28.w,
                    ),
                    widget.id == '10' || indexTab == 1
                        ? SizedBox()
                        : GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                isDismissible: true,
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: CustomText(
                                                "Cancel",
                                                fontSize: 16.w,
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                                print(uploadAdsController
                                                    .indexSortValue.value);
                                                getProductsByCategoryDataSource(
                                                  1,
                                                  true,
                                                  widget.id.toString(),
                                                  sortMethod: uploadAdsController
                                                              .indexSort.value
                                                              .toString() ==
                                                          "2"
                                                      ? "DESC"
                                                      : uploadAdsController
                                                                  .indexSort
                                                                  .value
                                                                  .toString() ==
                                                              "0"
                                                          ? "ASC"
                                                          : "",
                                                  sort: uploadAdsController
                                                              .indexSort.value
                                                              .toString() ==
                                                          "1"
                                                      ? ""
                                                      : "id",
                                                );
                                              },
                                              child: CustomText(
                                                "Done",
                                                fontSize: 16.w,
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      SizedBox(
                                        width: Get.width,
                                        height: 150.h,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          primary: false,
                                          itemCount: titlesSort.length,
                                          itemBuilder: (context, index) {
                                            return Obx(() => GestureDetector(
                                                  onTap: () {
                                                    uploadAdsController
                                                            .indexSortValue
                                                            .value =
                                                        titlesSort[index];
                                                    uploadAdsController
                                                        .setIndexSort(index);
                                                    print(uploadAdsController
                                                        .indexSortValue.value);
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    25.w),
                                                        child: Container(
                                                            width: Get.width,
                                                            height: 34.h,
                                                            decoration: BoxDecoration(
                                                                color: uploadAdsController
                                                                            .indexSort
                                                                            .value ==
                                                                        index
                                                                    ? Color(0xff747480)
                                                                        .withOpacity(
                                                                            0.23)
                                                                    : Colors
                                                                        .transparent,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8
                                                                            .r)),
                                                            child: Center(
                                                                child:
                                                                    CustomText(
                                                              titlesSort[index],
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: uploadAdsController
                                                                          .indexSort
                                                                          .value ==
                                                                      index
                                                                  ? AppColors
                                                                      .black
                                                                  : AppColors
                                                                      .grey,
                                                            ))),
                                                      ),
                                                      SizedBox(
                                                        height: 8.h,
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                          },
                                        ),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: CustomSvgImage(
                              imageName: "sort",
                              height: 20.h,
                            ),
                          )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              widget.id == '5' || widget.id == '10' || _controller.index == 1
                  ? SizedBox()
                  : Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                        ),
                        if (widget.id != '4')
                          GestureDetector(
                            onTap: () {
                              authController.cleanFilter();
                              Get.to(() => FilterView(widget.id!));
                            },
                            child: Container(
                              width: 75.w,
                              height: 34.h,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Row(children: [
                                  CustomSvgImage(
                                    imageName: "filter",
                                    height: 12.h,
                                    color: AppColors.whiteColor,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomText(
                                    "Filters",
                                    fontSize: 12.sp,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w400,
                                  )
                                ]),
                              ),
                            ),
                          ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 36.h,
                            child:
                                widget.id == '1' ||
                                        widget.id == '2' ||
                                        widget.id == '7' ||
                                        widget.id == '9'
                                    ? ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: titles.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              widget.id.toString() == "9" &&
                                                      index == 4
                                                  ? SizedBox()
                                                  : GestureDetector(
                                                      onTap: () {
                                                        if (index == 1) {
                                                          getBrandsDataSource();
                                                          Get.to(() =>
                                                              ChooseBrandView(
                                                                id: widget.id,
                                                              ));
                                                        } else if (index == 0) {
                                                          citiesDataSource();
                                                          Get.to(() =>
                                                              ChooseCountryView(
                                                                id: widget.id,
                                                              ));
                                                        } else if (index == 2) {
                                                          getCarsModelDataSource(
                                                              authController
                                                                  .getBrabdSelect
                                                                  .value
                                                                  .id
                                                                  .toString());
                                                          Get.to(() =>
                                                              ChooseCarModelView(
                                                                id: widget.id,
                                                              ));
                                                        } else if (index == 4) {
                                                          Get.to(() =>
                                                              ChooseCarConditionView(
                                                                id: widget.id,
                                                              ));
                                                        } else if (index == 3) {
                                                          productionYearDataSource();
                                                          Get.to(() =>
                                                              ChooseCarYearView(
                                                                id: widget.id,
                                                              ));
                                                        }
                                                      },
                                                      child: Container(
                                                        // width: 75.w,
                                                        height: 34.h,
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .whiteColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.r),
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .primaryColor
                                                                    .withOpacity(
                                                                        0.23))),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5.w),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down,
                                                                  color: Colors
                                                                      .transparent,
                                                                  size: 15.r,
                                                                ),
                                                                Obx(() {
                                                                  return CustomText(
                                                                    Get.find<AuthController>().getCitiesSelect.value.name.toString() !=
                                                                                "" &&
                                                                            index ==
                                                                                0
                                                                        ? SPHelper.spHelper.getLanguage() ==
                                                                                "en"
                                                                            ? Get.find<AuthController>().getCitiesSelect.value.nameEn ??
                                                                                titles[index].toString()
                                                                            : Get.find<AuthController>().getCitiesSelect.value.nameEn ?? titles[index].toString()
                                                                        : index == 1 && authController.getBrabdSelect.value.name != null
                                                                            ? authController.getBrabdSelect.value.name
                                                                            : index == 2 && authController.getCarModelSelect.value.name != null
                                                                                ? authController.getCarModelSelect.value.name
                                                                                : index == 4 && uploadAdsController.condition.value != ""
                                                                                    ? uploadAdsController.condition.value
                                                                                    : index == 3 && uploadAdsController.getProductionYearSelect.value.name != null
                                                                                        ? uploadAdsController.getProductionYearSelect.value.name
                                                                                        : titles[index],
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  );
                                                                }),
                                                                SizedBox(
                                                                  width: 5.w,
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down,
                                                                  size: 15.r,
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                    ),
                                              SizedBox(
                                                width: 15.w,
                                              )
                                            ],
                                          );
                                        },
                                      )
                                    : widget.id == '4'
                                        ? ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            primary: false,
                                            itemCount:
                                                titlesVechileNumber.length,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      authController
                                                          .cleanFilter();

                                                      if (index == 0) {
                                                        citiesDataSource();
                                                        Get.to(() =>
                                                            ChooseCountryView(
                                                              id: widget.id,
                                                            ));
                                                      } else if (index == 1) {
                                                        uploadAdsController
                                                            .setIndexType(-1);
                                                        Get.to(() =>
                                                            VehcileTypeView(
                                                              id: widget.id,
                                                            ));
                                                      } else if (index == 2) {
                                                        uploadAdsController
                                                            .setIndexNumberType(
                                                                -1);
                                                        Get.to(() =>
                                                            NumberTypeView(
                                                              id: widget.id,
                                                              isAdd: false,
                                                            ));
                                                      }
                                                    },
                                                    child: Obx(() => Container(
                                                          // width: 75.w,
                                                          height: 34.h,
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .whiteColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.r),
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .primaryColor
                                                                      .withOpacity(
                                                                          0.23))),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5.w),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down,
                                                                    color: Colors
                                                                        .transparent,
                                                                    size: 15.r,
                                                                  ),
                                                                  CustomText(
                                                                    authController.getCitiesSelect.value.name !=
                                                                                null &&
                                                                            index ==
                                                                                0
                                                                        ? SPHelper.spHelper.getLanguage() ==
                                                                                "en"
                                                                            ? authController
                                                                                .getCitiesSelect.value.nameEn
                                                                            : authController
                                                                                .getCitiesSelect.value.name
                                                                        : uploadAdsController.vehicleType.value != "" &&
                                                                                index == 1
                                                                            ? uploadAdsController.vehicleType.value
                                                                            : uploadAdsController.numberType.value != "" && index == 2
                                                                                ? uploadAdsController.numberType.value
                                                                                : titlesVechileNumber[index],
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5.w,
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down,
                                                                    size: 15.r,
                                                                  ),
                                                                ]),
                                                          ),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    width: 15.w,
                                                  )
                                                ],
                                              );
                                            },
                                          )
                                        : widget.id == '3'
                                            ? ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                primary: false,
                                                itemCount:
                                                    titlesMobileNumber.length,
                                                itemBuilder: (context, index) {
                                                  return Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          authController
                                                              .cleanFilter();

                                                          if (index == 0) {
                                                            citiesDataSource();
                                                            Get.to(() =>
                                                                ChooseCountryView(
                                                                  id: widget.id,
                                                                ));
                                                          } else if (index ==
                                                              1) {
                                                            uploadAdsController
                                                                .setIndexSimType(
                                                                    -1);
                                                            Get.to(() =>
                                                                SimTypeView(
                                                                  id: widget.id,
                                                                ));
                                                          } else if (index ==
                                                              2) {
                                                            uploadAdsController
                                                                .setIndexCondition(
                                                                    -1);
                                                            Get.to(() =>
                                                                ChooseCarConditionView(
                                                                  id: widget.id,
                                                                ));
                                                          }
                                                        },
                                                        child:
                                                            Obx(() => Container(
                                                                  // width: 75.w,
                                                                  height: 34.h,
                                                                  decoration: BoxDecoration(
                                                                      color: AppColors
                                                                          .whiteColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(12
                                                                              .r),
                                                                      border: Border.all(
                                                                          color: AppColors
                                                                              .primaryColor
                                                                              .withOpacity(0.23))),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            5.w),
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.keyboard_arrow_down,
                                                                            color:
                                                                                Colors.transparent,
                                                                            size:
                                                                                15.r,
                                                                          ),
                                                                          CustomText(
                                                                            authController.getCitiesSelect.value.name != null && index == 0
                                                                                ? SPHelper.spHelper.getLanguage() == "en"
                                                                                    ? authController.getCitiesSelect.value.nameEn
                                                                                    : authController.getCitiesSelect.value.name
                                                                                : uploadAdsController.simType.value != "" && index == 1
                                                                                    ? uploadAdsController.simType.value
                                                                                    : uploadAdsController.condition.value != "" && index == 2
                                                                                        ? uploadAdsController.condition.value
                                                                                        : titlesMobileNumber[index],
                                                                            fontSize:
                                                                                12.sp,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                5.w,
                                                                          ),
                                                                          Icon(
                                                                            Icons.keyboard_arrow_down,
                                                                            size:
                                                                                15.r,
                                                                          ),
                                                                        ]),
                                                                  ),
                                                                )),
                                                      ),
                                                      SizedBox(
                                                        width: 15.w,
                                                      )
                                                    ],
                                                  );
                                                },
                                              )
                                            : widget.id == '6'
                                                ? ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    primary: false,
                                                    itemCount:
                                                        titlesCarParts.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              authController
                                                                  .cleanFilter();

                                                              if (index == 0) {
                                                                citiesDataSource();
                                                                Get.to(() =>
                                                                    ChooseCountryView(
                                                                      id: widget
                                                                          .id,
                                                                    ));
                                                              } else if (index ==
                                                                  1) {
                                                                getBrandsDataSource();

                                                                uploadAdsController
                                                                    .setIndexBrand(
                                                                        -1);
                                                                Get.to(() =>
                                                                    ChooseBrandView(
                                                                      id: widget
                                                                          .id,
                                                                    ));
                                                              }
                                                            },
                                                            child: Obx(
                                                                () => Container(
                                                                      // width: 75.w,
                                                                      height:
                                                                          34.h,
                                                                      decoration: BoxDecoration(
                                                                          color: AppColors
                                                                              .whiteColor,
                                                                          borderRadius: BorderRadius.circular(12
                                                                              .r),
                                                                          border:
                                                                              Border.all(color: AppColors.primaryColor.withOpacity(0.23))),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 5.w),
                                                                        child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.keyboard_arrow_down,
                                                                                color: Colors.transparent,
                                                                                size: 15.r,
                                                                              ),
                                                                              CustomText(
                                                                                authController.getCitiesSelect.value.name != null && index == 0
                                                                                    ? SPHelper.spHelper.getLanguage() == "en"
                                                                                        ? authController.getCitiesSelect.value.nameEn
                                                                                        : authController.getCitiesSelect.value.name
                                                                                    : authController.getBrabdSelect.value.name != null && index == 1
                                                                                        ? authController.getBrabdSelect.value.name
                                                                                        : titlesCarParts[index],
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.w400,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                              Icon(
                                                                                Icons.keyboard_arrow_down,
                                                                                size: 15.r,
                                                                              ),
                                                                            ]),
                                                                      ),
                                                                    )),
                                                          ),
                                                          SizedBox(
                                                            width: 15.w,
                                                          )
                                                        ],
                                                      );
                                                    },
                                                  )
                                                : Container(),
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: 15.h,
              ),
              widget.id != "7" &&
                      widget.id != "4" &&
                      widget.id != "3" &&
                      widget.id != "6" &&
                      widget.id != "9"
                  ? TabBar(
                      onTap: (index) {
                        setState(() {
                          // homeController.allProductsList.clear();
                          indexTab = index;
                          getVendorsByCategoryDataSource(1, true, "6");
                          if (index == 0) {
                            if (widget.id == "10") {
                              getProductsByCategoryDataSource(1, true, "7");
                            } else {
                              getProductsByCategoryDataSource(
                                  1, true, widget.id!);
                            }
                          } else if (index == 1) {
                            if (widget.id.toString() == "10") {
                              getProductsByCategoryDataSource(1, true, "5");
                            } else {
                              getVendorsByCategoryDataSource(
                                  1, true, widget.id!);
                            }
                          }
                        });
                      },
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      indicator: MaterialIndicator(
                          color: AppColors.primaryColor,
                          height: 1.h,
                          topRightRadius: 0,
                          topLeftRadius: 0,
                          bottomLeftRadius: 0,
                          bottomRightRadius: 0,

                          // distanceFromCenter: 16,
                          // radius: 3,
                          // horizontalPadding: 30.w,
                          paintingStyle: PaintingStyle.fill,
                          tabPosition: TabPosition.bottom),
                      controller: _controller,
                      // unselectedLabelColor: Colors.black,
                      // labelColor: Colors.red,
                      tabs: <Widget>[
                        indexTab == 0
                            ? Column(
                                children: [
                                  CustomText(
                                    widget.id == "1"
                                        ? "Cars"
                                        : widget.id == "2"
                                            ? "Trucks"
                                            : "Car Care",
                                    fontSize: 14.sp,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  CustomText(
                                    widget.id == "1"
                                        ? "Cars"
                                        : widget.id == "2"
                                            ? "Trucks"
                                            : "Car Care",
                                    fontSize: 14.sp,
                                    color: Color(0xffBFBFBF),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  )
                                ],
                              ),
                        indexTab == 1
                            ? Column(
                                children: [
                                  CustomText(
                                    widget.id == "1"
                                        ? "Car Shows"
                                        : widget.id == "2"
                                            ? "Truck Shows"
                                            : "Car Maintenance",
                                    fontSize: 14.sp,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  CustomText(
                                    widget.id == "1"
                                        ? "Car Shows"
                                        : widget.id == "2"
                                            ? "Truck Shows"
                                            : "Car Maintenance",
                                    fontSize: 14.sp,
                                    color: Color(0xffBFBFBF),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  )
                                ],
                              ),
                      ],
                      //,controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                    )
                  : SizedBox(),
            ],
          ),
        ),

        // Obx(() {
        Expanded(
          child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _controller,
              children: [
                Obx(() {
                  return homeController.getProductsData.value.code == null
                      ? Helper.loading()
                      : LazyLoadScrollView(
                          onEndOfPage: () {
                            if (widget.id == "10") {
                              print(homeController
                                  .getProductsData.value.data!.currentPage);
                              print(homeController
                                  .getProductsData.value.data!.lastPage);

                              log('ennd');

                              if (homeController.getProductsData.value.data!
                                      .currentPage !=
                                  homeController
                                      .getProductsData.value.data!.lastPage) {
                                getProductsByCategoryDataSource(
                                    homeController.getProductsData.value.data!
                                            .currentPage! +
                                        1,
                                    false,
                                    "7");
                                // Apis.apis.getAllNews(
                                //   appController.allNewsApp.value.currentPage! + 1,
                                //   false,
                                // );
                              }
                            } else {
                              print(homeController
                                  .getProductsData.value.data!.currentPage);
                              print(homeController
                                  .getProductsData.value.data!.lastPage);

                              log('ennd');

                              if (homeController.getProductsData.value.data!
                                      .currentPage !=
                                  homeController
                                      .getProductsData.value.data!.lastPage) {
                                getProductsByCategoryDataSource(
                                    homeController.getProductsData.value.data!
                                            .currentPage! +
                                        1,
                                    false,
                                    widget.id.toString());
                                // Apis.apis.getAllNews(
                                //   appController.allNewsApp.value.currentPage! + 1,
                                //   false,
                                // );
                              }
                            }
                          },
                          child: RefreshIndicator(
                            onRefresh: () async {
                              if (widget.id == "10") {
                                getProductsByCategoryDataSource(1, true, "7");
                              } else {
                                getProductsByCategoryDataSource(
                                    1, true, widget.id.toString());
                              }
                            },
                            child: widget.id == "10"
                                ? SizedBox(
                                    width: Get.width,
                                    child: ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount:
                                          homeController.allProductsList.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            // homeController.allProductsList
                                            //     .clear();
                                            getProductById(homeController
                                                .allProductsList[index].id
                                                .toString());
                                            Get.to(() => CarAdSaleView(
                                                  id: homeController
                                                      .allProductsList[index].id
                                                      .toString(),
                                                ));
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                                child: Container(
                                                  width: Get.width,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.r),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.23),
                                                        offset: Offset(0, 1),
                                                        blurRadius: 2,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(children: [
                                                    Stack(
                                                      clipBehavior: Clip.none,
                                                      children: [
                                                        homeController
                                                                    .allProductsList[
                                                                        index]
                                                                    .categoryId
                                                                    .toString() ==
                                                                "3"
                                                            ? ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.r),
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      Get.width,
                                                                  height: 272.h,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(15
                                                                              .r),
                                                                      color: AppColors
                                                                          .whiteColor),
                                                                  child: Center(
                                                                      child:
                                                                          Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            20.w),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          375.w,
                                                                      height:
                                                                          80.h,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(15
                                                                              .r),
                                                                          border: Border.all(
                                                                              color: Color(0xff524188),
                                                                              width: 3)),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 12.w),
                                                                        child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              homeController.allProductsList[index].simType.toString() == "1"
                                                                                  ? CustomSvgImage(
                                                                                      imageName: "etisalat-seeklogo.com",
                                                                                      height: 80.h,
                                                                                    )
                                                                                  : CustomSvgImage(
                                                                                      imageName: "du-company-logo-1",
                                                                                      height: 40.h,
                                                                                    ),
                                                                              SizedBox(
                                                                                width: 10.w,
                                                                              ),
                                                                              // CustomText(
                                                                              //   homeController.allProductsList[index].phone,
                                                                              //   // // letterspacing: 10,
                                                                              // ),
                                                                              SizedBox(),
                                                                            ]),
                                                                      ),
                                                                    ),
                                                                  )),
                                                                ),
                                                              )
                                                            : homeController
                                                                        .allProductsList[
                                                                            index]
                                                                        .categoryId
                                                                        .toString() ==
                                                                    "4"
                                                                ? Container(
                                                                    width: Get
                                                                        .width,
                                                                    height:
                                                                        200.h,
                                                                    child: Center(
                                                                        child: Padding(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            12.w,
                                                                      ),
                                                                      child: Container(
                                                                          width: Get
                                                                              .width,
                                                                          height: 80
                                                                              .h,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(10.r),
                                                                              border: Border.all(color: AppColors.black, width: 2.w)),
                                                                          child: SizedBox()),
                                                                    )),
                                                                  )
                                                                : CachedNetworkImageShare(
                                                                    homeController
                                                                            .allProductsList[index]
                                                                            .photo ??
                                                                        "",
                                                                    210.h,
                                                                    Get.width,
                                                                    15,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                        if (homeController
                                                                .allProductsList[
                                                                    index]
                                                                .plan !=
                                                            null)
                                                          Positioned(
                                                            bottom: -7.h,
                                                            child: Container(
                                                              width: 343.w,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        20.h,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppColors
                                                                          .whiteColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              11.r),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: homeController.allProductsList[index].plan!.id.toString() == "2"
                                                                              ? AppColors.green
                                                                              : homeController.allProductsList[index].plan!.id.toString() == "1"
                                                                                  ? Color(0xffFBAA30)
                                                                                  : AppColors.red,
                                                                          offset: Offset(
                                                                              0,
                                                                              0),
                                                                          blurRadius:
                                                                              2,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            5.w,
                                                                        vertical:
                                                                            3.h,
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          CustomSvgImage(
                                                                            imageName:
                                                                                "taj",
                                                                            color: homeController.allProductsList[index].plan!.id.toString() == "2"
                                                                                ? AppColors.green
                                                                                : homeController.allProductsList[index].plan!.id.toString() == "1"
                                                                                    ? Color(0xffFBAA30)
                                                                                    : AppColors.red,
                                                                            height:
                                                                                15.h,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                5.w,
                                                                          ),
                                                                          CustomText(
                                                                            homeController.allProductsList[index].plan!.title!,
                                                                            fontSize:
                                                                                12.sp,
                                                                            color: homeController.allProductsList[index].plan!.id.toString() == "2"
                                                                                ? AppColors.green
                                                                                : homeController.allProductsList[index].plan!.id.toString() == "1"
                                                                                    ? Color(0xffFBAA30)
                                                                                    : AppColors.red,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),

                                                        // Padding(
                                                        //   padding:
                                                        //       EdgeInsets.all(
                                                        //           12.r),
                                                        //   child: Row(
                                                        //     children: [
                                                        //       Container(
                                                        //         height: 24.h,
                                                        //         width: 24.w,
                                                        //         decoration:
                                                        //             BoxDecoration(
                                                        //           shape: BoxShape
                                                        //               .circle,
                                                        //           color: AppColors
                                                        //               .whiteColor,
                                                        //         ),
                                                        //         child:
                                                        //             CachedNetworkImageShare(
                                                        //           "https://cdn4.vectorstock.com/i/1000x1000/77/43/young-man-head-avatar-cartoon-face-character-vector-21757743.jpg",
                                                        //           24.h,
                                                        //           24.w,
                                                        //           0,
                                                        //         ),
                                                        //       ),
                                                        //       // Spacer(),
                                                        //       // CustomSvgImage(
                                                        //       //   imageName:
                                                        //       //       "heart_car",
                                                        //       //   height: 12.h,
                                                        //       //   width: 11.w,
                                                        //       //   color: AppColors.red,
                                                        //       // )
                                                        //     ],
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          if (widget.id !=
                                                                  "3" ||
                                                              widget.id != "4")
                                                            Row(
                                                              children: [
                                                                CustomSvgImage(
                                                                  imageName:
                                                                      "title_icon",
                                                                  height: 10.h,
                                                                  color:
                                                                      AppColors
                                                                          .black,
                                                                ),
                                                                SizedBox(
                                                                  width: 10.w,
                                                                ),
                                                                CustomText(
                                                                  homeController
                                                                          .allProductsList[
                                                                              index]
                                                                          .name
                                                                          .toString() ??
                                                                      "",
                                                                  fontSize:
                                                                      15.sp,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                                Spacer(),
                                                                CustomSvgImage(
                                                                  imageName:
                                                                      "time_icon",
                                                                  height: 10.h,
                                                                  width: 8.w,
                                                                  color:
                                                                      AppColors
                                                                          .grey,
                                                                ),
                                                                SizedBox(
                                                                  width: 10.w,
                                                                ),
                                                                CustomText(
                                                                  homeController
                                                                      .allProductsList[
                                                                          index]
                                                                      .createdAt
                                                                      .toString()
                                                                      .substring(
                                                                          0,
                                                                          10),
                                                                  fontSize:
                                                                      10.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color:
                                                                      AppColors
                                                                          .grey,
                                                                ),
                                                              ],
                                                            ),
                                                          SizedBox(
                                                            height: 7.h,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                height: 5.h,
                                                                width: 5.w,
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .black,
                                                                    shape: BoxShape
                                                                        .circle),
                                                              ),
                                                              SizedBox(
                                                                width: 10.w,
                                                              ),
                                                              Container(
                                                                constraints:
                                                                    BoxConstraints(
                                                                        maxWidth:
                                                                            250.w),
                                                                child:
                                                                    CustomText(
                                                                  homeController
                                                                          .allProductsList[
                                                                              index]
                                                                          .description ??
                                                                      "",
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color:
                                                                      AppColors
                                                                          .grey,
                                                                ),
                                                              ),
                                                              Spacer(),
                                                              CustomText(
                                                                homeController
                                                                        .allProductsList[
                                                                            index]
                                                                        .city!
                                                                        .name ??
                                                                    "",
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: AppColors
                                                                    .grey,
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 15.h,
                                                          ),
                                                          Divider(),
                                                          IntrinsicHeight(
                                                              child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 14.h),
                                                            child: new Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: <
                                                                  Widget>[
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    showModalBottomSheet(
                                                                      isDismissible:
                                                                          true,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 16.h,
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
                                                                                    child: CustomText(
                                                                                      "Cancel",
                                                                                      fontSize: 16.w,
                                                                                      color: AppColors.primaryColor,
                                                                                      fontWeight: FontWeight.w400,
                                                                                    ),
                                                                                  ),
                                                                                  GestureDetector(
                                                                                    onTap: () {
                                                                                      Get.back();
                                                                                      UrlLauncher.launchUrl(Uri(scheme: "tel", path: homeController.getVendorsData.value.data!.data![index].user!.phones![homeController.indexNumber.value].number));
                                                                                    },
                                                                                    child: CustomText(
                                                                                      "Done",
                                                                                      fontSize: 16.w,
                                                                                      color: AppColors.primaryColor,
                                                                                      fontWeight: FontWeight.w400,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 30.h,
                                                                            ),
                                                                            homeController.getVendorsData.value.data!.data![index].user!.phones!.length == 0
                                                                                ? Column(
                                                                                    children: [
                                                                                      CustomText(
                                                                                        "There is No Numbers",
                                                                                        fontSize: 12.sp,
                                                                                        fontWeight: FontWeight.w400,
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 30.h,
                                                                                      ),
                                                                                    ],
                                                                                  )
                                                                                : SizedBox(
                                                                                    width: Get.width,
                                                                                    height: 100.h,
                                                                                    child: ListView.builder(
                                                                                      shrinkWrap: true,
                                                                                      primary: false,
                                                                                      itemCount: homeController.allVendorsList[index].user!.phones!.length,
                                                                                      itemBuilder: (context, index2) {
                                                                                        return Obx(() => GestureDetector(
                                                                                              onTap: () {
                                                                                                homeController.setIndexNumber(index2);
                                                                                              },
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  Padding(
                                                                                                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                                                                                                    child: Container(
                                                                                                        width: Get.width,
                                                                                                        height: 34.h,
                                                                                                        decoration: BoxDecoration(color: homeController.indexNumber.value == index2 ? Color(0xff747480).withOpacity(0.23) : Colors.transparent, borderRadius: BorderRadius.circular(8.r)),
                                                                                                        child: Center(
                                                                                                            child: CustomText(
                                                                                                          homeController.allVendorsList[index].user!.phones![index2].number,
                                                                                                          fontSize: 12.sp,
                                                                                                          fontWeight: FontWeight.w400,
                                                                                                          color: homeController.indexNumber.value == index2 ? AppColors.black : AppColors.grey,
                                                                                                        ))),
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    height: 8.h,
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ));
                                                                                      },
                                                                                    ),
                                                                                  )
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  child:
                                                                      CustomSvgImage(
                                                                    imageName:
                                                                        "call",
                                                                    height:
                                                                        20.h,
                                                                    width: 20.w,
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                  ),
                                                                ),
                                                                VerticalDivider(),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    launch(
                                                                        "https://wa.me/${homeController.allProductsList[index].whatsapp!}");
                                                                  },
                                                                  child:
                                                                      CustomSvgImage(
                                                                    imageName:
                                                                        "whatsapp",
                                                                    height:
                                                                        20.h,
                                                                    width: 20.w,
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                          SizedBox(
                                                            height: 15.h,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12.h,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : SizedBox(
                                    width: Get.width,
                                    child: ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount:
                                          homeController.allProductsList.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            getProductById(homeController
                                                .allProductsList[index].id
                                                .toString());
                                            Get.to(() => CarAdSaleView(
                                                  id: homeController
                                                      .allProductsList[index].id
                                                      .toString(),
                                                ));
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              Container(
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  color: AppColors.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.23),
                                                      offset: Offset(0, 1),
                                                      blurRadius: 2,
                                                    ),
                                                  ],
                                                ),
                                                child: Column(children: [
                                                  Stack(
                                                    children: [
                                                      homeController
                                                                  .allProductsList[
                                                                      index]
                                                                  .categoryId
                                                                  .toString() ==
                                                              "3"
                                                          ? Container(
                                                              width: Get.width,
                                                              height: 272.h,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(15
                                                                              .r),
                                                                  color: AppColors
                                                                      .whiteColor),
                                                              child: Center(
                                                                  child:
                                                                      Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            20.w),
                                                                child:
                                                                    Container(
                                                                  width: 375.w,
                                                                  height: 80.h,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(15
                                                                              .r),
                                                                      border: Border.all(
                                                                          color: Color(
                                                                              0xff524188),
                                                                          width:
                                                                              3)),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            12.w),
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          homeController.allProductsList[index].simType.toString() == "1"
                                                                              ? CustomSvgImage(
                                                                                  imageName: "etisalat-seeklogo.com",
                                                                                  height: 15.h,
                                                                                )
                                                                              : CustomSvgImage(
                                                                                  imageName: "du-company-logo-1",
                                                                                  height: 30.h,
                                                                                ),
                                                                          // SizedBox(
                                                                          //   width:
                                                                          //       10.w,
                                                                          // ),
                                                                          CustomText(
                                                                            homeController.allProductsList[index].phone,
                                                                            fontSize:
                                                                                20.sp,
                                                                            letterspacing:
                                                                                2.0,
                                                                          ),
                                                                          SizedBox(),
                                                                        ]),
                                                                  ),
                                                                ),
                                                              )),
                                                            )
                                                          : homeController
                                                                      .allProductsList[
                                                                          index]
                                                                      .categoryId
                                                                      .toString() ==
                                                                  "4"
                                                              ? Container(
                                                                  width:
                                                                      Get.width,
                                                                  height: 200.h,
                                                                  child: Center(
                                                                      child:
                                                                          Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                      horizontal:
                                                                          12.w,
                                                                    ),
                                                                    child: Container(
                                                                        width: Get.width,
                                                                        height: 80.h,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.r),
                                                                        ),
                                                                        child: homeController.allProductsList[index].photo != null ? CachedNetworkImageShare(homeController.allProductsList[index].photo, 80.h, Get.width, 1) : SizedBox()
//                                                                        homeController.allProductsList[index].city!.id.toString() ==
//                                                                               "1"
//                                                                           ? Padding(
//                                                                               padding: EdgeInsets.symmetric(horizontal: 12.w),
//                                                                               child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                                                                                 CustomText(
//                                                                                   homeController.allProductsList[index].code ?? "X",
//                                                                                   fontSize: 27.sp,
//                                                                                 ),
//                                                                                 CustomText(
//                                                                                   homeController.allProductsList[index].vehicleNumber ?? "XXXXX",
//                                                                                   fontSize: 27.sp,
//                                                                                 ),
//                                                                                 Image.network(
//                                                                                   homeController.allProductsList[index].city!.logo!,
//                                                                                 ),
//                                                                                 // CachedNetworkImageShare(
//                                                                                 //     homeController
//                                                                                 //         .getProductByIdData
//                                                                                 //         .value
//                                                                                 //         .data!
//                                                                                 //         .city!
//                                                                                 //         .logo,
//                                                                                 //     80,
//                                                                                 //     60,
//                                                                                 //     1)
//                                                                               ]),
//                                                                             )
//                                                                           : homeController.allProductsList[index].city!.id.toString() == "2"
//                                                                               ? Padding(
//                                                                                   padding: EdgeInsets.symmetric(horizontal: 20.w),
//                                                                                   child: Row(children: [
//                                                                                     Column(
//                                                                                       mainAxisAlignment: MainAxisAlignment.center,
//                                                                                       children: [
//                                                                                         Image.network(
//                                                                                           homeController.allProductsList[index].city!.logo!,
//                                                                                           height: 40.h,
//                                                                                         ),
//                                                                                         CustomText(
//                                                                                           homeController.allProductsList[index].code ?? "X",
//                                                                                         ),
//                                                                                       ],
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       width: 60.w,
//                                                                                     ),
//                                                                                     CustomText(homeController.allProductsList[index].vehicleNumber ?? "XXXXX"),
//                                                                                   ]),
//                                                                                 )
//                                                                               : homeController.allProductsList[index].city!.id.toString() == "3"
//                                                                                   ?
// //3
//                                                                                   Padding(
//                                                                                       padding: EdgeInsets.symmetric(horizontal: 20.w),
//                                                                                       child: Row(children: [
//                                                                                         CustomText(
//                                                                                           homeController.allProductsList[index].code ?? "X",
//                                                                                           fontSize: 33.sp,
//                                                                                         ),
//                                                                                         SizedBox(
//                                                                                           width: 20.w,
//                                                                                         ),
//                                                                                         Image.network(
//                                                                                           homeController.allProductsList[index].city!.logo!,
//                                                                                           height: 60.h,
//                                                                                         ),
//                                                                                         Spacer(),
//                                                                                         CustomText(
//                                                                                           homeController.allProductsList[index].vehicleNumber ?? "XXXXX",
//                                                                                           fontSize: 33.sp,
//                                                                                         ),
//                                                                                       ]),
//                                                                                     )
//                                                                                   : homeController.allProductsList[index].city!.id.toString() == "4"
//                                                                                       ?

//                                                                                       //4
//                                                                                       Row(children: [
//                                                                                           Container(
//                                                                                             width: 60.w,
//                                                                                             height: Get.height,
//                                                                                             decoration: BoxDecoration(
//                                                                                                 borderRadius: BorderRadius.only(
//                                                                                                   topLeft: Radius.circular(5.r),
//                                                                                                   bottomLeft: Radius.circular(5.r),
//                                                                                                 ),
//                                                                                                 color: AppColors.primaryColor),
//                                                                                             child: Center(
//                                                                                               child: CustomText(
//                                                                                                 homeController.allProductsList[index].code ?? "X",
//                                                                                                 fontSize: 33.sp,
//                                                                                                 color: AppColors.whiteColor,
//                                                                                               ),
//                                                                                             ),
//                                                                                           ),
//                                                                                           SizedBox(
//                                                                                             width: 20.w,
//                                                                                           ),
//                                                                                           Image.network(
//                                                                                             homeController.allProductsList[index].city!.logo!,
//                                                                                             height: 60.h,
//                                                                                           ),
//                                                                                           Spacer(),
//                                                                                           CustomText(
//                                                                                             homeController.allProductsList[index].vehicleNumber ?? "XXXXX",
//                                                                                             fontSize: 33.sp,
//                                                                                           ),
//                                                                                           SizedBox(
//                                                                                             width: 20.w,
//                                                                                           ),
//                                                                                         ])
//                                                                                       : homeController.allProductsList[index].city!.id.toString() == "5"
//                                                                                           ? Padding(
//                                                                                               padding: EdgeInsets.symmetric(horizontal: 12.w),
//                                                                                               child: Row(children: [
//                                                                                                 CustomText(
//                                                                                                   homeController.allProductsList[index].code ?? "X",
//                                                                                                   fontSize: 33.sp,
//                                                                                                   color: AppColors.black,
//                                                                                                 ),
//                                                                                                 SizedBox(
//                                                                                                   width: 20.w,
//                                                                                                 ),
//                                                                                                 Image.network(
//                                                                                                   homeController.allProductsList[index].city!.logo!,
//                                                                                                   height: 60.h,
//                                                                                                 ),
//                                                                                                 Spacer(),
//                                                                                                 CustomText(
//                                                                                                   homeController.allProductsList[index].vehicleNumber ?? "XXXXX",
//                                                                                                   fontSize: 33.sp,
//                                                                                                 ),
//                                                                                               ]),
//                                                                                             )
//                                                                                           :
//                                                                                           //6
//                                                                                           Padding(
//                                                                                               padding: EdgeInsets.symmetric(horizontal: 12.w),
//                                                                                               child: Row(children: [
//                                                                                                 CustomText(
//                                                                                                   homeController.allProductsList[index].code ?? "X",
//                                                                                                   fontSize: 33.sp,
//                                                                                                   color: AppColors.black,
//                                                                                                 ),
//                                                                                                 SizedBox(
//                                                                                                   width: 20.w,
//                                                                                                 ),
//                                                                                                 Image.network(
//                                                                                                   homeController.allProductsList[index].city!.logo!,
//                                                                                                   height: 60.h,
//                                                                                                 ),
//                                                                                                 Spacer(),
//                                                                                                 CustomText(
//                                                                                                   homeController.allProductsList[index].vehicleNumber ?? "XXXXX",
//                                                                                                   fontSize: 33.sp,
//                                                                                                 ),
//                                                                                               ]),
//                                                                                             ),

                                                                        ),
                                                                  )),
                                                                )
                                                              : widget.id == "6"
                                                                  ? Container(
                                                                      height:
                                                                          272.h,
                                                                      width: Get
                                                                          .width,
                                                                      child:
                                                                          Center(
                                                                        child: homeController.allProductsList[index].brand ==
                                                                                null
                                                                            ? SizedBox()
                                                                            : CachedNetworkImageShare(
                                                                                homeController.allProductsList[index].brand!.logo ?? "",
                                                                                150.h,
                                                                                150,
                                                                                15,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                      ),
                                                                    )
                                                                  : Stack(
                                                                      clipBehavior:
                                                                          Clip.none,
                                                                      children: [
                                                                        CachedNetworkImageShare(
                                                                          homeController.allProductsList[index].photo ??
                                                                              "",
                                                                          210.h,
                                                                          Get.width,
                                                                          15,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        if (homeController.allProductsList[index].plan !=
                                                                            null)
                                                                          Positioned(
                                                                            bottom:
                                                                                -7.h,
                                                                            child:
                                                                                Container(
                                                                              width: 343.w,
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Container(
                                                                                    height: 20.h,
                                                                                    decoration: BoxDecoration(
                                                                                      color: AppColors.whiteColor,
                                                                                      borderRadius: BorderRadius.circular(11.r),
                                                                                      boxShadow: [
                                                                                        BoxShadow(
                                                                                          color: homeController.allProductsList[index].plan!.id.toString() == "2"
                                                                                              ? AppColors.green
                                                                                              : homeController.allProductsList[index].plan!.id.toString() == "1"
                                                                                                  ? Color(0xffFBAA30)
                                                                                                  : AppColors.red,
                                                                                          offset: Offset(0, 0),
                                                                                          blurRadius: 2,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.symmetric(
                                                                                        horizontal: 5.w,
                                                                                        vertical: 3.h,
                                                                                      ),
                                                                                      child: Row(
                                                                                        children: [
                                                                                          CustomSvgImage(
                                                                                            imageName: "taj",
                                                                                            color: homeController.allProductsList[index].plan!.id.toString() == "2"
                                                                                                ? AppColors.green
                                                                                                : homeController.allProductsList[index].plan!.id.toString() == "1"
                                                                                                    ? Color(0xffFBAA30)
                                                                                                    : AppColors.red,
                                                                                            height: 15.h,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 5.w,
                                                                                          ),
                                                                                          CustomText(
                                                                                            homeController.allProductsList[index].plan!.title!,
                                                                                            fontSize: 12.sp,
                                                                                            color: homeController.allProductsList[index].plan!.id.toString() == "2"
                                                                                                ? AppColors.green
                                                                                                : homeController.allProductsList[index].plan!.id.toString() == "1"
                                                                                                    ? Color(0xffFBAA30)
                                                                                                    : AppColors.red,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),

                                                                        // if (homeController.allProductsList[index].plan !=
                                                                        //     null)
                                                                        //   Positioned(
                                                                        //     bottom:
                                                                        //         -15.h,
                                                                        //     child:
                                                                        //         Container(
                                                                        //       width: Get.width,
                                                                        //       child: Row(
                                                                        //         mainAxisAlignment: MainAxisAlignment.center,
                                                                        //         children: [
                                                                        //           Container(
                                                                        //             width: 100.w,
                                                                        //             height: 30.h,
                                                                        //             decoration: BoxDecoration(boxShadow: [
                                                                        //               BoxShadow(
                                                                        //                 color: Colors.grey.withOpacity(0.23),
                                                                        //                 offset: Offset(0, 1),
                                                                        //                 blurRadius: 2,
                                                                        //               ),
                                                                        //             ], color: AppColors.whiteColor, borderRadius: BorderRadius.circular(25.r)),
                                                                        //             child: Center(
                                                                        //               child: CustomText(
                                                                        //                 homeController.allProductsList[index].plan!.title!,
                                                                        //                 fontSize: 12.sp,
                                                                        //                 fontWeight: FontWeight.w400,
                                                                        //               ),
                                                                        //             ),
                                                                        //           ),
                                                                        //         ],
                                                                        //       ),
                                                                        //     ),
                                                                        //   )
                                                                      ],
                                                                    ),
                                                      if (homeController
                                                              .allProductsList[
                                                                  index]
                                                              .vendor !=
                                                          null)
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  12.r),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                  height: 24.h,
                                                                  width: 24.w,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: AppColors
                                                                        .whiteColor,
                                                                  ),
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      getVendorProfileDataSource(
                                                                          homeController
                                                                              .allProductsList[index]
                                                                              .vendor!
                                                                              .id
                                                                              .toString(),
                                                                          1,
                                                                          true);
                                                                      Get.to(() =>
                                                                          VendorProfileView());
                                                                    },
                                                                    child: CachedNetworkImageShare(
                                                                        "",
                                                                        // homeController
                                                                        //     .allProductsList[
                                                                        // index].vendor!.user..toString(),
                                                                        30,
                                                                        30,
                                                                        0),
                                                                  )),
                                                              Spacer(),
                                                              IconButton(
                                                                  onPressed:
                                                                      () {},
                                                                  icon: Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    color: homeController.allProductsList[index].isFavorit ==
                                                                            0
                                                                        ? AppColors
                                                                            .grey
                                                                        : AppColors
                                                                            .primaryColor,
                                                                  ))
                                                              // CustomSvgImage(
                                                              //   imageName:
                                                              //       "heart_car",
                                                              //   height: 12.h,
                                                              //   width: 11.w,
                                                              //   color: AppColors.red,
                                                              // )
                                                            ],
                                                          ),
                                                        ),
                                                      if (homeController
                                                              .allProductsList[
                                                                  index]
                                                              .plan !=
                                                          null)
                                                    widget.id == "3"||   widget.id == "4"   ?
                                                    Positioned(
                                                          bottom: 0.h,
                                                          child: Container(
                                                            width: 343.w,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  height: 20.h,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppColors
                                                                        .whiteColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            11.r),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: homeController.allProductsList[index].plan!.id.toString() ==
                                                                                "2"
                                                                            ? AppColors.green
                                                                            : homeController.allProductsList[index].plan!.id.toString() == "1"
                                                                                ? Color(0xffFBAA30)
                                                                                : AppColors.red,
                                                                        offset: Offset(
                                                                            0,
                                                                            0),
                                                                        blurRadius:
                                                                            2,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                      horizontal:
                                                                          5.w,
                                                                      vertical:
                                                                          3.h,
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        CustomSvgImage(
                                                                          imageName:
                                                                              "taj",
                                                                          color: homeController.allProductsList[index].plan!.id.toString() == "2"
                                                                              ? AppColors.green
                                                                              : homeController.allProductsList[index].plan!.id.toString() == "1"
                                                                                  ? Color(0xffFBAA30)
                                                                                  : AppColors.red,
                                                                          height:
                                                                              15.h,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5.w,
                                                                        ),
                                                                        CustomText(
                                                                          homeController
                                                                              .allProductsList[index]
                                                                              .plan!
                                                                              .title!,
                                                                          fontSize:
                                                                              12.sp,
                                                                          color: homeController.allProductsList[index].plan!.id.toString() == "2"
                                                                              ? AppColors.green
                                                                              : homeController.allProductsList[index].plan!.id.toString() == "1"
                                                                                  ? Color(0xffFBAA30)
                                                                                  : AppColors.red,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ):SizedBox(),
                                                 
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.w),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        widget.id == '6' ||
                                                                widget.id ==
                                                                    "7" ||
                                                                widget.id == "5"
                                                            ? SizedBox()
                                                            : Row(
                                                                children: [
                                                                  CustomSvgImage(
                                                                    imageName:
                                                                        "price_icon",
                                                                    height: 8.h,
                                                                    width: 8.w,
                                                                    color: AppColors
                                                                        .black,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10.w,
                                                                  ),
                                                                  CustomText(
                                                                    widget.id ==
                                                                            "9"
                                                                        ? homeController.allProductsList[index].priceDaily +
                                                                            " " +
                                                                            "AED"
                                                                                .tr +
                                                                            " / Daily"
                                                                                .tr
                                                                        : homeController.allProductsList[index].price! +
                                                                            " " +
                                                                            "AED".tr,
                                                                    fontSize:
                                                                        17.sp,
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                  Spacer(),
                                                                  CustomSvgImage(
                                                                    imageName:
                                                                        "time_icon",
                                                                    height:
                                                                        10.h,
                                                                    width: 8.w,
                                                                    color:
                                                                        AppColors
                                                                            .grey,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10.w,
                                                                  ),
                                                                  CustomText(
                                                                    homeController
                                                                        .allProductsList[
                                                                            index]
                                                                        .createdAt
                                                                        .toString()
                                                                        .substring(
                                                                            0,
                                                                            10),
                                                                    fontSize:
                                                                        10.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        AppColors
                                                                            .grey,
                                                                  ),
                                                                ],
                                                              ),
                                                        SizedBox(
                                                          height: 7.h,
                                                        ),
                                                        widget.id == '6'
                                                            ? Row(
                                                                children: [
                                                                  CustomSvgImage(
                                                                    imageName:
                                                                        "title_icon",
                                                                    height:
                                                                        10.h,
                                                                    color: AppColors
                                                                        .black,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10.w,
                                                                  ),
                                                                  homeController
                                                                              .allProductsList[index]
                                                                              .brand ==
                                                                          null
                                                                      ? SizedBox()
                                                                      : CustomText(
                                                                          homeController.allProductsList[index].brand!.name ??
                                                                              "".toString(),
                                                                          fontSize:
                                                                              15.sp,
                                                                          color:
                                                                              AppColors.black,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                ],
                                                              )
                                                            : widget.id ==
                                                                        "3" ||
                                                                    widget.id ==
                                                                        "4"
                                                                ? SizedBox()
                                                                : Row(
                                                                    children: [
                                                                      CustomSvgImage(
                                                                        imageName:
                                                                            "title_icon",
                                                                        height:
                                                                            10.h,
                                                                        color: AppColors
                                                                            .black,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10.w,
                                                                      ),
                                                                      CustomText(
                                                                        homeController.allProductsList[index].name ??
                                                                            "",
                                                                        fontSize:
                                                                            15.sp,
                                                                        color: AppColors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ],
                                                                  ),
                                                        SizedBox(
                                                          height: 7.h,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 5.h,
                                                              width: 5.w,
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      AppColors
                                                                          .black,
                                                                  shape: BoxShape
                                                                      .circle),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Container(
                                                              constraints:
                                                                  BoxConstraints(
                                                                      maxWidth:
                                                                          300.w),
                                                              child: CustomText(
                                                                homeController
                                                                        .allProductsList[
                                                                            index]
                                                                        .description ??
                                                                    "",
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: AppColors
                                                                    .grey,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 7.h,
                                                        ),
                                                        if (widget.id == "1" ||
                                                            widget.id == "2" ||
                                                            widget.id == "9")
                                                          Row(
                                                            children: [
                                                              CustomSvgImage(
                                                                imageName:
                                                                    "color_icon",
                                                                height: 10.h,
                                                                color: AppColors
                                                                    .black,
                                                              ),
                                                              SizedBox(
                                                                width: 10.w,
                                                              ),
                                                              CustomText(
                                                                SPHelper.spHelper
                                                                            .getLanguage() ==
                                                                        "en"
                                                                    ? homeController
                                                                        .allProductsList[
                                                                            index]
                                                                        .color!
                                                                        .nameEn
                                                                    : homeController
                                                                        .allProductsList[
                                                                            index]
                                                                        .color!
                                                                        .name,
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: AppColors
                                                                    .black,
                                                              )
                                                            ],
                                                          ),
                                                        SizedBox(
                                                          height: 7.h,
                                                        ),
                                                        widget.id == "1" ||
                                                                widget.id ==
                                                                    "2" ||
                                                                widget.id ==
                                                                    "3" ||
                                                                widget.id == "4"
                                                            // widget.id == "9"
                                                            ? Row(
                                                                children: [
                                                                  CustomSvgImage(
                                                                    imageName:
                                                                        "badge_icon",
                                                                    height: 8.h,
                                                                    color: AppColors
                                                                        .black,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10.w,
                                                                  ),
                                                                  CustomText(
                                                                    homeController
                                                                        .allProductsList[
                                                                            index]
                                                                        .condition,
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                  Spacer(),
                                                                  CustomSvgImage(
                                                                    imageName:
                                                                        "location_icon",
                                                                    height:
                                                                        10.h,
                                                                    color:
                                                                        AppColors
                                                                            .grey,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10.w,
                                                                  ),
                                                                  CustomText(
                                                                    SPHelper.spHelper.getLanguage() ==
                                                                            "en"
                                                                        ? homeController
                                                                            .allProductsList[
                                                                                index]
                                                                            .city!
                                                                            .nameEn
                                                                        : homeController.allProductsList[index].city!.name ??
                                                                            "",
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        AppColors
                                                                            .grey,
                                                                  ),
                                                                ],
                                                              )
                                                            : SizedBox(),
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                        Divider(),
                                                        IntrinsicHeight(
                                                            child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 14.h),
                                                          child: new Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  UrlLauncher.launchUrl(Uri(
                                                                      scheme:
                                                                          "tel",
                                                                      path: homeController
                                                                          .allProductsList[
                                                                              index]
                                                                          .phone!));
                                                                },
                                                                child:
                                                                    CustomSvgImage(
                                                                  imageName:
                                                                      "call",
                                                                  height: 20.h,
                                                                  width: 20.w,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                              VerticalDivider(),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  launch(
                                                                      "https://wa.me/${homeController.allProductsList[index].whatsapp!}");
                                                                },
                                                                child:
                                                                    CustomSvgImage(
                                                                  imageName:
                                                                      "whatsapp",
                                                                  height: 20.h,
                                                                  width: 20.w,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )),
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                              ),
                                              SizedBox(
                                                height: 12.h,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ),
                        );
                }),
                Obx(() {
                  return homeController.getVendorsData.value.code == null
                      ? Helper.loading()
                      : LazyLoadScrollView(
                          onEndOfPage: () {
                            if (widget.id == "10") {
                              print(homeController
                                  .getVendorsData.value.data!.currentPage);
                              print(homeController
                                  .getVendorsData.value.data!.lastPage);

                              log('ennd');

                              if (homeController
                                      .getVendorsData.value.data!.currentPage !=
                                  homeController
                                      .getVendorsData.value.data!.lastPage) {
                                getVendorsByCategoryDataSource(
                                    homeController.getVendorsData.value.data!
                                            .currentPage! +
                                        1,
                                    false,
                                    "5");
                                // Apis.apis.getAllNews(
                                //   appController.allNewsApp.value.currentPage! + 1,
                                //   false,
                                // );
                              }
                            } else {
                              print(homeController
                                  .getVendorsData.value.data!.currentPage);
                              print(homeController
                                  .getVendorsData.value.data!.lastPage);

                              log('ennd');

                              if (homeController
                                      .getVendorsData.value.data!.currentPage !=
                                  homeController
                                      .getVendorsData.value.data!.lastPage) {
                                getVendorsByCategoryDataSource(
                                    homeController.getVendorsData.value.data!
                                            .currentPage! +
                                        1,
                                    false,
                                    widget.id!);
                                // Apis.apis.getAllNews(
                                //   appController.allNewsApp.value.currentPage! + 1,
                                //   false,
                                // );
                              }
                            }
                          },
                          child: RefreshIndicator(
                            onRefresh: () async {
                              if (widget.id == "10") {
                                getVendorsByCategoryDataSource(1, true, "5");
                              } else {
                                getVendorsByCategoryDataSource(
                                    1, true, widget.id.toString());
                              }
                            },
                            child: widget.id == "10"
                                ? SizedBox(
                                    width: Get.width,
                                    child: ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount:
                                          homeController.allProductsList.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            getProductById(homeController
                                                .allProductsList[index].id
                                                .toString());
                                            Get.to(() => CarAdSaleView(
                                                  id: homeController
                                                      .allProductsList[index].id
                                                      .toString(),
                                                ));
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              Container(
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  color: AppColors.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.23),
                                                      offset: Offset(0, 1),
                                                      blurRadius: 2,
                                                    ),
                                                  ],
                                                ),
                                                child: Column(children: [
                                                  Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      homeController
                                                                  .allProductsList[
                                                                      index]
                                                                  .categoryId
                                                                  .toString() ==
                                                              "3"
                                                          ? Container(
                                                              width: Get.width,
                                                              height: 272.h,
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .whiteColor),
                                                              child: Center(
                                                                  child:
                                                                      Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            20.w),
                                                                child:
                                                                    Container(
                                                                  width: 375.w,
                                                                  height: 80.h,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(15
                                                                              .r),
                                                                      border: Border.all(
                                                                          color: Color(
                                                                              0xff524188),
                                                                          width:
                                                                              3)),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            12.w),
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          homeController.allProductsList[index].simType.toString() == "1"
                                                                              ? CustomSvgImage(
                                                                                  imageName: "etisalat-seeklogo.com",
                                                                                  height: 80.h,
                                                                                )
                                                                              : CustomSvgImage(
                                                                                  imageName: "du-company-logo-1",
                                                                                  height: 40.h,
                                                                                ),
                                                                          CustomText(homeController
                                                                              .allProductsList[index]
                                                                              .phone),
                                                                          homeController.allProductsList[index].simType.toString() == "1"
                                                                              ? CustomSvgImage(
                                                                                  imageName: "etisalat-seeklogo.com",
                                                                                  height: 80.h,
                                                                                  color: Colors.transparent,
                                                                                )
                                                                              : CustomSvgImage(
                                                                                  imageName: "du-company-logo-1",
                                                                                  height: 40.h,
                                                                                  color: Colors.transparent,
                                                                                ),
                                                                        ]),
                                                                  ),
                                                                ),
                                                              )),
                                                            )
                                                          : homeController
                                                                      .allProductsList[
                                                                          index]
                                                                      .categoryId
                                                                      .toString() ==
                                                                  "4"
                                                              ? Container(
                                                                  width:
                                                                      Get.width,
                                                                  height: 200.h,
                                                                  child: Center(
                                                                      child:
                                                                          Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                      horizontal:
                                                                          12.w,
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width: Get
                                                                          .width,
                                                                      height:
                                                                          80.h,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(10
                                                                              .r),
                                                                          border: Border.all(
                                                                              color: AppColors.black,
                                                                              width: 2.w)),
                                                                      child: homeController.allProductsList[index].city!.id.toString() ==
                                                                              "1"
                                                                          ? Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                                                                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                                CustomText(
                                                                                  homeController.allProductsList[index].code ?? "X",
                                                                                  fontSize: 27.sp,
                                                                                ),
                                                                                CustomText(
                                                                                  homeController.allProductsList[index].vehicleNumber ?? "XXXXX",
                                                                                  fontSize: 27.sp,
                                                                                ),
                                                                                Image.network(
                                                                                  homeController.allProductsList[index].city!.logo!,
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
                                                                          : homeController.allProductsList[index].city!.id.toString() == "2"
                                                                              ? Padding(
                                                                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                                                  child: Row(children: [
                                                                                    Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Image.network(
                                                                                          homeController.allProductsList[index].city!.logo!,
                                                                                          height: 40.h,
                                                                                        ),
                                                                                        CustomText(
                                                                                          homeController.allProductsList[index].code ?? "X",
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 60.w,
                                                                                    ),
                                                                                    CustomText(homeController.allProductsList[index].vehicleNumber ?? "XXXXX"),
                                                                                  ]),
                                                                                )
                                                                              : homeController.allProductsList[index].city!.id.toString() == "3"
                                                                                  ?
//3
                                                                                  Padding(
                                                                                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                                                      child: Row(children: [
                                                                                        CustomText(
                                                                                          homeController.allProductsList[index].code ?? "X",
                                                                                          fontSize: 33.sp,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 20.w,
                                                                                        ),
                                                                                        Image.network(
                                                                                          homeController.allProductsList[index].city!.logo!,
                                                                                          height: 60.h,
                                                                                        ),
                                                                                        Spacer(),
                                                                                        CustomText(
                                                                                          homeController.allProductsList[index].vehicleNumber ?? "XXXXX",
                                                                                          fontSize: 33.sp,
                                                                                        ),
                                                                                      ]),
                                                                                    )
                                                                                  : homeController.allProductsList[index].city!.id.toString() == "4"
                                                                                      ?

                                                                                      //4
                                                                                      Row(children: [
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
                                                                                                homeController.allProductsList[index].code ?? "X",
                                                                                                fontSize: 33.sp,
                                                                                                color: AppColors.whiteColor,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 20.w,
                                                                                          ),
                                                                                          Image.network(
                                                                                            homeController.allProductsList[index].city!.logo!,
                                                                                            height: 60.h,
                                                                                          ),
                                                                                          Spacer(),
                                                                                          CustomText(
                                                                                            homeController.allProductsList[index].vehicleNumber ?? "XXXXX",
                                                                                            fontSize: 33.sp,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 20.w,
                                                                                          ),
                                                                                        ])
                                                                                      : homeController.allProductsList[index].city!.id.toString() == "5"
                                                                                          ? Padding(
                                                                                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                                                                                              child: Row(children: [
                                                                                                CustomText(
                                                                                                  homeController.allProductsList[index].code ?? "X",
                                                                                                  fontSize: 33.sp,
                                                                                                  color: AppColors.black,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: 20.w,
                                                                                                ),
                                                                                                Image.network(
                                                                                                  homeController.allProductsList[index].city!.logo!,
                                                                                                  height: 60.h,
                                                                                                ),
                                                                                                Spacer(),
                                                                                                CustomText(
                                                                                                  homeController.allProductsList[index].vehicleNumber ?? "XXXXX",
                                                                                                  fontSize: 33.sp,
                                                                                                ),
                                                                                              ]),
                                                                                            )
                                                                                          :
                                                                                          //6
                                                                                          Padding(
                                                                                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                                                                                              child: Row(children: [
                                                                                                CustomText(
                                                                                                  homeController.allProductsList[index].code ?? "X",
                                                                                                  fontSize: 33.sp,
                                                                                                  color: AppColors.black,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: 20.w,
                                                                                                ),
                                                                                                Image.network(
                                                                                                  homeController.allProductsList[index].city!.logo!,
                                                                                                  height: 60.h,
                                                                                                ),
                                                                                                Spacer(),
                                                                                                CustomText(
                                                                                                  homeController.allProductsList[index].vehicleNumber ?? "XXXXX",
                                                                                                  fontSize: 33.sp,
                                                                                                ),
                                                                                              ]),
                                                                                            ),
                                                                    ),
                                                                  )),
                                                                )
                                                              : GestureDetector(
                                                                  onTap: () {
                                                                    getProductById(homeController
                                                                        .allProductsList[
                                                                            index]
                                                                        .id
                                                                        .toString());
                                                                    Get.to(() =>
                                                                        CarAdSaleView(
                                                                          id: homeController
                                                                              .allProductsList[index]
                                                                              .id
                                                                              .toString(),
                                                                        ));
                                                                  },
                                                                  child:
                                                                      CachedNetworkImageShare(
                                                                    homeController
                                                                            .allProductsList[index]
                                                                            .photo ??
                                                                        "",
                                                                    210.h,
                                                                    Get.width,
                                                                    15,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                      // Padding(
                                                      //   padding: EdgeInsets.all(
                                                      //       12.r),
                                                      //   child: Row(
                                                      //     children: [
                                                      //       Container(
                                                      //         height: 24.h,
                                                      //         width: 24.w,
                                                      //         decoration:
                                                      //             BoxDecoration(
                                                      //           shape: BoxShape
                                                      //               .circle,
                                                      //           color: AppColors
                                                      //               .whiteColor,
                                                      //         ),
                                                      //         child:
                                                      //             CachedNetworkImageShare(
                                                      //           "https://cdn4.vectorstock.com/i/1000x1000/77/43/young-man-head-avatar-cartoon-face-character-vector-21757743.jpg",
                                                      //           24.h,
                                                      //           24.w,
                                                      //           0,
                                                      //         ),
                                                      //       ),
                                                      //       // Spacer(),
                                                      //       // CustomSvgImage(
                                                      //       //   imageName:
                                                      //       //       "heart_car",
                                                      //       //   height: 12.h,
                                                      //       //   width: 11.w,
                                                      //       //   color: AppColors.red,
                                                      //       // )
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                     Positioned(
                                                            bottom: -7.h,
                                                            child: Container(
                                                              width: 343.w,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        20.h,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppColors
                                                                          .whiteColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              11.r),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: homeController.allProductsList[index].plan!.id.toString() == "2"
                                                                              ? AppColors.green
                                                                              : homeController.allProductsList[index].plan!.id.toString() == "1"
                                                                                  ? Color(0xffFBAA30)
                                                                                  : AppColors.red,
                                                                          offset: Offset(
                                                                              0,
                                                                              0),
                                                                          blurRadius:
                                                                              2,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            5.w,
                                                                        vertical:
                                                                            3.h,
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          CustomSvgImage(
                                                                            imageName:
                                                                                "taj",
                                                                            color: homeController.allProductsList[index].plan!.id.toString() == "2"
                                                                                ? AppColors.green
                                                                                : homeController.allProductsList[index].plan!.id.toString() == "1"
                                                                                    ? Color(0xffFBAA30)
                                                                                    : AppColors.red,
                                                                            height:
                                                                                15.h,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                5.w,
                                                                          ),
                                                                          CustomText(
                                                                            homeController.allProductsList[index].plan!.title!,
                                                                            fontSize:
                                                                                12.sp,
                                                                            color: homeController.allProductsList[index].plan!.id.toString() == "2"
                                                                                ? AppColors.green
                                                                                : homeController.allProductsList[index].plan!.id.toString() == "1"
                                                                                    ? Color(0xffFBAA30)
                                                                                    : AppColors.red,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),

                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.w),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        if (widget.id != "4" ||
                                                            widget.id != "3")
                                                          Row(
                                                            children: [
                                                              CustomSvgImage(
                                                                imageName:
                                                                    "title_icon",
                                                                height: 10.h,
                                                                color: AppColors
                                                                    .black,
                                                              ),
                                                              SizedBox(
                                                                width: 10.w,
                                                              ),
                                                              CustomText(
                                                                homeController
                                                                        .allProductsList[
                                                                            index]
                                                                        .name ??
                                                                    "",
                                                                fontSize: 15.sp,
                                                                color: AppColors
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                              Spacer(),
                                                              CustomSvgImage(
                                                                imageName:
                                                                    "time_icon",
                                                                height: 10.h,
                                                                width: 8.w,
                                                                color: AppColors
                                                                    .grey,
                                                              ),
                                                              SizedBox(
                                                                width: 10.w,
                                                              ),
                                                              CustomText(
                                                                homeController
                                                                    .allProductsList[
                                                                        index]
                                                                    .createdAt
                                                                    .toString()
                                                                    .substring(
                                                                        0, 10),
                                                                fontSize: 10.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: AppColors
                                                                    .grey,
                                                              ),
                                                            ],
                                                          ),
                                                        SizedBox(
                                                          height: 7.h,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 5.h,
                                                              width: 5.w,
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      AppColors
                                                                          .black,
                                                                  shape: BoxShape
                                                                      .circle),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Container(
                                                              constraints:
                                                                  BoxConstraints(
                                                                      maxWidth:
                                                                          300.w),
                                                              child: CustomText(
                                                                homeController
                                                                        .allProductsList[
                                                                            index]
                                                                        .description ??
                                                                    "",
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: AppColors
                                                                    .grey,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                        Divider(),
                                                        IntrinsicHeight(
                                                            child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 14.h),
                                                          child: new Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  UrlLauncher.launchUrl(Uri(
                                                                      scheme:
                                                                          "tel",
                                                                      path: homeController
                                                                          .allProductsList[
                                                                              index]
                                                                          .phone!));
                                                                },
                                                                child:
                                                                    CustomSvgImage(
                                                                  imageName:
                                                                      "call",
                                                                  height: 20.h,
                                                                  width: 20.w,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                              VerticalDivider(),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  launch(
                                                                      "https://wa.me/${homeController.allProductsList[index].whatsapp!}");
                                                                },
                                                                child:
                                                                    CustomSvgImage(
                                                                  imageName:
                                                                      "whatsapp",
                                                                  height: 20.h,
                                                                  width: 20.w,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )),
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                              ),
                                              SizedBox(
                                                height: 12.h,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : SizedBox(
                                    width: Get.width,
                                    child: ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount:
                                          homeController.allVendorsList.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            getVendorProfileDataSource(
                                              homeController
                                                  .allVendorsList[index]
                                                  .user!
                                                  .id
                                                  .toString(),
                                              1,
                                              true,
                                            );

                                            Get.to(() => VendorProfileView());
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              Container(
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  color: AppColors.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.23),
                                                      offset: Offset(0, 1),
                                                      blurRadius: 2,
                                                    ),
                                                  ],
                                                ),
                                                child: Column(children: [
                                                  Stack(
                                                    children: [
                                                      CachedNetworkImageShare(
                                                        homeController
                                                                .allVendorsList[
                                                                    index]
                                                                .user!
                                                                .photo ??
                                                            "",
                                                        210.h,
                                                        Get.width,
                                                        15,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      // Padding(
                                                      //   padding: EdgeInsets.all(
                                                      //       15.r),
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment
                                                      //             .end,
                                                      //     children: [
                                                      //       CustomSvgImage(
                                                      //         imageName:
                                                      //             "heart_car",
                                                      //         height: 12.h,
                                                      //         width: 11.w,
                                                      //         color:
                                                      //             AppColors.red,
                                                      //       )
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.w),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        if (widget.id != "3" ||
                                                            widget.id != "4")
                                                          Row(
                                                            children: [
                                                              CustomSvgImage(
                                                                imageName:
                                                                    "title_icon",
                                                                height: 7.h,
                                                              ),
                                                              SizedBox(
                                                                width: 12.w,
                                                              ),
                                                              CustomText(
                                                                homeController
                                                                            .allVendorsList[
                                                                                index]
                                                                            .user!
                                                                            .name
                                                                            .toString()
                                                                            .length >
                                                                        25
                                                                    ? homeController
                                                                            .allVendorsList[
                                                                                index]
                                                                            .user!
                                                                            .name
                                                                            .toString()
                                                                            .substring(0,
                                                                                25) +
                                                                        ".."
                                                                    : homeController
                                                                        .allVendorsList[
                                                                            index]
                                                                        .user!
                                                                        .name
                                                                        .toString(),
                                                                fontSize: 17.h,
                                                                color: AppColors
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                              Spacer(),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      CustomSvgImage(
                                                                        imageName:
                                                                            "time_icon",
                                                                        height:
                                                                            10.h,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10.w,
                                                                      ),
                                                                      CustomText(
                                                                        homeController
                                                                            .allVendorsList[
                                                                                index]
                                                                            .user!
                                                                            .createdAt
                                                                            .toString()
                                                                            .substring(0,
                                                                                10),
                                                                        fontSize:
                                                                            10.sp,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 3.h,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      CustomSvgImage(
                                                                        imageName:
                                                                            "location_icon",
                                                                        height:
                                                                            12.h,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10.w,
                                                                      ),
                                                                      homeController.allVendorsList[index].city ==
                                                                              null
                                                                          ? CustomText(
                                                                              "")
                                                                          : CustomText(
                                                                              SPHelper.spHelper.getLanguage() == "en" ? homeController.allVendorsList[index].city!.nameEn! : homeController.allVendorsList[index].city!.name!,
                                                                              fontSize: 10.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Colors.grey,
                                                                            ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        Divider(),
                                                        IntrinsicHeight(
                                                            child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 14.h),
                                                          child: new Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  showModalBottomSheet(
                                                                    isDismissible:
                                                                        true,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                16.h,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 16.w),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    Get.back();
                                                                                  },
                                                                                  child: CustomText(
                                                                                    "Cancel",
                                                                                    fontSize: 16.w,
                                                                                    color: AppColors.primaryColor,
                                                                                    fontWeight: FontWeight.w400,
                                                                                  ),
                                                                                ),
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    Get.back();
                                                                                    UrlLauncher.launchUrl(Uri(scheme: "tel", path: homeController.getVendorsData.value.data!.data![index].user!.phones![homeController.indexNumber.value].number));
                                                                                  },
                                                                                  child: CustomText(
                                                                                    "Done",
                                                                                    fontSize: 16.w,
                                                                                    color: AppColors.primaryColor,
                                                                                    fontWeight: FontWeight.w400,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                30.h,
                                                                          ),
                                                                          homeController.getVendorsData.value.data!.data![index].user!.phones!.length == 0
                                                                              ? Column(
                                                                                  children: [
                                                                                    CustomText(
                                                                                      "There is No Numbers",
                                                                                      fontSize: 12.sp,
                                                                                      fontWeight: FontWeight.w400,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 30.h,
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : SizedBox(
                                                                                  width: Get.width,
                                                                                  height: 100.h,
                                                                                  child: ListView.builder(
                                                                                    shrinkWrap: true,
                                                                                    primary: false,
                                                                                    itemCount: homeController.allVendorsList[index].user!.phones!.length,
                                                                                    itemBuilder: (context, index2) {
                                                                                      return Obx(() => GestureDetector(
                                                                                            onTap: () {
                                                                                              homeController.setIndexNumber(index2);
                                                                                            },
                                                                                            child: Column(
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                                                                                                  child: Container(
                                                                                                      width: Get.width,
                                                                                                      height: 34.h,
                                                                                                      decoration: BoxDecoration(color: homeController.indexNumber.value == index2 ? Color(0xff747480).withOpacity(0.23) : Colors.transparent, borderRadius: BorderRadius.circular(8.r)),
                                                                                                      child: Center(
                                                                                                          child: CustomText(
                                                                                                        homeController.allVendorsList[index].user!.phones![index2].number,
                                                                                                        fontSize: 12.sp,
                                                                                                        fontWeight: FontWeight.w400,
                                                                                                        color: homeController.indexNumber.value == index2 ? AppColors.black : AppColors.grey,
                                                                                                      ))),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 8.h,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ));
                                                                                    },
                                                                                  ),
                                                                                )
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child:
                                                                    CustomSvgImage(
                                                                  imageName:
                                                                      "call",
                                                                  height: 20.h,
                                                                  width: 20.w,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                              VerticalDivider(),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  launch(
                                                                      "https://wa.me/${homeController.allVendorsList[index].user!.phoneNumber!}");
                                                                },
                                                                child:
                                                                    CustomSvgImage(
                                                                  imageName:
                                                                      "whatsapp",
                                                                  height: 20.h,
                                                                  width: 20.w,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )),
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                              ),
                                              SizedBox(
                                                height: 12.h,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ),
                        );
                }),
              ]),
        )

        // })
      ]),
    );
  }
}
