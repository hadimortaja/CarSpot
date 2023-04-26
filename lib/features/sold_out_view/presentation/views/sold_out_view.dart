import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/cached_network_image.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SoldOutView extends StatelessWidget {
  HomeController homeController = Get.find();
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
                "Sold Out",
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
          return homeController.getSoldOutData.value.code == null
              ? Helper.loading()
              : homeController.getSoldOutData.value.data!.length == 0
                  ? Center(
                      child: CustomText(
                        "There is No Sold Out Data",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      shrinkWrap: true,
                      primary: false,
                      itemCount:
                          homeController.getSoldOutData.value.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(15.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x40ff0000),
                                    offset: Offset(0, 4),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(children: [
                                Stack(
                                  children: [
                                    homeController.getSoldOutData.value
                                                .data![index].categoryId ==
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
                                                          BorderRadius.circular(
                                                              15.r),
                                                      border: Border.all(
                                                          color:
                                                              Color(0xff524188),
                                                          width: 3)),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12.w),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          homeController
                                                                      .getSoldOutData
                                                                      .value
                                                                      .data![
                                                                          index]
                                                                      .simType ==
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
                                                          CustomText(
                                                              homeController
                                                                  .getSoldOutData
                                                                  .value
                                                                  .data![index]
                                                                  .phone!),
                                                          homeController
                                                                      .getSoldOutData
                                                                      .value
                                                                      .data![
                                                                          index]
                                                                      .simType ==
                                                                  "1"
                                                              ? CustomSvgImage(
                                                                  imageName:
                                                                      "etisalat-seeklogo.com",
                                                                  height: 20.h,
                                                                  color: Colors
                                                                      .transparent,
                                                                )
                                                              : CustomSvgImage(
                                                                  imageName:
                                                                      "du-company-logo-1",
                                                                  height: 40.h,
                                                                  color: Colors
                                                                      .transparent,
                                                                ),
                                                        ]),
                                                  ),
                                                ),
                                              )),
                                            ),
                                          )
                                        : homeController.getSoldOutData.value
                                                    .data![index].categoryId
                                                    .toString() ==
                                                "4"
                                            ? Container(
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
                                                      child: homeController
                                                                  .getSoldOutData
                                                                  .value
                                                                  .data![index]
                                                                  .photo !=
                                                              null
                                                          ? CachedNetworkImageShare(
                                                              homeController
                                                                  .getSoldOutData
                                                                  .value
                                                                  .data![index]
                                                                  .photo,
                                                              80.h,
                                                              Get.width,
                                                              1)
                                                          : SizedBox()
                                                      //  homeController.getSoldOutData.value.data![index].city!.id.toString() ==
                                                      //      "1"
                                                      //      ? Padding(
                                                      //    padding:
                                                      //    EdgeInsets.symmetric(horizontal: 12.w),
                                                      //    child:
                                                      //    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                      //      CustomText(
                                                      //        homeController.getSoldOutData.value.data![index].code ?? "X",
                                                      //        fontSize: 27.sp,
                                                      //        color: AppColors.grey,

                                                      //      ),
                                                      //      CustomText(
                                                      //        homeController.getSoldOutData.value.data![index].vehicleNumber ?? "XXXXX",
                                                      //        fontSize: 27.sp,
                                                      //        color: AppColors.grey,

                                                      //      ),
                                                      //      Image.network(
                                                      //        homeController.getSoldOutData.value.data![index].city!.logo!,
                                                      //        color: AppColors.grey,
                                                      //      ),
                                                      //      // CachedNetworkImageShare(
                                                      //      //     homeController
                                                      //      //         .getProductByIdData
                                                      //      //         .value
                                                      //      //         .data!
                                                      //      //         .city!
                                                      //      //         .logo,
                                                      //      //     80,
                                                      //      //     60,
                                                      //      //     1)
                                                      //    ]),
                                                      //  )
                                                      //      : homeController.getSoldOutData.value.data![index].city!.id.toString() ==
                                                      //      "2"
                                                      //      ? Padding(
                                                      //    padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                      //    child: Row(children: [
                                                      //      Column(
                                                      //        mainAxisAlignment: MainAxisAlignment.center,
                                                      //        children: [
                                                      //          Image.network(
                                                      //            homeController.getSoldOutData.value.data![index].city!.logo!,
                                                      //            height: 40.h,
                                                      //          ),
                                                      //          CustomText(
                                                      //            homeController.getSoldOutData.value.data![index].code! ?? "X",
                                                      //          ),
                                                      //        ],
                                                      //      ),
                                                      //      SizedBox(
                                                      //        width: 60.w,
                                                      //      ),
                                                      //      CustomText(homeController.getSoldOutData.value.data![index].vehicleNumber ?? "XXXXX"),
                                                      //    ]),
                                                      //  )
                                                      //      : homeController.getSoldOutData.value.data![index].city!.id.toString() == "3"
                                                      //      ?
                                                      //  //3
                                                      //  Padding(
                                                      //    padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                      //    child: Row(children: [
                                                      //      CustomText(
                                                      //        homeController.getSoldOutData.value.data![index].code ?? "X",
                                                      //        fontSize: 33.sp,
                                                      //      ),
                                                      //      SizedBox(
                                                      //        width: 20.w,
                                                      //      ),
                                                      //      Image.network(
                                                      //        homeController.getSoldOutData.value.data![index].city!.logo!,
                                                      //        height: 60.h,
                                                      //      ),
                                                      //      Spacer(),
                                                      //      CustomText(
                                                      //        homeController.getSoldOutData.value.data![index].vehicleNumber ?? "XXXXX",
                                                      //        fontSize: 33.sp,
                                                      //      ),
                                                      //    ]),
                                                      //  )
                                                      //      : homeController.getSoldOutData.value.data![index].city!.id.toString() == "4"
                                                      //      ?

                                                      //  //4
                                                      //  Row(children: [
                                                      //    Container(
                                                      //      width: 60.w,
                                                      //      height: Get.height,
                                                      //      decoration: BoxDecoration(
                                                      //          borderRadius: BorderRadius.only(
                                                      //            topLeft: Radius.circular(5.r),
                                                      //            bottomLeft: Radius.circular(5.r),
                                                      //          ),
                                                      //          color: AppColors.primaryColor),
                                                      //      child: Center(
                                                      //        child: CustomText(
                                                      //          homeController.getSoldOutData.value.data![index].code ?? "X",
                                                      //          fontSize: 33.sp,
                                                      //          color: AppColors.whiteColor,
                                                      //        ),
                                                      //      ),
                                                      //    ),
                                                      //    SizedBox(
                                                      //      width: 20.w,
                                                      //    ),
                                                      //    Image.network(
                                                      //      homeController.getSoldOutData.value.data![index].city!.logo!,
                                                      //      height: 60.h,
                                                      //    ),
                                                      //    Spacer(),
                                                      //    CustomText(
                                                      //      homeController.getSoldOutData.value.data![index].vehicleNumber ?? "XXXXX",
                                                      //      fontSize: 33.sp,
                                                      //    ),
                                                      //    SizedBox(
                                                      //      width: 20.w,
                                                      //    ),
                                                      //  ])
                                                      //      :homeController.getSoldOutData.value.data![index].city!.id.toString() == "5"
                                                      //      ? Padding(
                                                      //    padding: EdgeInsets.symmetric(horizontal: 12.w),
                                                      //    child: Row(children: [
                                                      //      CustomText(
                                                      //        homeController.getSoldOutData.value.data![index].code ?? "X",
                                                      //        fontSize: 33.sp,
                                                      //        color: AppColors.black,
                                                      //      ),
                                                      //      SizedBox(
                                                      //        width: 20.w,
                                                      //      ),
                                                      //      Image.network(
                                                      //        homeController.getSoldOutData.value.data![index].city!.logo!,
                                                      //        height: 60.h,
                                                      //      ),
                                                      //      Spacer(),
                                                      //      CustomText(
                                                      //        homeController.getSoldOutData.value.data![index].vehicleNumber ?? "XXXXX",
                                                      //        fontSize: 33.sp,
                                                      //      ),
                                                      //    ]),
                                                      //  )
                                                      //      :
                                                      //  //6
                                                      //  Padding(
                                                      //    padding: EdgeInsets.symmetric(horizontal: 12.w),
                                                      //    child: Row(children: [
                                                      //      CustomText(
                                                      //        homeController.getSoldOutData.value.data![index].code?? "X",
                                                      //        fontSize: 33.sp,
                                                      //        color: AppColors.black,
                                                      //      ),
                                                      //      SizedBox(
                                                      //        width: 20.w,
                                                      //      ),
                                                      //      Image.network(
                                                      //        homeController.getSoldOutData.value.data![index].city!.logo!,
                                                      //        height: 60.h,
                                                      //      ),
                                                      //      Spacer(),
                                                      //      CustomText(
                                                      //        homeController.getSoldOutData.value.data![index].vehicleNumber ?? "XXXXX",
                                                      //        fontSize: 33.sp,
                                                      //      ),
                                                      //    ]),
                                                      //  ),

                                                      ),
                                                )),
                                              )
                                            : homeController
                                                        .getSoldOutData
                                                        .value
                                                        .data![index]
                                                        .categoryId ==
                                                    6
                                                ? Container(
                                                    height: 272.h,
                                                    width: Get.width,
                                                    child: Center(
                                                      child: homeController
                                                                  .getSoldOutData
                                                                  .value
                                                                  .data![index]
                                                                  .brand ==
                                                              null
                                                          ? SizedBox()
                                                          : CachedNetworkImageShare(
                                                              homeController
                                                                      .getSoldOutData
                                                                      .value
                                                                      .data![
                                                                          index]
                                                                      .brand!
                                                                      .logo ??
                                                                  "",
                                                              150.h,
                                                              150,
                                                              15,
                                                              fit: BoxFit.cover,
                                                            ),
                                                    ),
                                                  )
                                                : CachedNetworkImageShare(
                                                    homeController
                                                            .getSoldOutData
                                                            .value
                                                            .data![index]
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
                                        children: [
                                          Container(
                                            height: 24.h,
                                            width: 24.w,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.whiteColor,
                                            ),
                                            child: CachedNetworkImageShare(
                                              homeController
                                                      .getSoldOutData
                                                      .value
                                                      .data![index]
                                                      .user!
                                                      .photo ??
                                                  "",
                                              24.h,
                                              24.w,
                                              0,
                                            ),
                                          ),
                                          // Spacer(),
                                          // CustomSvgImage(
                                          //   imageName: "heart_car",
                                          //   height: 12.h,
                                          //   width: 11.w,
                                          // )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: Get.width,
                                      height: 210.h,
                                      child: Center(
                                        child: CustomSvgImage(
                                          imageName: "sold_out",
                                          height: 153.h,
                                          width: 276.w,
                                        ),
                                      ),
                                    )
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
                                      if (homeController.getSoldOutData.value
                                                  .data![index].categoryId
                                                  .toString() ==
                                              "1" ||
                                          homeController.getSoldOutData.value
                                                  .data![index].categoryId
                                                  .toString() ==
                                              "2" ||
                                          homeController.getSoldOutData.value
                                                  .data![index].categoryId
                                                  .toString() ==
                                              "3" ||
                                          homeController.getSoldOutData.value
                                                  .data![index].categoryId
                                                  .toString() ==
                                              "4")
                                        Row(
                                          children: [
                                            CustomSvgImage(
                                              imageName: "price_icon",
                                              height: 8.h,
                                              width: 8.w,
                                              color: AppColors.grey,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            CustomText(
                                              "${homeController.getSoldOutData.value.data![index].price} AED",
                                              fontSize: 17.sp,
                                              color: AppColors.grey,
                                            ),
                                            Spacer(),
                                            CustomSvgImage(
                                              imageName: "time_icon",
                                              height: 10.h,
                                              width: 8.w,
                                              color: AppColors.grey,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            CustomText(
                                              homeController.getSoldOutData
                                                  .value.data![index].createdAt
                                                  .toString()
                                                  .substring(0, 10),
                                              fontSize: 10.sp,
                                              color: AppColors.grey,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ],
                                        ),
                                      if (homeController.getSoldOutData.value
                                                  .data![index].categoryId
                                                  .toString() ==
                                              "1" ||
                                          homeController.getSoldOutData.value
                                                  .data![index].categoryId
                                                  .toString() ==
                                              "2")
                                        SizedBox(
                                          height: 7.h,
                                        ),
                                      if (homeController.getSoldOutData.value
                                                  .data![index].categoryId
                                                  .toString() ==
                                              "1" ||
                                          homeController.getSoldOutData.value
                                                  .data![index].categoryId
                                                  .toString() ==
                                              "2" ||
                                          homeController.getSoldOutData.value
                                                  .data![index].categoryId
                                                  .toString() ==
                                              "9")
                                        Row(
                                          children: [
                                            CustomSvgImage(
                                              imageName: "title_icon",
                                              height: 10.h,
                                              color: AppColors.grey,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            homeController.getSoldOutData.value
                                                        .data![index].categoryId
                                                        .toString() ==
                                                    "6"
                                                ? CustomText(
                                                    homeController
                                                            .getSoldOutData
                                                            .value
                                                            .data![index]
                                                            .brand!
                                                            .name ??
                                                        "",
                                                    fontSize: 17.sp,
                                                    color: AppColors.grey,
                                                  )
                                                : CustomText(
                                                    homeController
                                                            .getSoldOutData
                                                            .value
                                                            .data![index]
                                                            .name ??
                                                        "",
                                                    fontSize: 17.sp,
                                                    color: AppColors.grey,
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
                                                color: AppColors.grey,
                                                shape: BoxShape.circle),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Container(
                                            constraints:
                                                BoxConstraints(maxWidth: 300.w),
                                            child: CustomText(
                                              homeController
                                                      .getSoldOutData
                                                      .value
                                                      .data![index]
                                                      .description ??
                                                  "",
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 7.h,
                                      ),
                                      if (homeController.getSoldOutData.value
                                                  .data![index].categoryId
                                                  .toString() ==
                                              "1" ||
                                          homeController.getSoldOutData.value
                                                  .data![index].categoryId
                                                  .toString() ==
                                              "2" ||
                                          homeController.getSoldOutData.value
                                                  .data![index].categoryId
                                                  .toString() ==
                                              "9")
                                        Row(
                                          children: [
                                            CustomSvgImage(
                                              imageName: "color_icon",
                                              height: 10.h,
                                              color: AppColors.grey,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            if (homeController.getSoldOutData
                                                    .value.data![index].color !=
                                                null)
                                              CustomText(
                                                homeController
                                                        .getSoldOutData
                                                        .value
                                                        .data![index]
                                                        .color!
                                                        .name! ??
                                                    "",
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.grey,
                                              )
                                          ],
                                        ),
                                      SizedBox(
                                        height: 7.h,
                                      ),
                                      Row(
                                        children: [
                                          CustomSvgImage(
                                            imageName: "badge_icon",
                                            height: 7.h,
                                            color: AppColors.grey,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          CustomText(
                                            homeController.getSoldOutData.value
                                                    .data![index].condition ??
                                                "",
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.grey,
                                          ),
                                          Spacer(),
                                          CustomSvgImage(
                                            imageName: "location_icon",
                                            height: 10.h,
                                            color: AppColors.grey,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          if (homeController.getSoldOutData
                                                  .value.data![index].city !=
                                              null)
                                            CustomText(
                                              SPHelper.spHelper.getLanguage() ==
                                                      "en"
                                                  ? homeController
                                                      .getSoldOutData
                                                      .value
                                                      .data![index]
                                                      .city!
                                                      .nameEn
                                                  : homeController
                                                      .getSoldOutData
                                                      .value
                                                      .data![index]
                                                      .city!
                                                      .name,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.grey,
                                            ),
                                        ],
                                      ),
                                      SizedBox(
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
                                            CustomSvgImage(
                                              imageName: "call",
                                              height: 20.h,
                                              width: 20.w,
                                            ),
                                            VerticalDivider(),
                                            CustomSvgImage(
                                              imageName: "whatsapp",
                                              height: 20.h,
                                              width: 20.w,
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
                        );
                      },
                    ));
        })
      ]),
    );
  }
}
