import 'dart:developer';

import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/cached_network_image.dart';
import 'package:car_rental/features/car_ad_sale_view/data/data_sources/get_product_by_id_data_source.dart';
import 'package:car_rental/features/car_ad_sale_view/presentation/views/car_ad_sale_view.dart';
import 'package:car_rental/features/search_view/data/data_sources/search_data_source.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class SearchView extends StatelessWidget {
  TextEditingController editingController = TextEditingController();
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
                "Search",
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
        Expanded(
            child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SizedBox(
                height: 40.h,
                child: TextFormField(
                  autofocus: true,
                  controller: editingController,
                  onChanged: (value) {
                    searchDataSource(value, 1, true);
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.primaryColor,
                      ),
                      hintText: 'Search By Cars, Numbers etc...'.tr,
                      hintStyle: TextStyle(
                        fontFamily: "tajawal",
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  CustomText(
                    "Search Results :",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Obx(() {
              return homeController.getSearchData.value.code == null
                  ? SizedBox()
                  : homeController.getSearchData.value.filters!.data!.length ==
                          0
                      ? CustomText(
                          "There is No Data",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        )
                      : Expanded(
                          child: LazyLoadScrollView(
                            isLoading: true,
                            onEndOfPage: () {
                              print(homeController
                                  .getSearchData.value.filters!.currentPage);
                              print(homeController
                                  .getSearchData.value.filters!.lastPage);

                              log('ennd');

                              if (homeController.getSearchData.value.filters!
                                      .currentPage !=
                                  homeController
                                      .getSearchData.value.filters!.lastPage) {
                                searchDataSource(
                                    editingController.text,
                                    homeController.getSearchData.value.filters!
                                            .currentPage! +
                                        1,
                                    false);
                                // Apis.apis.getAllNews(
                                //   appController.allNewsApp.value.currentPage! + 1,
                                //   false,
                                // );
                              }
                            },
                            child: ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                itemCount: homeController.allSearchList.length,
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      getProductById(homeController
                                          .allSearchList[index].id
                                          .toString());
                                      Get.to(() => CarAdSaleView(
                                            id: homeController
                                                .allSearchList[index].id
                                                .toString(),
                                          ));
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
                                                color: const Color(0x1aff0000),
                                                offset: Offset(0, 4),
                                                blurRadius: 6,
                                              ),
                                            ],
                                          ),
                                          child: Column(children: [
                                            Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                CachedNetworkImageShare(
                                                  homeController
                                                          .allSearchList[index]
                                                          .photo ??
                                                      "",
                                                  168,
                                                  Get.width,
                                                  15,
                                                  fit: BoxFit.cover,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CustomSvgImage(
                                                            imageName:
                                                                "title_icon",
                                                            height: 10.h,
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          CustomText(
                                                            homeController
                                                                .allSearchList[
                                                                    index]
                                                                .name,
                                                            fontSize: 10.sp,
                                                            fontFamily:
                                                                "tajawalb",
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 13.h,
                                                      ),
                                                      Row(
                                                        children: [
                                                          CustomSvgImage(
                                                            imageName:
                                                                "date_icon",
                                                            height: 10.h,
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          CustomText(
                                                            homeController
                                                                .allSearchList[
                                                                    index]
                                                                .productionYear??"",
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 13.h,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          CustomSvgImage(
                                                            imageName:
                                                                "color_icon",
                                                            height: 12.h,
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          CustomText(
                                                            "Red",
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 13.h,
                                                      ),
                                                    ],
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
                                                                "price_icon",
                                                            height: 8.h,
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          CustomText(
                                                            "${homeController.allSearchList[index].price} AED",
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 13.h,
                                                      ),
                                                      Row(
                                                        children: [
                                                          CustomSvgImage(
                                                            imageName:
                                                                "location_icon",
                                                            height: 10.h,
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          CustomText(
                                                            homeController
                                                                .allSearchList[
                                                                    index]
                                                                .address??"",
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 13.h,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          CustomSvgImage(
                                                            imageName:
                                                                "time_icon",
                                                            height: 10.h,
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          CustomText(
                                                            homeController
                                                                .allSearchList[
                                                                    index]
                                                                .updatedAt!
                                                                .substring(
                                                                    0, 10),
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 13.h,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ]),
                                        ),
                                        SizedBox(
                                          height: 23.h,
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        );
            })
          ],
        ))
      ]),
    );
  }
}
