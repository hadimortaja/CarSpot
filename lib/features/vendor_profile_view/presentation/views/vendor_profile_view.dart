import 'dart:developer';

import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/cached_network_image.dart';
import 'package:car_rental/features/car_ad_sale_view/data/data_sources/get_product_by_id_data_source.dart';
import 'package:car_rental/features/car_ad_sale_view/presentation/views/car_ad_sale_view.dart';
import 'package:car_rental/features/get_working_time_view/presentation/views/get_working_time_view.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../my_ads_view/data/data_sources/my_ads_data_source.dart';

class VendorProfileView extends StatelessWidget {
  ProfileController profileController = Get.find();
  UploadAdsController uploadAdsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return profileController.getVendorProfileByIdData.value.code == null
            ? Helper.loading()
            : Column(children: [
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back_ios)),
                      if (profileController.getVendorProfileByIdData.value.data!
                              .user!.photo !=
                          null)
                        CachedNetworkImageShare(
                            profileController.getVendorProfileByIdData.value
                                    .data!.user!.photo! ??
                                "",
                            111,
                            111,
                            0),
                      IconButton(
                          onPressed: () {
                            Get.to(() => GetWorkingTimeView());
                          },
                          icon: Icon(
                            Icons.timelapse_outlined,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                if (profileController
                        .getVendorProfileByIdData.value.data!.user!.name !=
                    null)
                  CustomText(
                    profileController
                        .getVendorProfileByIdData.value.data!.user!.name!,
                    fontSize: 16.sp,
                  ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 290.w),
                  child: CustomText(
                    profileController.getVendorProfileByIdData.value.data!.user!
                            .description ??
                        "",
                    fontSize: 12.sp,
                    color: AppColors.grey,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 34.h,
                ),
                SizedBox(
                  width: 237.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          CustomText(
                            profileController
                                .getVendorProfileByIdData.value.data!.normal
                                .toString(),
                            // uploadAdsController.allAdsList,
                            fontSize: 14.sp,
                          ),
                          CustomText(
                            "Normal Ads",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CustomText(
                            profileController
                                .getVendorProfileByIdData.value.data!.premium
                                .toString(),
                            fontSize: 14.sp,
                          ),
                          CustomText(
                            "Premium Ads",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CustomText(
                            profileController
                                .getVendorProfileByIdData.value.data!.turbo
                                .toString(),
                            fontSize: 14.sp,
                          ),
                          CustomText(
                            "Turbo Ads",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 34.h,
                ),
                Container(
                  width: Get.width,
                  height: 1.h,
                  color: AppColors.grey.withOpacity(0.23),
                ),
                SizedBox(
                  height: 34.h,
                ),
                Obx(() {
                  return profileController
                              .getVendorProfileByIdData.value.code ==
                          null
                      ? Helper.loading()
                      : profileController.allProfileList.length == 0
                          ? CustomText(
                              "There is No Ads",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            )
                          : Expanded(
                              child: SizedBox(
                                width: Get.width,
                                child: ListView.builder(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount:
                                      profileController.allProfileList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        getProductById(profileController
                                            .allProfileList[index].id
                                            .toString());
                                        Get.to(() => CarAdSaleView());
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      const Color(0x40ff0000),
                                                  offset: Offset(0, 1),
                                                  blurRadius: 5,
                                                ),
                                              ],
                                            ),
                                            child: Column(children: [
                                              Stack(
                                                children: [
                                                  profileController
                                                              .allProfileList[
                                                                  index]
                                                              .categoryId
                                                              .toString() ==
                                                          "6"
                                                      ? Container(
                                                          height: 272.h,
                                                          width: Get.width,
                                                          child: Center(
                                                              child: homeController
                                                                          .allProductsList[
                                                                              index]
                                                                          .brand ==
                                                                      null
                                                                  ? SizedBox()
                                                                  : CachedNetworkImageShare(
                                                                      homeController
                                                                              .allProductsList[index]
                                                                              .brand!
                                                                              .logo ??
                                                                          "",
                                                                      150.h,
                                                                      150,
                                                                      15,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )))
                                                      : CachedNetworkImageShare(
                                                          profileController
                                                                  .allProfileList[
                                                                      index]
                                                                  .photo ??
                                                              "",
                                                          210.h,
                                                          Get.width,
                                                          15,
                                                          fit: BoxFit.cover,
                                                        ),
                                                  // Padding(
                                                  //   padding: EdgeInsets.all(
                                                  //       12.r),
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
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    profileController
                                                                    .allProfileList[
                                                                        index]
                                                                    .categoryId
                                                                    .toString() ==
                                                                "6" ||
                                                            profileController
                                                                    .allProfileList[
                                                                        index]
                                                                    .categoryId
                                                                    .toString() ==
                                                                "5" ||
                                                            profileController
                                                                    .allProfileList[
                                                                        index]
                                                                    .categoryId
                                                                    .toString() ==
                                                                "7"
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
                                                                profileController
                                                                            .allProfileList[index]
                                                                            .categoryId
                                                                            .toString() ==
                                                                        "9"
                                                                    ? "${profileController.allProfileList[index].priceDaily} AED /Daily"
                                                                    : "${profileController.allProfileList[index].price} AED",
                                                                fontSize: 17.sp,
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
                                                              ),
                                                              SizedBox(
                                                                width: 10.w,
                                                              ),
                                                              CustomText(
                                                                profileController
                                                                    .allProfileList[
                                                                        index]
                                                                    .createdAt
                                                                    .toString()
                                                                    .substring(
                                                                        0, 10),
                                                                fontSize: 10.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ],
                                                          ),
                                                    SizedBox(
                                                      height: 7.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        CustomSvgImage(
                                                          imageName:
                                                              "title_icon",
                                                          height: 10.h,
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        CustomText(
                                                          profileController
                                                                      .allProfileList[
                                                                          index]
                                                                      .categoryId
                                                                      .toString() ==
                                                                  "6"
                                                              ? profileController
                                                                  .allProfileList[
                                                                      index]
                                                                  .brand!
                                                                  .name
                                                              : profileController
                                                                  .allProfileList[
                                                                      index]
                                                                  .name,
                                                          fontSize: 14.sp,
                                                          color:
                                                              AppColors.black,
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
                                                          decoration:
                                                              BoxDecoration(
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
                                                            profileController
                                                                    .allProfileList[
                                                                        index]
                                                                    .description ??
                                                                "",
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                AppColors.grey,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 7.h,
                                                    ),
                                                    if (profileController
                                                            .allProfileList[
                                                                index]
                                                            .categoryId
                                                            .toString() !=
                                                        "6")
                                                      profileController
                                                                      .allProfileList[
                                                                          index]
                                                                      .categoryId
                                                                      .toString() ==
                                                                  "5" ||
                                                              profileController
                                                                      .allProfileList[
                                                                          index]
                                                                      .categoryId
                                                                      .toString() ==
                                                                  "7"
                                                          ? SizedBox()
                                                          : Row(
                                                              children: [
                                                                CustomSvgImage(
                                                                  imageName:
                                                                      "color_icon",
                                                                  height: 10.h,
                                                                  color:
                                                                      AppColors
                                                                          .black,
                                                                ),
                                                                SizedBox(
                                                                  width: 10.w,
                                                                ),
                                                                if (profileController
                                                                        .allProfileList[
                                                                            index]
                                                                        .color !=
                                                                    null)
                                                                  CustomText(
                                                                    SPHelper.spHelper.getLanguage() ==
                                                                            "en"
                                                                        ? profileController
                                                                            .allProfileList[
                                                                                index]
                                                                            .color!
                                                                            .nameEn
                                                                        : profileController
                                                                            .allProfileList[index]
                                                                            .color!
                                                                            .name,
                                                                    fontSize:
                                                                        12.sp,
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
                                                    if (profileController
                                                            .allProfileList[
                                                                index]
                                                            .categoryId
                                                            .toString() !=
                                                        "6")
                                                      profileController
                                                                      .allProfileList[
                                                                          index]
                                                                      .categoryId
                                                                      .toString() ==
                                                                  "5" ||
                                                              profileController
                                                                      .allProfileList[
                                                                          index]
                                                                      .categoryId
                                                                      .toString() ==
                                                                  "7"
                                                          ? SizedBox()
                                                          : Row(
                                                              children: [
                                                                CustomSvgImage(
                                                                  imageName:
                                                                      "badge_icon",
                                                                  height: 7.h,
                                                                  color:
                                                                      AppColors
                                                                          .black,
                                                                ),
                                                                SizedBox(
                                                                  width: 10.w,
                                                                ),
                                                                CustomText(
                                                                  profileController
                                                                      .allProfileList[
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
                                                                  height: 10.h,
                                                                ),
                                                                SizedBox(
                                                                  width: 10.w,
                                                                ),
                                                                CustomText(
                                                                  SPHelper.spHelper
                                                                              .getLanguage() ==
                                                                          "en"
                                                                      ? profileController
                                                                          .allProfileList[
                                                                              index]
                                                                          .city!
                                                                          .nameEn
                                                                      : profileController
                                                                              .allProfileList[index]
                                                                              .city!
                                                                              .name ??
                                                                          "",
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ],
                                                            ),
                                                    if (profileController
                                                            .allProfileList[
                                                                index]
                                                            .categoryId
                                                            .toString() !=
                                                        "6")
                                                      profileController
                                                                      .allProfileList[
                                                                          index]
                                                                      .categoryId
                                                                      .toString() ==
                                                                  "5" ||
                                                              profileController
                                                                      .allProfileList[
                                                                          index]
                                                                      .categoryId
                                                                      .toString() ==
                                                                  "7"
                                                          ? SizedBox()
                                                          : SizedBox(
                                                              height: 15.h,
                                                            ),
                                                    Divider(),
                                                    IntrinsicHeight(
                                                        child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 14.h),
                                                      child: new Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          CustomSvgImage(
                                                            imageName: "call",
                                                            height: 20.h,
                                                            width: 20.w,
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
                                                          VerticalDivider(),
                                                          CustomSvgImage(
                                                            imageName:
                                                                "whatsapp",
                                                            height: 20.h,
                                                            width: 20.w,
                                                            color: AppColors
                                                                .primaryColor,
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
                                            height: 24.h,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                })
              ]);
      }),
    );
  }
}
