import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental/core/backend/apis.dart';
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
import 'package:car_rental/features/cars_view/presentation/views/car_view.dart';
import 'package:car_rental/features/choose_country_view/data/data_souces/cities_data_source.dart';
import 'package:car_rental/features/choose_country_view/data/model/cities_model.dart';
import 'package:car_rental/features/home_view/data/data_sources/home_banners_data_source.dart';
import 'package:car_rental/features/home_view/data/data_sources/home_categories_data_source.dart';
import 'package:car_rental/features/home_view/data/data_sources/most_popular_data_source.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_profile_data_source.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_vendor_profile_data_source.dart';
import 'package:car_rental/features/search_view/data/data_sources/search_data_source.dart';
import 'package:car_rental/features/search_view/data/models/search_model.dart';
import 'package:car_rental/features/search_view/presentation/views/search_view.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/data_sources/categories_ads_data_source.dart';
import 'package:car_rental/features/wishlist_view/data/data_sources/add_to_wishlist_data_source.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    getProfileDataSource();
    super.initState();
  }

  HomeController homeController = Get.find();
  UploadAdsController uploadAdsController = Get.find();

  // bool isFavorite = false;
  int slectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          homeMostPopularDataSource();
          homeBannersDataSource();
          homeCategoriesDataSource();
        },
        child: SingleChildScrollView(
            child: SafeArea(
          child: Column(
            children: [
              Obx(() {
                return homeController.getHomeBanners.value.status == null
                    ? SizedBox()
                    : homeController.getHomeBanners.value.banners!.length == 0
                        ? Center(
                            child: CustomText(
                              "There is No Banners",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : CarouselSlider.builder(
                            itemCount: homeController
                                .getHomeBanners.value.banners!.length,
                            itemBuilder: (BuildContext context, int itemIndex,
                                    int pageViewIndex) =>
                                GestureDetector(
                              onTap: () {
                                launchUrl(
                                    Uri.parse(homeController.getHomeBanners
                                        .value.banners![itemIndex].link
                                        .toString()),
                                    mode: LaunchMode
                                        .externalNonBrowserApplication);
                              },
                              child: CachedNetworkImageShare(
                                homeController.getHomeBanners.value
                                    .banners![itemIndex].photo,
                                165.h,
                                Get.width,
                                1,
                                fit: BoxFit.cover,
                              ),
                            ),
                            options: CarouselOptions(
                                onPageChanged: (index, reason) {},
                                viewportFraction: 1,
                                autoPlay: true,
                                initialPage: 0,
                                height: 165.h,
                                disableCenter: true,
                                enlargeCenterPage: true),
                          );
              }),
              SizedBox(
                height: 20.h,
              ),
              Obx(() {
                return authController.getCitiesData.value.code == null
                    ? SizedBox()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            GestureDetector(
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

                                                  homeMostPopularDataSource(
                                                    city: authController
                                                        .getCitiesSelect
                                                        .value
                                                        .id
                                                        .toString(),
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                                homeMostPopularDataSource(
                                                  city: "",
                                                );
                                                homeController.setIndexCity(-1);
                                              },
                                              child: CustomText(
                                                "All",
                                                fontSize: 12.w,
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        SizedBox(
                                          width: Get.width,
                                          height: 250.h,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            primary: false,
                                            itemCount: authController
                                                .getCitiesData
                                                .value
                                                .data!
                                                .length,
                                            itemBuilder: (context, index) {
                                              return Obx(() => GestureDetector(
                                                    onTap: () {
                                                      homeController
                                                          .setIndexCity(index);
                                                      authController
                                                          .setIndexCity(index);
                                                      authController
                                                              .getCitiesSelect
                                                              .value =
                                                          authController
                                                              .getCitiesData
                                                              .value
                                                              .data![index];
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
                                                                  color: homeController
                                                                              .indexCity
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
                                                                SPHelper.spHelper
                                                                            .getLanguage() ==
                                                                        "en"
                                                                    ? authController
                                                                        .getCitiesData
                                                                        .value
                                                                        .data![
                                                                            index]
                                                                        .nameEn
                                                                    : authController
                                                                        .getCitiesData
                                                                        .value
                                                                        .data![
                                                                            index]
                                                                        .name,
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: homeController
                                                                            .indexCity
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
                              child: Container(
                                height: 37.h,
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.23),
                                      offset: Offset(0, 2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Icon(
                                        Icons.location_on,
                                        color: AppColors.grey,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Obx(
                                        () => authController
                                                    .getCitiesData.value.code ==
                                                null
                                            ? CupertinoActivityIndicator()
                                            : CustomText(
                                                homeController.indexCity == -1
                                                    ? "All"
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
                                                fontSize: 12.sp,
                                                color: AppColors.red,
                                                fontWeight: FontWeight.w400,
                                                // fontFamily: "montserrat",
                                              ),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: AppColors.grey,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  homeController.getSearchData.value =
                                      SearchModel();
                                  // searchDataSource("", 1, true);
                                  Get.to(() => SearchView());
                                },
                                child: Container(
                                  width: Get.width,
                                  height: 37.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(10.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.23),
                                        offset: Offset(0, 2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(children: [
                                          Icon(
                                            Icons.search,
                                            color: AppColors.grey,
                                          ),
                                          CustomText(
                                            "Search By Cars, Numbers etc...",
                                            fontSize: 12.sp,
                                            color: AppColors.grey,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              }),
              SizedBox(
                height: 20.h,
              ),
              Obx(() {
                return homeController.getCategoriesData.value.status == null
                    ? Center(child: SizedBox())
                    : homeController
                                .getCategoriesData.value.categories!.length ==
                            0
                        ? CustomText(
                            "There is No Categories",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          )
                        : GridView.builder(
                            itemCount: homeController.getCategoriesData.value
                                    .categories!.length +
                                1,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            primary: false,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 0,
                              childAspectRatio: Helper.childAspectRatio(2),
                            ),
                            itemBuilder: (context, index) {
                              log(index.toString());
                              if (index - 1 ==
                                  homeController.getCategoriesData.value
                                          .categories!.length -
                                      1) {
                                return Column(
                                  children: [
                                    Container(
                                      height: 61.h,
                                      width: 61.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff929DC2)
                                              .withOpacity(0.30)),
                                      child: Center(
                                          child: CustomText(
                                        "Soon",
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      )),
                                    ),
                                  ],
                                );
                              } else {
                                return GestureDetector(
                                    onTap: () {
                                      uploadAdsController.setIndexSort(1);
                                      if (homeController.getCategoriesData.value
                                              .categories![index].id
                                              .toString() ==
                                          "10") {
                                        authController.cleanFilter();
                                        authController.setIndexCity(-1);
                                        authController.getCitiesSelect.value =
                                            DataCity();
                                        // if (homeController.getCategoriesData.value
                                        //         .categories![index].id ==
                                        //     1) {
                                        getProductsByCategoryDataSource(
                                            1, true, "7");

                                        print(
                                            "sssssss ${homeController.getCategoriesData.value.categories![index].id.toString()}");
                                        Get.to(() => CarView("10"));
                                      } else {
                                        authController.cleanFilter();
                                        authController.setIndexCity(-1);
                                        authController.getCitiesSelect.value =
                                            DataCity();
                                        // if (homeController.getCategoriesData.value
                                        //         .categories![index].id ==
                                        //     1) {
                                        getProductsByCategoryDataSource(
                                            1,
                                            true,
                                            homeController.getCategoriesData
                                                .value.categories![index].id
                                                .toString());
                                        getVendorsByCategoryDataSource(
                                            1,
                                            true,
                                            homeController.getCategoriesData
                                                .value.categories![index].id
                                                .toString());
                                        print(
                                            "sssssss ${homeController.getCategoriesData.value.categories![index].id.toString()}");
                                        Get.to(() => CarView(homeController
                                            .getCategoriesData
                                            .value
                                            .categories![index]
                                            .id
                                            .toString()));
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 61.h,
                                          width: 61.w,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xff929DC2)
                                                  .withOpacity(0.30)),
                                          child: Center(
                                              child: CachedNetworkImageShare(
                                            homeController
                                                    .getCategoriesData
                                                    .value
                                                    .categories![index]
                                                    .photo ??
                                                "",
                                            50,
                                            50,
                                            0,
                                            fit: BoxFit.contain,
                                          )),
                                        ),
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                        CustomText(
                                          SPHelper.spHelper.getLanguage() ==
                                                  "en"
                                              ? homeController
                                                  .getCategoriesData
                                                  .value
                                                  .categories![index]
                                                  .nameEn
                                              : homeController
                                                  .getCategoriesData
                                                  .value
                                                  .categories![index]
                                                  .name,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          // fon
                                        )
                                      ],
                                    ));
                              }

                              //  Column(
                              //   children: [
                              //     DottedBorder(
                              //       dashPattern: [
                              //         5,
                              //       ],
                              //       child: Container(
                              //         height: 132.h,
                              //         width: 156.w,
                              //         child: Center(
                              //             child: Icon(
                              //           Icons.add,
                              //           size: 30.r,
                              //         )),
                              //       ),
                              //       color: AppColors.grey,
                              //       borderType: BorderType.RRect,
                              //       radius: Radius.circular(15.r),
                              //     ),
                              //     SizedBox(
                              //       height: index == 0 ? 4.h : 0,
                              //     ),
                              //     index == 0
                              //         ? Row(
                              //             children: [
                              //               SizedBox(
                              //                 width: 5.w,
                              //               ),
                              //               Container(
                              //                 width: 5.w,
                              //                 height: 5.h,
                              //                 decoration: BoxDecoration(
                              //                     shape: BoxShape.circle,
                              //                     color: AppColors.grey),
                              //               ),
                              //               SizedBox(
                              //                 width: 5.w,
                              //               ),
                              //               CustomText(
                              //                 "Profile ad picture",
                              //                 fontSize: 9.sp,
                              //                 fontWeight: FontWeight.w400,
                              //                 color: AppColors.grey,
                              //               )
                              //             ],
                              //           )
                              //         : SizedBox()
                              //   ],
                              // );
                            },
                          );
              }),
              SizedBox(
                height: 20.h,
              ),
              Obx(() {
                return homeController.getMostPopularData.value.status == null
                    ? Container(
                        width: Get.width,
                        height: Get.height / 2,
                        child: Center(
                          child: CupertinoActivityIndicator(
                            radius: 15,
                            animating: true,
                            color: AppColors.red,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: Get.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          // physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          primary: false,
                          itemCount: homeController
                              .getMostPopularData.value.mostPobuler!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SPHelper.spHelper.getLanguage() == "en"
                                        ? CustomText(
                                            "Most Popular",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          )
                                        : SizedBox(),
                                    CustomText(
                                      " ${SPHelper.spHelper.getLanguage() == "en" ? homeController.getMostPopularData.value.mostPobuler![index].nameEn : homeController.getMostPopularData.value.mostPobuler![index].name}",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    SPHelper.spHelper.getLanguage() == "ar"
                                        ? CustomText(
                                            "Most Popular",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          )
                                        : SizedBox(),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        if (homeController.getMostPopularData
                                                .value.mostPobuler![index].id
                                                .toString() ==
                                            "7") {
                                          getProductsByCategoryDataSource(
                                              1, true, "7");
                                          Get.to(() => CarView("7"));
                                        } else if (homeController
                                                .getMostPopularData
                                                .value
                                                .mostPobuler![index]
                                                .id
                                                .toString() ==
                                            "5") {
                                          getProductsByCategoryDataSource(
                                              1, true, "5");
                                          Get.to(() => CarView("7"));
                                        } else {
                                          getProductsByCategoryDataSource(
                                              1,
                                              true,
                                              homeController.getMostPopularData
                                                  .value.mostPobuler![index].id
                                                  .toString());
                                          Get.to(() => CarView(homeController
                                              .getMostPopularData
                                              .value
                                              .mostPobuler![index]
                                              .id
                                              .toString()));
                                        }
                                      },
                                      child: CustomText(
                                        "View All",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                homeController
                                            .getMostPopularData.value.status ==
                                        null
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primaryColor,
                                          backgroundColor: AppColors.whiteColor,
                                        ),
                                      )
                                    : homeController
                                                .getMostPopularData
                                                .value
                                                .mostPobuler![index]
                                                .products!
                                                .length ==
                                            0
                                        ? Container(
                                            height: 160.h,
                                            child: Center(
                                              child: CustomText(
                                                "There Is No Products",
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )
                                        : SizedBox(
                                            height: 190.h,
                                            child: ListView.builder(
                                              itemCount: homeController
                                                  .getMostPopularData
                                                  .value
                                                  .mostPobuler![index]
                                                  .products!
                                                  .length,
                                              shrinkWrap: true,
                                              primary: false,
                                              physics: BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index1) {
                                                return Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        getProductById(
                                                            homeController
                                                                .getMostPopularData
                                                                .value
                                                                .mostPobuler![
                                                                    index]
                                                                .products![
                                                                    index1]
                                                                .id
                                                                .toString());

                                                        Get.to(
                                                            () => CarAdSaleView(
                                                                  id: homeController
                                                                      .getMostPopularData
                                                                      .value
                                                                      .mostPobuler![
                                                                          index]
                                                                      .products![
                                                                          index1]
                                                                      .id
                                                                      .toString(),
                                                                ));
                                                      },
                                                      child: Container(
                                                        width: 115.w,
                                                        height: 150.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.r),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: const Color(
                                                                  0x1aff0000),
                                                              offset:
                                                                  Offset(0, 3),
                                                              blurRadius: 1,
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Stack(
                                                              clipBehavior:
                                                                  Clip.none,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(15.r),
                                                                        topRight:
                                                                            Radius.circular(15.r),
                                                                        bottomLeft:
                                                                            Radius.circular(30.r),
                                                                        bottomRight:
                                                                            Radius.circular(30.r),
                                                                      ),
                                                                      child: homeController.getMostPopularData.value.mostPobuler![index].products![index1].categoryId.toString() ==
                                                                              "3"
                                                                          ? Container(
                                                                              width: Get.width,
                                                                              height: 77.h,
                                                                              child: Center(
                                                                                  child: Padding(
                                                                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                                                                child: Container(
                                                                                  height: 35.h,
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Color(0xff524188), width: 2)),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                      children: [
                                                                                        homeController.getMostPopularData.value.mostPobuler![index].products![index1].simType.toString() == "1"
                                                                                            ? CustomSvgImage(
                                                                                                imageName: "etisalat-seeklogo.com",
                                                                                                height: 10.h,
                                                                                              )
                                                                                            : CustomSvgImage(
                                                                                                imageName: "du-company-logo-1",
                                                                                                height: 10.h,
                                                                                              ),
                                                                                        CustomText(
                                                                                          homeController.getMostPopularData.value.mostPobuler![index].products![index1].phone,
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
                                                                          : homeController.getMostPopularData.value.mostPobuler![index].products![index1].categoryId.toString() == "4"
                                                                              ? Container(
                                                                                  width: Get.width,
                                                                                  height: 75.h,
                                                                                  child: Center(child: homeController.getMostPopularData.value.mostPobuler![index].products![index1].photo != null ? CachedNetworkImageShare(homeController.getMostPopularData.value.mostPobuler![index].products![index1].photo, 60.h, 100.w, 1) : SizedBox()),
                                                                                )
                                                                              : homeController.getMostPopularData.value.mostPobuler![index].products![index1].categoryId.toString() == "6"
                                                                                  ? Container(
                                                                                      width: Get.width,
                                                                                      height: 75.h,
                                                                                      child: Center(
                                                                                        child: homeController.getMostPopularData.value.mostPobuler![index].products![index1].brand == null ? SizedBox() : Image.network(homeController.getMostPopularData.value.mostPobuler![index].products![index1].brand!.logo!),
                                                                                      ),
                                                                                    )
                                                                                  : CachedNetworkImage(
                                                                                      height: 77.h,
                                                                                      width: Get.width,
                                                                                      imageUrl: homeController.getMostPopularData.value.mostPobuler![index].products![index1].photo ?? "",
                                                                                      placeholder: (context, url) => const Center(
                                                                                        child: CircularProgressIndicator(
                                                                                          color: AppColors.primaryColor,
                                                                                          backgroundColor: AppColors.whiteColor,
                                                                                        ),
                                                                                      ),
                                                                                      errorWidget: (context, url, error) => Center(
                                                                                        child: CustomSvgImage(
                                                                                          imageName: "logo",
                                                                                        ),
                                                                                      ),
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                // Positioned(
                                                                //   bottom: -15.h,
                                                                //   child: Row(
                                                                //     mainAxisAlignment:
                                                                //         MainAxisAlignment
                                                                //             .center,
                                                                //     children: [
                                                                //       Container(
                                                                //         width:
                                                                //             115.w,
                                                                //         decoration:
                                                                //             BoxDecoration(
                                                                //           color:
                                                                //               AppColors.whiteColor,
                                                                //           borderRadius:
                                                                //               BorderRadius.circular(11.r),
                                                                //           boxShadow: [
                                                                //             BoxShadow(
                                                                //               color: const Color(0x1aff0000),
                                                                //               offset: Offset(0, 4),
                                                                //               blurRadius: 6,
                                                                //             ),
                                                                //           ],
                                                                //         ),
                                                                //         child:
                                                                //             Row(
                                                                //           mainAxisAlignment:
                                                                //               MainAxisAlignment.center,
                                                                //           children: [

                                                                //           ],
                                                                //         ),
                                                                //       ),
                                                                //     ],
                                                                //   ),
                                                                // ),
//                                                                 Positioned(
//                                                                   top: 0.h,
//                                                                   right: -5.w,
//                                                                   child: IconButton(
//                                                                       onPressed: () {
// //                                                                         if(SPHelper.spHelper.getToken()==""){
// // BotToast.showText(text: "Please Make Login");
// //                                                                         }else{
// //                                                                           homeController
// //                                                                               .getMostPopularData
// //                                                                               .value
// //                                                                               .mostPobuler![
// //                                                                           index]
// //                                                                               .products![
// //                                                                           index1]
// //                                                                               .isFavorit=     homeController
// //                                                                               .getMostPopularData
// //                                                                               .value
// //                                                                               .mostPobuler![
// //                                                                           index]
// //                                                                               .products![
// //                                                                           index1]
// //                                                                               .isFavorit==0?1:0;
// //                                                                           setState(
// //                                                                                   () {
// //
// //                                                                               });
// //
// //                                                                           addToWishlistDataSource(product_id: homeController
// //                                                                               .getMostPopularData
// //                                                                               .value
// //                                                                               .mostPobuler![
// //                                                                           index]
// //                                                                               .products![
// //                                                                           index1]
// //                                                                               .id.toString());
// //                                                                         }
//                                                                       },
//                                                                       icon: Icon(
//                                                                         Icons
//                                                                             .favorite_border,
//                                                                         size:
//                                                                             20,
//                                                                         color: homeController
//                                                                             .getMostPopularData
//                                                                             .value
//                                                                             .mostPobuler![
//                                                                         index]
//                                                                             .products![
//                                                                         index1]
//                                                                             .isFavorit==0? AppColors
//                                                                             .grey:AppColors.primaryColor,
//                                                                       )),
//                                                                 )
                                                                Positioned(
                                                                  bottom: -10.h,
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        115.w,
                                                                    child:
                                                                        Container(
                                                                      width: Get
                                                                          .width,
                                                                      height:
                                                                          20.h,
                                                                      child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              height: 20.h,
                                                                              width: 60.w,
                                                                              decoration: BoxDecoration(
                                                                                color: AppColors.whiteColor,
                                                                                borderRadius: BorderRadius.circular(11.r),
                                                                                boxShadow: [
                                                                                  BoxShadow(
                                                                                    color: const Color(0x1aff0000),
                                                                                    offset: Offset(0, 3),
                                                                                    blurRadius: 1,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              child: Center(
                                                                                child: homeController.getMostPopularData.value.mostPobuler![index].products![index1].categoryId.toString() == "3"
                                                                                    ? CustomText(
                                                                                        homeController.getMostPopularData.value.mostPobuler![index].products![index1].simType.toString() == "1" ? "Etisalat" : "Du",
                                                                                        fontSize: 10.sp,
                                                                                        fontWeight: FontWeight.w400,
                                                                                        color: AppColors.primaryColor,
                                                                                      )
                                                                                    : CustomText(
                                                                                        SPHelper.spHelper.getLanguage() == "en" ? Helper.limitString(homeController.getMostPopularData.value.mostPobuler![index].products![index1].city!.nameEn.toString(), 10) : Helper.limitString(homeController.getMostPopularData.value.mostPobuler![index].products![index1].city!.name.toString(), 10) ?? "",
                                                                                        fontSize: 10.sp,
                                                                                        fontWeight: FontWeight.w400,
                                                                                        color: AppColors.primaryColor,
                                                                                      ),
                                                                              ),
                                                                            )
                                                                          ]),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 20.h,
                                                            ),
                                                            homeController
                                                                            .getMostPopularData
                                                                            .value
                                                                            .mostPobuler![
                                                                                index]
                                                                            .products![
                                                                                index1]
                                                                            .categoryId
                                                                            .toString() ==
                                                                        "3" ||
                                                                    homeController
                                                                            .getMostPopularData
                                                                            .value
                                                                            .mostPobuler![
                                                                                index]
                                                                            .products![
                                                                                index1]
                                                                            .categoryId
                                                                            .toString() ==
                                                                        "4"
                                                                ? SizedBox()
                                                                : homeController
                                                                            .getMostPopularData
                                                                            .value
                                                                            .mostPobuler![index]
                                                                            .products![index1]
                                                                            .name ==
                                                                        null
                                                                    ? SizedBox()
                                                                    : CustomText(
                                                                        homeController.getMostPopularData.value.mostPobuler![index].products![index1].name!.length > 20
                                                                            ? homeController.getMostPopularData.value.mostPobuler![index].products![index1].name!.toString().substring(0, 20) +
                                                                                "..."
                                                                            : homeController.getMostPopularData.value.mostPobuler![index].products![index1].name!,

                                                                        fontSize:
                                                                            10.sp,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        // fontFamily:
                                                                        //     "tajawalb",
                                                                      ),
                                                            SizedBox(
                                                              height: 7.h,
                                                            ),
                                                            homeController
                                                                            .getMostPopularData
                                                                            .value
                                                                            .mostPobuler![
                                                                                index]
                                                                            .products![
                                                                                index1]
                                                                            .categoryId
                                                                            .toString() ==
                                                                        "5" ||
                                                                    homeController
                                                                            .getMostPopularData
                                                                            .value
                                                                            .mostPobuler![
                                                                                index]
                                                                            .products![
                                                                                index1]
                                                                            .categoryId
                                                                            .toString() ==
                                                                        "6" ||
                                                                    homeController
                                                                            .getMostPopularData
                                                                            .value
                                                                            .mostPobuler![
                                                                                index]
                                                                            .products![
                                                                                index1]
                                                                            .categoryId
                                                                            .toString() ==
                                                                        "7"
                                                                ? SizedBox()
                                                                : homeController
                                                                            .getMostPopularData
                                                                            .value
                                                                            .mostPobuler![index]
                                                                            .products![index1]
                                                                            .categoryId
                                                                            .toString() ==
                                                                        "9"
                                                                    ? CustomText(
                                                                        homeController.getMostPopularData.value.mostPobuler![index].products![index1].priceDaily.toString() +
                                                                            " AED / Daily",
                                                                        fontSize:
                                                                            10.sp,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      )
                                                                    : CustomText(
                                                                        homeController.getMostPopularData.value.mostPobuler![index].products![index1].price.toString() +
                                                                            " " +
                                                                            "AED".tr,
                                                                        fontSize:
                                                                            10.sp,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                            Spacer(),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10.w),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  CustomText(
                                                                    homeController
                                                                        .getMostPopularData
                                                                        .value
                                                                        .mostPobuler![
                                                                            index]
                                                                        .products![
                                                                            index1]
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
                                                                  Spacer(),
                                                                  Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    size: 12.r,
                                                                    color: homeController.getMostPopularData.value.mostPobuler![index].products![index1].isFavorit ==
                                                                            0
                                                                        ? AppColors
                                                                            .grey
                                                                        : AppColors
                                                                            .primaryColor,
                                                                  )
                                                                  // Spacer(),
                                                                  // IconButton(
                                                                  //     onPressed:
                                                                  //         () {},
                                                                  //     icon:
                                                                  //         Icon(
                                                                  //       Icons
                                                                  //           .favorite_border,
                                                                  //       size: 5,
                                                                  //     ))
                                                                  // CustomSvgImage(
                                                                  //   imageName:
                                                                  //       "heart_car",
                                                                  //   height: 9.h,
                                                                  //   width: 12.w,
                                                                  // )
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
                                SizedBox(
                                  height: 5.h,
                                )
                              ],
                            );
                          },
                        ),
                      );
              })
            ],
          ),
        )),
      ),
    );
  }
}
