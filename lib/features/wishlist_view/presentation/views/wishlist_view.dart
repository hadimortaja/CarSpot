import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/cached_network_image.dart';
import 'package:car_rental/features/car_ad_sale_view/presentation/views/car_ad_sale_view.dart';
import 'package:car_rental/features/wishlist_view/data/data_sources/add_to_wishlist_data_source.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../car_ad_sale_view/data/data_sources/get_product_by_id_data_source.dart';

class WishlistView extends StatelessWidget {
  ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 60.h,
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
                  child: Icon(Icons.arrow_back_ios)),
              CustomText(
                "Whishlist",
                fontSize: 22.sp,
                fontFamily: "tajawalb",
              ),
              Icon(
                Icons.arrow_back_ios,
                color: Colors.transparent,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 32.h,
        ),
        Obx(() {
          return profileController.getWishlistData.value.code == null
              ? Helper.loading()
              : profileController.getWishlistData.value.data!.data!.length == 0
                  ? Column(
                      children: [
                        CustomText(
                          "There is No Favorite Ads",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        )
                      ],
                    )
                  : Expanded(
                      child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: profileController
                          .getWishlistData.value.data!.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            getProductById(profileController.getWishlistData
                                .value.data!.data![index].product!.id
                                .toString());
                            Get.to(() => CarAdSaleView(
                                  id: profileController.getWishlistData.value
                                      .data!.data![index].product!.id
                                      .toString(),
                                ));
                          },
                          child: Column(
                            children: [
                              Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(15.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x40ff0000),
                                      offset: Offset(0, 1),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Column(children: [
                                  Stack(
                                    children: [
                                      if (profileController
                                              .getWishlistData
                                              .value
                                              .data!
                                              .data![index]
                                              .product !=
                                          null)
                                        profileController
                                                    .getWishlistData
                                                    .value
                                                    .data!
                                                    .data![index]
                                                    .product!
                                                    .categoryId ==
                                                3
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                                child: Container(
                                                  width: Get.width,
                                                  height: 272.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.r),
                                                      color:
                                                          AppColors.whiteColor),
                                                  child: Center(
                                                      child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.w),
                                                    child: Container(
                                                      width: 375.w,
                                                      height: 80.h,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.r),
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xff524188),
                                                              width: 3)),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    12.w),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              profileController
                                                                          .getWishlistData
                                                                          .value
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .product!
                                                                          .simType ==
                                                                      "1"
                                                                  ? CustomSvgImage(
                                                                      imageName:
                                                                          "etisalat-seeklogo.com",
                                                                      height:
                                                                          20.h,
                                                                    )
                                                                  : CustomSvgImage(
                                                                      imageName:
                                                                          "du-company-logo-1",
                                                                      height:
                                                                          40.h,
                                                                    ),
                                                              CustomText(
                                                                  profileController
                                                                      .getWishlistData
                                                                      .value
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .product!
                                                                      .phone!),
                                                              profileController
                                                                          .getWishlistData
                                                                          .value
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .product!
                                                                          .simType ==
                                                                      "1"
                                                                  ? CustomSvgImage(
                                                                      imageName:
                                                                          "etisalat-seeklogo.com",
                                                                      height:
                                                                          20.h,
                                                                      color: Colors
                                                                          .transparent,
                                                                    )
                                                                  : CustomSvgImage(
                                                                      imageName:
                                                                          "du-company-logo-1",
                                                                      height:
                                                                          40.h,
                                                                      color: Colors
                                                                          .transparent,
                                                                    ),
                                                            ]),
                                                      ),
                                                    ),
                                                  )),
                                                ),
                                              )
                                            : profileController
                                                        .getWishlistData
                                                        .value
                                                        .data!
                                                        .data![index]
                                                        .product!
                                                        .categoryId
                                                        .toString() ==
                                                    "4"
                                                ? Container(
                                                    width: Get.width,
                                                    height: 200.h,
                                                    child: Center(
                                                        child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 12.w,
                                                      ),
                                                      child: Container(
                                                        width: Get.width,
                                                        height: 80.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .black,
                                                                width: 2.w)),
                                                        child: profileController
                                                                    .getWishlistData
                                                                    .value
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .product!
                                                                    .city!
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
                                                                        profileController.getWishlistData.value.data!.data![index].product!.code ??
                                                                            "X",
                                                                        fontSize:
                                                                            27.sp,
                                                                      ),
                                                                      CustomText(
                                                                        profileController.getWishlistData.value.data!.data![index].product!.vehicleNumber ??
                                                                            "XXXXX",
                                                                        fontSize:
                                                                            27.sp,
                                                                      ),
                                                                      Image
                                                                          .network(
                                                                        profileController
                                                                            .getWishlistData
                                                                            .value
                                                                            .data!
                                                                            .data![index]
                                                                            .product!
                                                                            .city!
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
                                                            : profileController
                                                                        .getWishlistData
                                                                        .value
                                                                        .data!
                                                                        .data![
                                                                            index]
                                                                        .product!
                                                                        .city!
                                                                        .id
                                                                        .toString() ==
                                                                    "2"
                                                                ? Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            20.w),
                                                                    child: Row(
                                                                        children: [
                                                                          Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Image.network(
                                                                                profileController.getWishlistData.value.data!.data![index].product!.city!.logo!,
                                                                                height: 40.h,
                                                                              ),
                                                                              CustomText(
                                                                                profileController.getWishlistData.value.data!.data![index].product!.code ?? "X",
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                60.w,
                                                                          ),
                                                                          CustomText(profileController.getWishlistData.value.data!.data![index].product!.vehicleNumber ??
                                                                              "XXXXX"),
                                                                        ]),
                                                                  )
                                                                : profileController
                                                                            .getWishlistData
                                                                            .value
                                                                            .data!
                                                                            .data![
                                                                                index]
                                                                            .product!
                                                                            .city!
                                                                            .id
                                                                            .toString() ==
                                                                        "3"
                                                                    ?
                                                                    //3
                                                                    Padding(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 20.w),
                                                                        child: Row(
                                                                            children: [
                                                                              CustomText(
                                                                                profileController.getWishlistData.value.data!.data![index].product!.code ?? "X",
                                                                                fontSize: 33.sp,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 20.w,
                                                                              ),
                                                                              Image.network(
                                                                                profileController.getWishlistData.value.data!.data![index].product!.city!.logo!,
                                                                                height: 60.h,
                                                                              ),
                                                                              Spacer(),
                                                                              CustomText(
                                                                                profileController.getWishlistData.value.data!.data![index].product!.vehicleNumber ?? "XXXXX",
                                                                                fontSize: 33.sp,
                                                                              ),
                                                                            ]),
                                                                      )
                                                                    : profileController.getWishlistData.value.data!.data![index].product!.city!.id.toString() ==
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
                                                                                      profileController.getWishlistData.value.data!.data![index].product!.code ?? "X",
                                                                                      fontSize: 33.sp,
                                                                                      color: AppColors.whiteColor,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 20.w,
                                                                                ),
                                                                                Image.network(
                                                                                  profileController.getWishlistData.value.data!.data![index].product!.city!.logo!,
                                                                                  height: 60.h,
                                                                                ),
                                                                                Spacer(),
                                                                                CustomText(
                                                                                  profileController.getWishlistData.value.data!.data![index].product!.vehicleNumber ?? "XXXXX",
                                                                                  fontSize: 33.sp,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 20.w,
                                                                                ),
                                                                              ])
                                                                        : profileController.getWishlistData.value.data!.data![index].product!.city!.id.toString() ==
                                                                                "5"
                                                                            ? Padding(
                                                                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                                                                child: Row(children: [
                                                                                  CustomText(
                                                                                    profileController.getWishlistData.value.data!.data![index].product!.code ?? "X",
                                                                                    fontSize: 33.sp,
                                                                                    color: AppColors.black,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 20.w,
                                                                                  ),
                                                                                  Image.network(
                                                                                    profileController.getWishlistData.value.data!.data![index].product!.city!.logo!,
                                                                                    height: 60.h,
                                                                                  ),
                                                                                  Spacer(),
                                                                                  CustomText(
                                                                                    profileController.getWishlistData.value.data!.data![index].product!.vehicleNumber ?? "XXXXX",
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
                                                                                    profileController.getWishlistData.value.data!.data![index].product!.code ?? "X",
                                                                                    fontSize: 33.sp,
                                                                                    color: AppColors.black,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 20.w,
                                                                                  ),
                                                                                  Image.network(
                                                                                    profileController.getWishlistData.value.data!.data![index].product!.city!.logo!,
                                                                                    height: 60.h,
                                                                                  ),
                                                                                  Spacer(),
                                                                                  CustomText(
                                                                                    profileController.getWishlistData.value.data!.data![index].product!.vehicleNumber ?? "XXXXX",
                                                                                    fontSize: 33.sp,
                                                                                  ),
                                                                                ]),
                                                                              ),
                                                      ),
                                                    )),
                                                  )
                                                : profileController
                                                            .getWishlistData
                                                            .value
                                                            .data!
                                                            .data![index]
                                                            .product!
                                                            .categoryId ==
                                                        6
                                                    ? Container(
                                                        height: 272.h,
                                                        width: Get.width,
                                                        child: Center(
                                                          child: profileController
                                                                      .getWishlistData
                                                                      .value
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .product!
                                                                      .brand ==
                                                                  null
                                                              ? SizedBox()
                                                              : CachedNetworkImageShare(
                                                                  profileController
                                                                          .getWishlistData
                                                                          .value
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .product!
                                                                          .brand!
                                                                          .logo ??
                                                                      "",
                                                                  150.h,
                                                                  150,
                                                                  15,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                        ),
                                                      )
                                                    : CachedNetworkImageShare(
                                                        profileController
                                                                .getWishlistData
                                                                .value
                                                                .data!
                                                                .data![index]
                                                                .product!
                                                                .photo ??
                                                            "",
                                                        210.h,
                                                        Get.width,
                                                        15,
                                                        fit: BoxFit.cover,
                                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(12.r),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            // Container(
                                            //   height: 24.h,
                                            //   width: 24.w,
                                            //   decoration: BoxDecoration(
                                            //     shape: BoxShape.circle,
                                            //     color: AppColors.whiteColor,
                                            //   ),
                                            //   child: CachedNetworkImageShare(
                                            //     profileController.getProfileData
                                            //             .value.data!.photo ??
                                            //         "",
                                            //     24.h,
                                            //     24.w,
                                            //     0,
                                            //   ),
                                            // ),
                                            Spacer(),
                                            IconButton(
                                              onPressed: () {
                                                addToWishlistDataSource(
                                                    product_id:
                                                        profileController
                                                            .getWishlistData
                                                            .value
                                                            .data!
                                                            .data![index]
                                                            .product!
                                                            .id
                                                            .toString());
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                color: AppColors.primaryColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (profileController
                                                .getWishlistData
                                                .value
                                                .data!
                                                .data![index]
                                                .product !=
                                            null)
                                          profileController
                                                          .getWishlistData
                                                          .value
                                                          .data!
                                                          .data![index]
                                                          .product!
                                                          .categoryId ==
                                                      6 ||
                                                  profileController
                                                          .getWishlistData
                                                          .value
                                                          .data!
                                                          .data![index]
                                                          .product!
                                                          .categoryId ==
                                                      5 ||
                                                  profileController
                                                          .getWishlistData
                                                          .value
                                                          .data!
                                                          .data![index]
                                                          .product!
                                                          .categoryId ==
                                                      7
                                              ? SizedBox()
                                              : Row(
                                                  children: [
                                                    CustomSvgImage(
                                                      imageName: "price_icon",
                                                      height: 8.h,
                                                      width: 8.w,
                                                      color: AppColors.black,
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    profileController
                                                                .getWishlistData
                                                                .value
                                                                .data!
                                                                .data![index]
                                                                .product!
                                                                .categoryId ==
                                                            9
                                                        ? CustomText(
                                                            "${profileController.getWishlistData.value.data!.data![index].product!.priceDaily} / Daily",
                                                            fontSize: 17.sp,
                                                            color: AppColors
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )
                                                        : CustomText(
                                                            "${profileController.getWishlistData.value.data!.data![index].product!.price} AED",
                                                            fontSize: 17.sp,
                                                            color: AppColors
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                    Spacer(),
                                                    CustomSvgImage(
                                                      imageName: "time_icon",
                                                      height: 10.h,
                                                      width: 8.w,
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    CustomText(
                                                      profileController
                                                          .getWishlistData
                                                          .value
                                                          .data!
                                                          .data![index]
                                                          .product!
                                                          .createdAt
                                                          .toString()
                                                          .substring(0, 10),
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ],
                                                ),
                                        SizedBox(
                                          height: 7.h,
                                        ),
                                        if (profileController
                                                .getWishlistData
                                                .value
                                                .data!
                                                .data![index]
                                                .product !=
                                            null)
                                          profileController
                                                          .getWishlistData
                                                          .value
                                                          .data!
                                                          .data![index]
                                                          .product!
                                                          .categoryId ==
                                                      3 ||
                                                  profileController
                                                          .getWishlistData
                                                          .value
                                                          .data!
                                                          .data![index]
                                                          .product!
                                                          .categoryId ==
                                                      4
                                              ? SizedBox()
                                              : Row(
                                                  children: [
                                                    CustomSvgImage(
                                                      imageName: "title_icon",
                                                      height: 10.h,
                                                      color: AppColors.black,
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    profileController
                                                                .getWishlistData
                                                                .value
                                                                .data!
                                                                .data![index]
                                                                .product!
                                                                .categoryId ==
                                                            6
                                                        ? CustomText(
                                                            profileController
                                                                    .getWishlistData
                                                                    .value
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .product!
                                                                    .brand!
                                                                    .name ??
                                                                "",
                                                            fontSize: 17.sp,
                                                            color:
                                                                AppColors.black,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )
                                                        : CustomText(
                                                            profileController
                                                                    .getWishlistData
                                                                    .value
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .product!
                                                                    .name ??
                                                                "",
                                                            fontSize: 17.sp,
                                                            color:
                                                                AppColors.black,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                  ],
                                                ),
                                        if (profileController
                                                .getWishlistData
                                                .value
                                                .data!
                                                .data![index]
                                                .product !=
                                            null)
                                          profileController
                                                          .getWishlistData
                                                          .value
                                                          .data!
                                                          .data![index]
                                                          .product!
                                                          .categoryId ==
                                                      3 ||
                                                  profileController
                                                          .getWishlistData
                                                          .value
                                                          .data!
                                                          .data![index]
                                                          .product!
                                                          .categoryId ==
                                                      4
                                              ? SizedBox()
                                              : SizedBox(
                                                  height: 7.h,
                                                ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 5.h,
                                              width: 5.w,
                                              decoration: BoxDecoration(
                                                  color: AppColors.black,
                                                  shape: BoxShape.circle),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            if (profileController
                                                    .getWishlistData
                                                    .value
                                                    .data!
                                                    .data![index]
                                                    .product !=
                                                null)
                                              Container(
                                                constraints: BoxConstraints(
                                                    maxWidth: 300.w),
                                                child: CustomText(
                                                  profileController
                                                          .getWishlistData
                                                          .value
                                                          .data!
                                                          .data![index]
                                                          .product!
                                                          .description ??
                                                      "",
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.black,
                                                ),
                                              )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 7.h,
                                        ),
                                        // Row(
                                        //   children: [
                                        //     CustomSvgImage(
                                        //       imageName: "color_icon",
                                        //       height: 10.h,
                                        //       color: AppColors.black,
                                        //     ),
                                        //     SizedBox(
                                        //       width: 10.w,
                                        //     ),
                                        //     CustomText(
                                        //       profileController
                                        //           .getWishlistData
                                        //           .value
                                        //           .data!
                                        //           .data![index]
                                        //           .product!
                                        //           .colorId
                                        //           .toString(),
                                        //       fontSize: 12.sp,
                                        //       fontWeight: FontWeight.w400,
                                        //       color: AppColors.black,
                                        //     )
                                        //   ],
                                        // ),
                                        // SizedBox(
                                        //   height: 7.h,
                                        // ),
                                        if (profileController
                                                .getWishlistData
                                                .value
                                                .data!
                                                .data![index]
                                                .product !=
                                            null)
                                          profileController
                                                          .getWishlistData
                                                          .value
                                                          .data!
                                                          .data![index]
                                                          .product!
                                                          .categoryId ==
                                                      6 ||
                                                  profileController
                                                          .getWishlistData
                                                          .value
                                                          .data!
                                                          .data![index]
                                                          .product!
                                                          .categoryId ==
                                                      5 ||
                                                  profileController
                                                          .getWishlistData
                                                          .value
                                                          .data!
                                                          .data![index]
                                                          .product!
                                                          .categoryId ==
                                                      7
                                              ? SizedBox()
                                              : Row(
                                                  children: [
                                                    CustomSvgImage(
                                                      imageName: "badge_icon",
                                                      height: 7.h,
                                                      color: AppColors.black,
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    CustomText(
                                                      profileController
                                                          .getWishlistData
                                                          .value
                                                          .data!
                                                          .data![index]
                                                          .product!
                                                          .condition
                                                          .toString(),
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                      profileController
                                                              .getWishlistData
                                                              .value
                                                              .data!
                                                              .data![index]
                                                              .product!
                                                              .city!
                                                              .name ??
                                                          "",
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ],
                                                ),
                                        if (profileController
                                                .getWishlistData
                                                .value
                                                .data!
                                                .data![index]
                                                .product !=
                                            null)
                                          profileController
                                                      .getWishlistData
                                                      .value
                                                      .data!
                                                      .data![index]
                                                      .product!
                                                      .categoryId ==
                                                  6
                                              ? SizedBox()
                                              : SizedBox(
                                                  height: 15.h,
                                                ),
                                        Divider(),
                                        IntrinsicHeight(
                                            child: Padding(
                                          padding: EdgeInsets.only(top: 14.h),
                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  UrlLauncher.launchUrl(Uri(
                                                      scheme: "tel",
                                                      path: profileController
                                                          .getWishlistData
                                                          .value
                                                          .data!
                                                          .data![index]
                                                          .product!
                                                          .phone!));
                                                },
                                                child: CustomSvgImage(
                                                  imageName: "call",
                                                  height: 20.h,
                                                  width: 20.w,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                              VerticalDivider(),
                                              GestureDetector(
                                                onTap: () {
                                                  UrlLauncher.launch(
                                                      "https://wa.me/${profileController.getWishlistData.value.data!.data![index].product!.whatsapp!}");
                                                },
                                                child: CustomSvgImage(
                                                  imageName: "whatsapp",
                                                  height: 20.h,
                                                  width: 20.w,
                                                  color: AppColors.primaryColor,
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
                                height: 24.h,
                              )
                            ],
                          ),
                        );
                      },
                    ));
        })
      ]),
    );
  }
}
