import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/services/dynamic_link.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/cached_network_image.dart';
import 'package:car_rental/features/car_ad_sale_view/data/data_sources/get_product_by_id_data_source.dart';
import 'package:car_rental/features/vendor_profile_view/data/data_sources/vendor_profile_by_id.dart';
import 'package:car_rental/features/vendor_profile_view/presentation/views/vendor_profile_view.dart';
import 'package:car_rental/features/wishlist_view/data/data_sources/add_to_wishlist_data_source.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

class CarAdSaleView extends StatefulWidget {
  final String? id;
  CarAdSaleView({this.id});

  @override
  State<CarAdSaleView> createState() => _CarAdSaleViewState();
}

class _CarAdSaleViewState extends State<CarAdSaleView> {
  HomeController homeController = Get.find();

  bool isFavorite = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().cleanFilter();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: Obx(() {
      return homeController.getProductByIdData.value.code == null
          ? SizedBox()
          : Container(
              width: Get.width,
              height: 120.h,
              decoration: BoxDecoration(color: AppColors.whiteColor),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        UrlLauncher.launchUrl(Uri(
                            scheme: "tel",
                            path: homeController
                                .getProductByIdData.value.data!.phone!));
                      },
                      child: Container(
                        width: 150.w,
                        height: 59.h,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(15.r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomSvgImage(
                                    imageName: "call",
                                    color: AppColors.whiteColor,
                                    height: 25.h,
                                    width: 20.w,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomText(
                                    "Call",
                                    fontSize: 15.sp,
                                    color: AppColors.whiteColor,
                                    // fontWeight: FontWeight.w400,
                                    fontFamily: "tajawal",
                                  )
                                ]),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        launch(
                            "https://wa.me/${homeController.getProductByIdData.value.data!.whatsapp!}");
                      },
                      child: Container(
                        width: 150.w,
                        height: 59.h,
                        decoration: BoxDecoration(
                            color: Color(0xff25D366),
                            borderRadius: BorderRadius.circular(15.r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomSvgImage(
                                    imageName: "whatsapp",
                                    color: AppColors.whiteColor,
                                    height: 25.h,
                                    width: 20.w,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomText(
                                    "Whatsapp",
                                    fontSize: 15.sp,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "tajawal",
                                  )
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
    }), body: Obx(() {
      return homeController.getProductByIdData.value.code == null
          ? Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Helper.loading()
              ],
            )
          : RefreshIndicator(
              onRefresh: () async {
                getProductById(widget.id!);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      homeController.getProductByIdData.value.data!.category!.id
                                  .toString() ==
                              "3"
                          ? Container(
                              width: Get.width,
                              height: 272.h,
                              decoration:
                                  BoxDecoration(color: AppColors.whiteColor),
                              child: Center(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Container(
                                  width: 375.w,
                                  height: 80.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.r),
                                      border: Border.all(
                                          color: Color(0xff524188), width: 3)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          homeController.getProductByIdData
                                                      .value.data!.simType
                                                      .toString() ==
                                                  "1"
                                              ? CustomSvgImage(
                                                  imageName:
                                                      "etisalat-seeklogo.com",
                                                  height: 20.h,
                                                )
                                              : CustomSvgImage(
                                                  imageName:
                                                      "du-company-logo-1",
                                                  height: 40.h,
                                                ),
                                          SizedBox(
                                            width: 30.w,
                                          ),
                                          CustomText(homeController
                                              .getProductByIdData
                                              .value
                                              .data!
                                              .phone),
                                          homeController.getProductByIdData
                                                      .value.data!.simType
                                                      .toString() ==
                                                  "1"
                                              ? CustomSvgImage(
                                                  imageName:
                                                      "etisalat-seeklogo.com",
                                                  height: 10.h,
                                                  color: Colors.transparent,
                                                )
                                              : CustomSvgImage(
                                                  imageName:
                                                      "du-company-logo-1",
                                                  height: 40.h,
                                                  color: Colors.transparent,
                                                ),
                                        ]),
                                  ),
                                ),
                              )),
                            )
                          : homeController.getProductByIdData.value.data!
                                      .category!.id
                                      .toString() ==
                                  "4"
                              ? Container(
                                  width: Get.width,
                                  height: 272.h,
                                  decoration: BoxDecoration(
                                      color: AppColors.whiteColor),
                                  child: Center(
                                      child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    child: homeController.getProductByIdData
                                                .value.data!.photo !=
                                            null
                                        ? Image.network(
                                            homeController.getProductByIdData
                                                .value.data!.photo
                                                .toString(),
                                          )
                                        : SizedBox(),
                                  )),
                                )
                              : homeController.getProductByIdData.value.data!
                                          .category!.id
                                          .toString() ==
                                      "6"
                                  ? Container(
                                      height: 272.h,
                                      width: Get.width,
                                      decoration: BoxDecoration(),
                                      child: Center(
                                        child: homeController.getProductByIdData
                                                    .value.data!.brand ==
                                                null
                                            ? CustomText(
                                                "No Brand Image",
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              )
                                            : Image.network(homeController
                                                .getProductByIdData
                                                .value
                                                .data!
                                                .brand!
                                                .logo!),
                                      ),
                                    )
                                  : homeController.getProductByIdData.value
                                              .data!.pictures!.length ==
                                          0
                                      ? Container(
                                          width: Get.width,
                                          height: 200.h,
                                          child: Center(
                                              child: CustomText(
                                            "There is No Images",
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          )),
                                        )
                                      : CarouselSlider.builder(
                                          itemCount: homeController
                                              .getProductByIdData
                                              .value
                                              .data!
                                              .pictures!
                                              .length,
                                          itemBuilder: (BuildContext context,
                                                  int itemIndex,
                                                  int pageViewIndex) =>
                                              CachedNetworkImageShare(
                                            homeController
                                                    .getProductByIdData
                                                    .value
                                                    .data!
                                                    .pictures![itemIndex]
                                                    .image ??
                                                "",
                                            272.h,
                                            Get.width,
                                            1,
                                            fit: BoxFit.cover,
                                          ),
                                          options: CarouselOptions(
                                              onPageChanged: (index, reason) {},
                                              viewportFraction: 1,
                                              autoPlay: true,
                                              initialPage: 0,
                                              height: 272.h,
                                              disableCenter: true,
                                              enlargeCenterPage: true),
                                        ),
                      Positioned(
                        top: 40.h,
                        child: Container(
                          width: Get.width,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: AppColors.whiteColor,
                                  )),
                              Spacer(),
                              IconButton(
                                  padding: EdgeInsets.all(15.r),
                                  onPressed: () {
                                    log("ttttt");
                                    DynamicLinkService().createDynamicLink(
                                        id: homeController
                                            .getProductByIdData.value.data!.id
                                            .toString(),
                                        imageUrl: homeController
                                                .getProductByIdData
                                                .value
                                                .data!
                                                .photo ??
                                            "",
                                        title: homeController.getProductByIdData
                                                .value.data!.name ??
                                            "",
                                        description: homeController
                                                .getProductByIdData
                                                .value
                                                .data!
                                                .description ??
                                            "");
                                  },
                                  icon: Icon(
                                    Icons.share,
                                    color: AppColors.whiteColor,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      // Positioned(
                      //   bottom: -10.h,
                      //   child: Container(
                      //     width: Get.width,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Container(
                      //           height: 20.h,
                      //           decoration: BoxDecoration(
                      //             color: AppColors.whiteColor,
                      //             borderRadius: BorderRadius.circular(11.r),
                      //             boxShadow: [
                      //               BoxShadow(
                      //                 color: homeController.getProductByIdData
                      //                             .value.data!.plan!.id
                      //                             .toString() ==
                      //                         "2"
                      //                     ? AppColors.green
                      //                     : homeController.getProductByIdData
                      //                                 .value.data!.plan!.id
                      //                                 .toString() ==
                      //                             "1"
                      //                         ? Color(0xffFBAA30)
                      //                         : AppColors.red,
                      //                 offset: Offset(0, 0),
                      //                 blurRadius: 2,
                      //               ),
                      //             ],
                      //           ),
                      //           child: Padding(
                      //             padding: EdgeInsets.symmetric(
                      //               horizontal: 5.w,
                      //               vertical: 3.h,
                      //             ),
                      //             child: Row(
                      //               children: [
                      //                 CustomSvgImage(
                      //                   imageName: "taj",
                      //                   color: homeController.getProductByIdData
                      //                               .value.data!.plan!.id
                      //                               .toString() ==
                      //                           "2"
                      //                       ? AppColors.green
                      //                       : homeController.getProductByIdData
                      //                                   .value.data!.plan!.id
                      //                                   .toString() ==
                      //                               "1"
                      //                           ? Color(0xffFBAA30)
                      //                           : AppColors.red,
                      //                   height: 15.h,
                      //                 ),
                      //                 SizedBox(
                      //                   width: 5.w,
                      //                 ),
                      //                 CustomText(
                      //                   homeController.getProductByIdData.value
                      //                       .data!.plan!.title,
                      //                   fontSize: 12.sp,
                      //                   color: homeController.getProductByIdData
                      //                               .value.data!.plan!.id
                      //                               .toString() ==
                      //                           "2"
                      //                       ? AppColors.green
                      //                       : homeController.getProductByIdData
                      //                                   .value.data!.plan!.id
                      //                                   .toString() ==
                      //                               "1"
                      //                           ? Color(0xffFBAA30)
                      //                           : AppColors.red,
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          homeController
                                      .getProductByIdData.value.data!.user!.type
                                      .toString() ==
                                  "1"
                              ? GestureDetector(
                                  onTap: () {
                                    getVendorProfileDataSource(
                                        homeController.getProductByIdData.value
                                            .data!.user!.id
                                            .toString(),
                                        1,
                                        true);
                                    Get.to(() => VendorProfileView());
                                  },
                                  child: CachedNetworkImageShare(
                                      homeController.getProductByIdData.value
                                              .data!.user!.photo ??
                                          "",
                                      30,
                                      30,
                                      0),
                                )
                              : CustomPngImage(
                                  imageName: "male_image",
                                  height: 30.h,
                                ),
                          homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      5 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      7
                              ? SizedBox()
                              : homeController.getProductByIdData.value.data!
                                          .category!.id
                                          .toString() ==
                                      "6"
                                  ? SizedBox()
                                  : Row(
                                      children: [
                                        CustomText(
                                          homeController
                                                      .getProductByIdData
                                                      .value
                                                      .data!
                                                      .typeProduct ==
                                                  "for_rent"
                                              ? homeController
                                                      .getProductByIdData
                                                      .value
                                                      .data!
                                                      .priceDaily ??
                                                  ""
                                              : homeController
                                                  .getProductByIdData
                                                  .value
                                                  .data!
                                                  .price
                                                  .toString(),
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.primaryColor,
                                        ),
                                        CustomText(
                                          homeController
                                                      .getProductByIdData
                                                      .value
                                                      .data!
                                                      .typeProduct ==
                                                  "for_rent"
                                              ? " / Daily".tr
                                              : " AED",
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.primaryColor,
                                        ),
                                      ],
                                    ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                                addToWishlistDataSource(
                                    product_id: homeController
                                        .getProductByIdData.value.data!.id
                                        .toString());
                              },
                              icon: homeController.getProductByIdData.value
                                              .data!.isFavorit ==
                                          0 &&
                                      isFavorite != true
                                  ? Icon(
                                      Icons.favorite_border,
                                      color: AppColors.grey,
                                    )
                                  : Icon(
                                      Icons.favorite,
                                      color: AppColors.primaryColor,
                                    ))
                          // CustomSvgImage(
                          //   imageName: "heart_car",
                          //   height: 15.h,
                          //   width: 17.w,
                          // )
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5.w,
                          ),
                          CustomSvgImage(
                            imageName: "location_icon",
                            height: 16.h,
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          CustomText(
                            SPHelper.spHelper.getLanguage() == "en"
                                ? homeController
                                    .getProductByIdData.value.data!.city!.nameEn
                                : homeController.getProductByIdData.value.data!
                                        .city!.name! ??
                                    "",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          Spacer(),
                          CustomText(
                            homeController
                                .getProductByIdData.value.data!.createdAt
                                .toString()
                                .substring(0, 10),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 27.h,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     CustomSvgImage(
                      //       imageName: "taj",
                      //       color: AppColors.green,
                      //       height: 15.h,
                      //     ),
                      //     SizedBox(
                      //       width: 5.w,
                      //     ),
                      //     CustomText(
                      //       homeController
                      //           .getProductByIdData.value.data!.plan!.title,
                      //       fontSize: 14.sp,
                      //       fontWeight: FontWeight.w400,
                      //       color: AppColors.green,
                      //     ),
                      //   ],
                      // ),

                      Divider(),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            "Details",
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      1 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      2 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      9
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Brand",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    homeController.getProductByIdData.value
                                                .data!.brand ==
                                            null
                                        ? SizedBox()
                                        : CustomText(
                                            homeController.getProductByIdData
                                                    .value.data!.brand!.name ??
                                                "",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                  ],
                                )
                              : SizedBox(),

                          homeController.getProductByIdData.value.data!
                                      .categoryId ==
                                  6
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Brand Car Parts",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    homeController.getProductByIdData.value
                                                .data!.brand ==
                                            null
                                        ? SizedBox()
                                        : CustomText(
                                            homeController.getProductByIdData
                                                    .value.data!.brand!.name ??
                                                "",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                  ],
                                )
                              : SizedBox(),
                          homeController.getProductByIdData.value.data!
                                      .categoryId ==
                                  3
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Sim Type",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    CustomText(
                                      homeController.getProductByIdData.value
                                                  .data!.simType ==
                                              "1"
                                          ? "Etisalat"
                                          : "Du",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          homeController.getProductByIdData.value.data!
                                      .categoryId ==
                                  4
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Vehicle Type",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    CustomText(
                                      homeController.getProductByIdData.value
                                          .data!.vehicleType
                                          .toString()
                                          .tr,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 17.h,
                          ),
                          Divider(),
                          homeController.getProductByIdData.value.data!
                                      .categoryId ==
                                  6
                              ? SizedBox()
                              : SizedBox(
                                  height: 17.h,
                                ),

                          homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      1 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      2 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      9
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Car Model",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    homeController.getProductByIdData.value
                                                .data!.style ==
                                            null
                                        ? CustomText(
                                            "",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                          )
                                        : CustomText(
                                            homeController.getProductByIdData
                                                    .value.data!.style!.name ??
                                                "",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                  ],
                                )
                              : SizedBox(),
                          homeController.getProductByIdData.value.data!
                                      .categoryId ==
                                  3
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Number",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    CustomText(
                                      homeController
                                          .getProductByIdData.value.data!.phone,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          homeController.getProductByIdData.value.data!
                                      .categoryId ==
                                  4
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Number Type",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    CustomText(
                                      homeController.getProductByIdData.value
                                          .data!.numberType,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      5 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      7
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Service Name ",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    CustomText(
                                      homeController.getProductByIdData.value
                                              .data!.name ??
                                          "",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          homeController.getProductByIdData.value.data!
                                      .categoryId ==
                                  6
                              ? SizedBox()
                              : SizedBox(
                                  height: 17.h,
                                ),
                          homeController.getProductByIdData.value.data!
                                      .categoryId ==
                                  6
                              ? SizedBox()
                              : Divider(),
                          homeController.getProductByIdData.value.data!
                                      .categoryId ==
                                  6
                              ? SizedBox()
                              : SizedBox(
                                  height: 17.h,
                                ),
                          // homeController.getProductByIdData.value.data!
                          //             .categoryId ==
                          //         9
                          //     ? Row(
                          //         children: [
                          //           CustomText(
                          //             "Yearly Price",
                          //             fontSize: 15.sp,
                          //             fontWeight: FontWeight.w400,
                          //           ),
                          //           Spacer(),
                          //           CustomText(
                          //             homeController.getProductByIdData.value
                          //                     .data!.priceYearly ??
                          //                 "",
                          //             fontSize: 15.sp,
                          //             fontWeight: FontWeight.w400,
                          //           ),
                          //         ],
                          //       )
                          //     : SizedBox(),
                          homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      1 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      2 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      9
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Production Year",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    homeController.getProductByIdData.value
                                                .data!.productionYear ==
                                            null
                                        ? SizedBox()
                                        : CustomText(
                                            homeController.getProductByIdData
                                                .value.data!.productionYear,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                  ],
                                )
                              : SizedBox(),
                          homeController.getProductByIdData.value.data!
                                      .categoryId ==
                                  3
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Condition",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    CustomText(
                                      homeController.getProductByIdData.value
                                          .data!.condition,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          homeController.getProductByIdData.value.data!
                                      .categoryId ==
                                  4
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Vehicle Number",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    CustomText(
                                      homeController.getProductByIdData.value
                                              .data!.vehicleNumber ??
                                          "",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      5 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      7
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Car Services Type",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    CustomText(
                                      homeController.getProductByIdData.value
                                              .data!.category!.name ??
                                          "",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      6 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      3
                              ? SizedBox()
                              : SizedBox(
                                  height: 17.h,
                                ),
                          homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      6 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      3
                              ? SizedBox()
                              : Divider(),
                          homeController
                                          .getProductByIdData.value.data!.categoryId ==
                                      6 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      3 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      5 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      7
                              ? SizedBox()
                              : SizedBox(
                                  height: 17.h,
                                ),
                          homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      1 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      2 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      9
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Car Paint Color",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    homeController.getProductByIdData.value
                                                .data!.color ==
                                            null
                                        ? SizedBox()
                                        : CustomText(
                                            SPHelper.spHelper.getLanguage() ==
                                                    "en"
                                                ? homeController
                                                    .getProductByIdData
                                                    .value
                                                    .data!
                                                    .color!
                                                    .nameEn
                                                : homeController
                                                    .getProductByIdData
                                                    .value
                                                    .data!
                                                    .color!
                                                    .name,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                  ],
                                )
                              : SizedBox(),

                          homeController.getProductByIdData.value.data!
                                      .categoryId ==
                                  4
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Code",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    CustomText(
                                      homeController.getProductByIdData.value
                                              .data!.code ??
                                          "",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          homeController
                                          .getProductByIdData.value.data!.categoryId ==
                                      6 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      3 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      5 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      7
                              ? SizedBox()
                              : SizedBox(
                                  height: 17.h,
                                ),
                          homeController
                                          .getProductByIdData.value.data!.categoryId ==
                                      6 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      3 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      5 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      7
                              ? SizedBox()
                              : Divider(),
                          homeController.getProductByIdData.value.data!.categoryId == 6 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      3 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      4 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      5 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      7
                              ? SizedBox()
                              : SizedBox(
                                  height: 17.h,
                                ),
                          homeController.getProductByIdData.value.data!
                                      .categoryId ==
                                  9
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Daily Price",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    homeController.getProductByIdData.value
                                                .data!.priceDaily ==
                                            null
                                        ? SizedBox()
                                        : CustomText(
                                            homeController
                                                        .getProductByIdData
                                                        .value
                                                        .data!
                                                        .priceDaily +
                                                    " AED" ??
                                                "",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                  ],
                                )
                              : SizedBox(),
                          homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      1 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      2
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Condition",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    CustomText(
                                      homeController.getProductByIdData.value
                                          .data!.condition,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          homeController.getProductByIdData.value.data!.categoryId == 6 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      3 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      4 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      5 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      7
                              ? SizedBox()
                              : SizedBox(
                                  height: 17.h,
                                ),
                          homeController.getProductByIdData.value.data!.categoryId == 6 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      3 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      4 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      5 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      7
                              ? SizedBox()
                              : Divider(),
                          homeController.getProductByIdData.value.data!.categoryId == 6 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      3 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      4 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      5 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      7
                              ? SizedBox()
                              : SizedBox(
                                  height: 17.h,
                                ),
                          homeController.getProductByIdData.value.data!
                                      .categoryId ==
                                  9
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Monthly Price",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    homeController.getProductByIdData.value
                                                .data!.priceMonthly ==
                                            null
                                        ? SizedBox()
                                        : CustomText(
                                            homeController
                                                        .getProductByIdData
                                                        .value
                                                        .data!
                                                        .priceMonthly +
                                                    " AED" ??
                                                "",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                  ],
                                )
                              : SizedBox(),
                          homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      1 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      2
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Kilometers",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    CustomText(
                                      "${homeController.getProductByIdData.value.data!.kilometer} Km",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          homeController
                                          .getProductByIdData.value.data!.categoryId ==
                                      6 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      4 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      5 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      7
                              ? SizedBox()
                              : SizedBox(
                                  height: 17.h,
                                ),
                          homeController
                                          .getProductByIdData.value.data!.categoryId ==
                                      6 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      4 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      5 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      7
                              ? SizedBox()
                              : Divider(),

                          homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      6 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      5 ||
                                  homeController.getProductByIdData.value.data!
                                          .categoryId ==
                                      7
                              ? SizedBox()
                              : SizedBox(
                                  height: 17.h,
                                ),
                          homeController.getProductByIdData.value.data!
                                      .categoryId ==
                                  9
                              ? Row(
                                  children: [
                                    CustomText(
                                      "Yearly Price",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Spacer(),
                                    homeController.getProductByIdData.value
                                                .data!.priceYearly ==
                                            null
                                        ? SizedBox()
                                        : CustomText(
                                            homeController
                                                        .getProductByIdData
                                                        .value
                                                        .data!
                                                        .priceYearly +
                                                    " AED" ??
                                                "",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 24.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                "Description",
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomText(
                            homeController.getProductByIdData.value.data!
                                    .description ??
                                "",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 29.h,
                          ),
                          Divider(),
                          SizedBox(
                            height: 24.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                "Related Ads",
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 22.h,
                          ),
                          SizedBox(
                            height: 180.h,
                            child: ListView.builder(
                              itemCount: homeController.getProductByIdData.value
                                  .data!.related!.length,
                              shrinkWrap: true,
                              primary: false,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index1) {
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        getProductById(homeController
                                            .getProductByIdData
                                            .value
                                            .data!
                                            .related![index1]
                                            .id
                                            .toString());
                                        // Get.to(() => CarAdSaleView());
                                      },
                                      child: Container(
                                        width: 115.w,
                                        height: 170.h,
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0x1aff0000),
                                              offset: Offset(0, 4),
                                              blurRadius: 6,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            homeController
                                                        .getProductByIdData
                                                        .value
                                                        .data!
                                                        .related![index1]
                                                        .categoryId
                                                        .toString() ==
                                                    "3"
                                                ? Container(
                                                    width: Get.width,
                                                    height: 77.h,
                                                    child: Center(
                                                        child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.w),
                                                      child: Container(
                                                        height: 35.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xff524188),
                                                                width: 2)),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      2.w),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              homeController
                                                                          .getProductByIdData
                                                                          .value
                                                                          .data!
                                                                          .related![
                                                                              index1]
                                                                          .simType
                                                                          .toString() ==
                                                                      "1"
                                                                  ? CustomSvgImage(
                                                                      imageName:
                                                                          "etisalat-seeklogo.com",
                                                                      height:
                                                                          10.h,
                                                                    )
                                                                  : CustomSvgImage(
                                                                      imageName:
                                                                          "du-company-logo-1",
                                                                      height:
                                                                          10.h,
                                                                    ),
                                                              CustomText(
                                                                homeController
                                                                    .getProductByIdData
                                                                    .value
                                                                    .data!
                                                                    .related![
                                                                        index1]
                                                                    .phone,
                                                                fontSize: 8.sp,
                                                              ),
                                                              // homeController.getMostPopularData.value.mostPobuler![index].products![index1].simType == "1"
                                                              //     ? CustomSvgImage(
                                                              //         imageName: "etisalat-seeklogo.com",
                                                              //         height: 20.h,
                                                              //         color: Colors.transparent,
                                                              //       )
                                                              //     : CustomSvgImage(
                                                              //         imageName: "du-company-logo-1",
                                                              //         height: 10.h,
                                                              //         color: Colors.transparent,
                                                              //       ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                                  )
                                                : homeController
                                                            .getProductByIdData
                                                            .value
                                                            .data!
                                                            .related![index1]
                                                            .categoryId
                                                            .toString() ==
                                                        "4"
                                                    ? Container(
                                                        width: Get.width,
                                                        height: 75.h,
                                                        child: Center(
                                                            child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 12.w,
                                                          ),
                                                          child: Container(
                                                              width: Get.width,
                                                              height: 40.h,
                                                              child: homeController.getProductByIdData.value.data!.related![index1].photo !=
                                                                      null
                                                                  ? CachedNetworkImageShare(
                                                                      homeController
                                                                          .getProductByIdData
                                                                          .value
                                                                          .data!
                                                                          .related![
                                                                              index1]
                                                                          .photo,
                                                                      40.h,
                                                                      Get.width,
                                                                      1)
                                                                  : SizedBox()
//                                                              homeController
//                                                                         .getProductByIdData
//                                                                         .value
//                                                                         .data!
//                                                                         .related![
//                                                                             index1]
//                                                                         .cityRelated!
//                                                                         .id
//                                                                         .toString() ==
//                                                                     "1"
//                                                                 ? Padding(
//                                                                     padding: EdgeInsets.symmetric(
//                                                                         horizontal:
//                                                                             12.w),
//                                                                     child: Row(
//                                                                         mainAxisAlignment:
//                                                                             MainAxisAlignment.spaceEvenly,
//                                                                         children: [
//                                                                           CustomText(
//                                                                             homeController.getProductByIdData.value.data!.related![index1].code ??
//                                                                                 "X",
//                                                                             fontSize:
//                                                                                 8.sp,
//                                                                             fontWeight:
//                                                                                 FontWeight.w400,
//                                                                           ),
//                                                                           CustomText(
//                                                                             homeController.getProductByIdData.value.data!.related![index1].vehicleNumber ??
//                                                                                 "XXXXX",
//                                                                             fontSize:
//                                                                                 8.sp,
//                                                                             fontWeight:
//                                                                                 FontWeight.w400,
//                                                                           ),
//                                                                           Image
//                                                                               .network(
//                                                                             homeController.getProductByIdData.value.data!.related![index1].cityRelated!.logo!,
//                                                                             height:
//                                                                                 20.h,
//                                                                           ),
//                                                                           // CachedNetworkImageShare(
//                                                                           //     homeController
//                                                                           //         .getProductByIdData
//                                                                           //         .value
//                                                                           //         .data!
//                                                                           //         .city!
//                                                                           //         .logo,
//                                                                           //     80,
//                                                                           //     60,
//                                                                           //     1)
//                                                                         ]),
//                                                                   )
//                                                                 : homeController
//                                                                             .getProductByIdData
//                                                                             .value
//                                                                             .data!
//                                                                             .related![
//                                                                                 index1]
//                                                                             .cityRelated!
//                                                                             .id
//                                                                             .toString() ==
//                                                                         "2"
//                                                                     ? Padding(
//                                                                         padding:
//                                                                             EdgeInsets.symmetric(horizontal: 10.w),
//                                                                         child: Row(
//                                                                             children: [
//                                                                               Column(
//                                                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                                                 children: [
//                                                                                   Image.network(
//                                                                                     homeController.getProductByIdData.value.data!.related![index1].cityRelated!.logo!,
//                                                                                     height: 20.h,
//                                                                                   ),
//                                                                                   CustomText(
//                                                                                     homeController.getProductByIdData.value.data!.related![index1].code ?? "X",
//                                                                                     fontSize: 8.sp,
//                                                                                     fontWeight: FontWeight.w400,
//                                                                                   ),
//                                                                                 ],
//                                                                               ),
//                                                                               Spacer(),
//                                                                               CustomText(
//                                                                                 homeController.getProductByIdData.value.data!.related![index1].vehicleNumber ?? "XXXXX",
//                                                                                 fontSize: 8.sp,
//                                                                                 fontWeight: FontWeight.w400,
//                                                                               ),
//                                                                             ]),
//                                                                       )
//                                                                     : homeController.getProductByIdData.value.data!.related![index1].cityRelated!.id.toString() ==
//                                                                             "3"
//                                                                         ?
// //3
//                                                                         Padding(
//                                                                             padding:
//                                                                                 EdgeInsets.symmetric(horizontal: 20.w),
//                                                                             child:
//                                                                                 Row(children: [
//                                                                               CustomText(
//                                                                                 homeController.getProductByIdData.value.data!.related![index1].code ?? "X",
//                                                                                 fontSize: 8.sp,
//                                                                                 fontWeight: FontWeight.w400,
//                                                                               ),
//                                                                               Image.network(
//                                                                                 homeController.getProductByIdData.value.data!.related![index1].cityRelated!.logo!,
//                                                                                 height: 20.h,
//                                                                               ),
//                                                                               Spacer(),
//                                                                               CustomText(
//                                                                                 homeController.getProductByIdData.value.data!.related![index1].vehicleNumber ?? "XXXXX",
//                                                                                 fontSize: 8.sp,
//                                                                                 fontWeight: FontWeight.w400,
//                                                                               ),
//                                                                             ]),
//                                                                           )
//                                                                         : homeController.getProductByIdData.value.data!.related![index1].cityRelated!.id.toString() ==
//                                                                                 "4"
//                                                                             ?

//                                                                             //4
//                                                                             Row(children: [
//                                                                                 Container(
//                                                                                   width: 20.w,
//                                                                                   height: Get.height,
//                                                                                   decoration: BoxDecoration(
//                                                                                       borderRadius: BorderRadius.only(
//                                                                                         topLeft: SPHelper.spHelper.getLanguage() == "en" ? Radius.circular(8.r) : Radius.circular(0.r),
//                                                                                         bottomLeft: SPHelper.spHelper.getLanguage() == "en" ? Radius.circular(8.r) : Radius.circular(0.r),
//                                                                                         topRight: SPHelper.spHelper.getLanguage() == "ar" ? Radius.circular(8.r) : Radius.circular(0.r),
//                                                                                         bottomRight: SPHelper.spHelper.getLanguage() == "ar" ? Radius.circular(8.r) : Radius.circular(0.r),
//                                                                                       ),
//                                                                                       color: AppColors.primaryColor),
//                                                                                   child: Center(
//                                                                                     child: CustomText(
//                                                                                       homeController.getProductByIdData.value.data!.related![index1].code ?? "X",
//                                                                                       fontSize: 12.sp,
//                                                                                       color: AppColors.whiteColor,
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                                 Image.network(
//                                                                                   homeController.getProductByIdData.value.data!.related![index1].cityRelated!.logo!,
//                                                                                   height: 15.h,
//                                                                                 ),
//                                                                                 Spacer(),
//                                                                                 CustomText(
//                                                                                   homeController.getProductByIdData.value.data!.related![index1].vehicleNumber ?? "XXXXX",
//                                                                                   fontSize: 10.sp,
//                                                                                   fontWeight: FontWeight.w400,
//                                                                                 ),
//                                                                                 SizedBox(
//                                                                                   width: 10.w,
//                                                                                 ),
//                                                                               ])
//                                                                             : homeController.getProductByIdData.value.data!.related![index1].cityRelated!.id.toString() == "5"
//                                                                                 ? Padding(
//                                                                                     padding: EdgeInsets.symmetric(horizontal: 12.w),
//                                                                                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                                                                                       CustomText(
//                                                                                         homeController.getProductByIdData.value.data!.related![index1].code ?? "X",
//                                                                                         fontSize: 8.sp,
//                                                                                         fontWeight: FontWeight.w400,
//                                                                                         color: AppColors.black,
//                                                                                       ),
//                                                                                       Image.network(
//                                                                                         homeController.getProductByIdData.value.data!.related![index1].cityRelated!.logo!,
//                                                                                         height: 20.h,
//                                                                                       ),
//                                                                                       CustomText(
//                                                                                         homeController.getProductByIdData.value.data!.related![index1].vehicleNumber ?? "XXXXX",
//                                                                                         fontSize: 8.sp,
//                                                                                         fontWeight: FontWeight.w400,
//                                                                                       ),
//                                                                                     ]),
//                                                                                   )
//                                                                                 :
//                                                                                 //6
//                                                                                 Padding(
//                                                                                     padding: EdgeInsets.symmetric(horizontal: 12.w),
//                                                                                     child: Row(children: [
//                                                                                       CustomText(
//                                                                                         homeController.getProductByIdData.value.data!.related![index1].code ?? "X",
//                                                                                         fontSize: 8.sp,
//                                                                                         fontWeight: FontWeight.w400,
//                                                                                         color: AppColors.black,
//                                                                                       ),
//                                                                                       // SizedBox(
//                                                                                       //   width: 20.w,
//                                                                                       // ),
//                                                                                       Image.network(
//                                                                                         homeController.getProductByIdData.value.data!.related![index1].cityRelated!.logo!,
//                                                                                         height: 20.h,
//                                                                                       ),
//                                                                                       Spacer(),
//                                                                                       CustomText(
//                                                                                         homeController.getProductByIdData.value.data!.related![index1].vehicleNumber ?? "XXXXX",
//                                                                                         fontSize: 8.sp,
//                                                                                         fontWeight: FontWeight.w400,
//                                                                                       ),
//                                                                                     ]),
//                                                                                   ),

                                                              ),
                                                        )),
                                                      )
                                                    : homeController
                                                                .getProductByIdData
                                                                .value
                                                                .data!
                                                                .related![
                                                                    index1]
                                                                .categoryId
                                                                .toString() ==
                                                            "6"
                                                        ? Container(
                                                            width: Get.width,
                                                            height: 75.h,
                                                            child: Center(
                                                              child: homeController
                                                                          .getProductByIdData
                                                                          .value
                                                                          .data!
                                                                          .related![
                                                                              index1]
                                                                          .brandRelated ==
                                                                      null
                                                                  ? SizedBox()
                                                                  : Image.network(homeController
                                                                      .getProductByIdData
                                                                      .value
                                                                      .data!
                                                                      .related![
                                                                          index1]
                                                                      .brandRelated!
                                                                      .logo!),
                                                            ),
                                                          )
                                                        : Stack(
                                                            clipBehavior:
                                                                Clip.none,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              15.r),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              15.r),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              30.r),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              30.r),
                                                                    ),
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      height:
                                                                          77.h,
                                                                      width: Get
                                                                          .width,
                                                                      imageUrl: homeController
                                                                              .getProductByIdData
                                                                              .value
                                                                              .data!
                                                                              .related![index1]
                                                                              .photo ??
                                                                          "",
                                                                      placeholder: (context,
                                                                              url) =>
                                                                          const Center(
                                                                              child: CupertinoActivityIndicator(
                                                                        color: AppColors
                                                                            .primaryColor,
                                                                      )),
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          Center(
                                                                        child:
                                                                            CustomSvgImage(
                                                                          imageName:
                                                                              "logo",
                                                                        ),
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              // Positioned(
                                                              //   bottom: -15.h,
                                                              //   left: 33.w,
                                                              //   child: Row(
                                                              //     mainAxisAlignment:
                                                              //         MainAxisAlignment
                                                              //             .center,
                                                              //     children: [
                                                              //       Container(
                                                              //         decoration:
                                                              //             BoxDecoration(
                                                              //           color: AppColors
                                                              //               .whiteColor,
                                                              //           borderRadius:
                                                              //               BorderRadius
                                                              //                   .circular(
                                                              //                       11.r),
                                                              //           boxShadow: [
                                                              //             BoxShadow(
                                                              //               color: const Color(
                                                              //                   0x1aff0000),
                                                              //               offset:
                                                              //                   Offset(0, 4),
                                                              //               blurRadius: 6,
                                                              //             ),
                                                              //           ],
                                                              //         ),
                                                              //         child: Padding(
                                                              //           padding: EdgeInsets
                                                              //               .symmetric(
                                                              //             horizontal: 8.w,
                                                              //             vertical: 8.h,
                                                              //           ),
                                                              //           child: Row(
                                                              //             mainAxisAlignment:
                                                              //                 MainAxisAlignment
                                                              //                     .center,
                                                              //             children: [
                                                              //               CustomText(
                                                              //                 homeController
                                                              //                         .getProductByIdData
                                                              //                         .value
                                                              //                         .data!
                                                              //                         .related![
                                                              //                             index1]
                                                              //                         .address ??
                                                              //                     "",
                                                              //                 fontSize: 10.sp,
                                                              //                 fontWeight:
                                                              //                     FontWeight
                                                              //                         .w400,
                                                              //                 color: AppColors
                                                              //                     .primaryColor,
                                                              //               )
                                                              //             ],
                                                              //           ),
                                                              //         ),
                                                              //       ),
                                                              //     ],
                                                              //   ),
                                                              // ),
                                                              //
                                                            ],
                                                          ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            CustomText(
                                              homeController
                                                      .getProductByIdData
                                                      .value
                                                      .data!
                                                      .related![index1]
                                                      .name ??
                                                  "",
                                              fontSize: 10.sp,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            SizedBox(
                                              height: 7.h,
                                            ),
                                            homeController
                                                        .getProductByIdData
                                                        .value
                                                        .data!
                                                        .related![index1]
                                                        .categoryId
                                                        .toString() ==
                                                    "6"
                                                ? CustomText(
                                                    SPHelper.spHelper
                                                                .getLanguage() ==
                                                            "en"
                                                        ? homeController
                                                            .getProductByIdData
                                                            .value
                                                            .data!
                                                            .related![index1]
                                                            .cityRelated!
                                                            .nameEn!
                                                            .toString()
                                                        : homeController
                                                            .getProductByIdData
                                                            .value
                                                            .data!
                                                            .related![index1]
                                                            .cityRelated!
                                                            .name!
                                                            .toString(),
                                                    fontSize: 10.sp,
                                                    fontFamily: "tajawalb",
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors.primaryColor,
                                                  )
                                                : homeController
                                                                .getProductByIdData
                                                                .value
                                                                .data!
                                                                .related![
                                                                    index1]
                                                                .categoryId
                                                                .toString() ==
                                                            "5" ||
                                                        homeController
                                                                .getProductByIdData
                                                                .value
                                                                .data!
                                                                .related![
                                                                    index1]
                                                                .categoryId
                                                                .toString() ==
                                                            "7"
                                                    ? SizedBox()
                                                    : CustomText(
                                                        homeController
                                                                    .getProductByIdData
                                                                    .value
                                                                    .data!
                                                                    .related![
                                                                        index1]
                                                                    .typeProduct ==
                                                                "for_rent"
                                                            ? homeController
                                                                    .getProductByIdData
                                                                    .value
                                                                    .data!
                                                                    .related![
                                                                        index1]
                                                                    .priceDaily +
                                                                " / Daily".tr
                                                            : homeController
                                                                    .getProductByIdData
                                                                    .value
                                                                    .data!
                                                                    .related![
                                                                        index1]
                                                                    .price!
                                                                    .toString() +
                                                                " AED",
                                                        fontSize: 10.sp,
                                                        fontFamily: "tajawalb",
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                            SizedBox(
                                              height: 7.h,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w),
                                              child: Row(
                                                children: [
                                                  CustomText(
                                                    homeController
                                                        .getProductByIdData
                                                        .value
                                                        .data!
                                                        .related![index1]
                                                        .createdAt
                                                        .toString()
                                                        .substring(0, 10),
                                                    fontSize: 10.sp,
                                                    color: AppColors.grey,
                                                  ),
                                                  Spacer(),
                                                  CustomSvgImage(
                                                    imageName: "heart_car",
                                                    height: 9.h,
                                                    width: 12.w,
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 7.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 17.w,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ))
                ],
              ),
            );
    }));
  }
}
