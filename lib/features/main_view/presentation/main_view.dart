import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/controllers/app_controller.dart';
import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/custom_bottom_navigation.dart';
import 'package:car_rental/features/choose_country_view/data/data_souces/cities_data_source.dart';
import 'package:car_rental/features/home_view/data/data_sources/most_popular_data_source.dart';
import 'package:car_rental/features/home_view/presentation/views/home_view.dart';
import 'package:car_rental/features/my_ads_view/data/data_sources/my_ads_data_source.dart';
import 'package:car_rental/features/my_ads_view/presentation/views/my_ads_view.dart';
import 'package:car_rental/features/notification_view/data/data_sources/notification_data_source.dart';
import 'package:car_rental/features/notification_view/presentation/views/notification_view.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_profile_data_source.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_vendor_profile_data_source.dart';
import 'package:car_rental/features/profile_view/presentation/views/profile_view.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/data_sources/categories_ads_data_source.dart';
import 'package:car_rental/features/upload_ads_customer_view/presentation/views/upload_ads_customer_view.dart';
import 'package:car_rental/features/upload_car_for_rent_view/presentation/views/upload_car_for_rent_view.dart';
import 'package:car_rental/features/upload_car_parts_view/presentation/views/upload_car_parts_view.dart';
import 'package:car_rental/features/upload_car_view/presentation/views/upload_car_view.dart';
import 'package:car_rental/features/upload_truck_view/presentation/views/upload_truck_view.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../upload_car_service_view/presentation/views/upload_car_service_view.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with TickerProviderStateMixin {
  AppController appController = Get.find();
  UploadAdsController uploadAdsController = Get.find();
  ProfileController profileController = Get.find();
  var indexTab = 0;
  @override
  void initState() {
    getVendorProfileDataSource();

    appController.controller = TabController(vsync: this, length: 4);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          uploadAdsController.setIndexCarServicesStepper(0);
          uploadAdsController.setIndexVehicleNumberStepper(0);
          uploadAdsController.setIndexMobileNumberStepper(0);
          uploadAdsController.setIndexCarPartsStepper(0);
          uploadAdsController.setIndexStepper(0);
          authController.setIndexCity(-1);
          uploadAdsController.setCodeV("");
          uploadAdsController.setIndexVehicleType(-1);
          uploadAdsController.setIndexNumberType(-1);

          // getProfileDataSource();
          uploadAdsController.imagesAds!.clear();
          authController.cleanFilter();
          if (SPHelper.spHelper.getToken() == null ||
              SPHelper.spHelper.getToken() == "") {
            BotToast.showText(
                text: "Please Login".tr,
                contentColor: AppColors.primaryColor,
                textStyle:
                    TextStyle(fontSize: 12.sp, color: AppColors.whiteColor));
          } else if (SPHelper.spHelper.getType() == "1") {
            if (profileController
                    .getVendorProfileData.value.data!.vendor!.serviceId
                    .toString() ==
                "1") {
              Get.to(() => UploadCarView());
            } else if (profileController
                    .getVendorProfileData.value.data!.vendor!.serviceId
                    .toString() ==
                "2") {
              Get.to(() => UploadTruckView());
            } else if (profileController
                    .getVendorProfileData.value.data!.vendor!.serviceId
                    .toString() ==
                "4") {
              uploadAdsController.setIndexCarPartsStepper(0);
              Get.to(() => UploadCarPartsView());
            } else if (profileController
                    .getVendorProfileData.value.data!.vendor!.serviceId
                    .toString() ==
                "5") {
              uploadAdsController.setIndexStepper(0);

              Get.to(() => UploadCarForRentView());
            } else if (profileController
                    .getVendorProfileData.value.data!.vendor!.serviceId
                    .toString() ==
                "3") {
              uploadAdsController.setIndexCarServicesStepper(0);
              Get.to(() => UploadCarServiceView());
            }
          } else {
            getProfileDataSource();
            uploadAdsController.setIndexStepper(0);
            categoriesAdsDataSource();
            Get.to(() => UploadAdsCustomerView());
          }
        },
        child: Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor,
            boxShadow: [
              BoxShadow(
                color: const Color(0x40ff0000),
                offset: Offset(0, 6),
                blurRadius: 6,
              ),
            ],
          ),
          child: Center(
              child: CustomSvgImage(
            imageName: "plus_icon",
            height: 25.h,
          )),
        ),
      ),
      bottomNavigationBar: GetBuilder<AppController>(
        init: AppController(),
        id: "indexScreen",
        builder: (controller) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r)),
            child: Container(
              height: 70.h,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(1, 3),
                      blurRadius: 4,
                      spreadRadius: 15.r),
                ],
              ),
              child: Theme(
                data: ThemeData(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
                child: TabBar(
                  onTap: (index) {
                    setState(() {
                      indexTab = index;
                      if (index == 3) {
                        getProfileDataSource();
                      } else if (index == 2 &&
                          SPHelper.spHelper.getToken() != "") {
                        myAdsDataSource(1, true);
                      } else if (index == 1) {
                        notificationsDataSource(1, true);
                      } else if (index == 0) {
                        homeMostPopularDataSource();
                      }
                    });
                  },
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  indicator: MaterialIndicator(
                      color: AppColors.primaryColor,
                      height: 2.h,
                      topRightRadius: 0,
                      topLeftRadius: 0,
                      bottomLeftRadius: 0,
                      bottomRightRadius: 0,
                      // distanceFromCenter: 16,
                      // radius: 3,
                      horizontalPadding: 30.w,
                      paintingStyle: PaintingStyle.fill,
                      tabPosition: TabPosition.top),
                  controller: appController.controller,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.red,
                  tabs: <Widget>[
                    indexTab == 0
                        ? Container(
                            height: 32.h,
                            width: 32.w,
                            decoration: BoxDecoration(
                              color: const Color(0xffff0000),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x40ff0000),
                                  offset: Offset(0, 3),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Center(
                              child: CustomSvgImage(
                                imageName: 'homr_car',
                                height: 20.h,
                                width: 16.w,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          )
                        : CustomSvgImage(
                            imageName: 'homr_car',
                            height: 20.h,
                            width: 16.w,
                            color: AppColors.grey,
                          ),
                    indexTab == 1
                        ? Container(
                            height: 32.h,
                            width: 32.w,
                            decoration: BoxDecoration(
                              color: const Color(0xffff0000),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x40ff0000),
                                  offset: Offset(0, 3),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Center(
                              child: CustomSvgImage(
                                imageName: 'notification_car',
                                height: 20.h,
                                width: 16.w,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          )
                        : CustomSvgImage(
                            imageName: 'notification_car',
                            height: 20.h,
                            width: 16.w,
                            color: AppColors.grey,
                          ),
                    indexTab == 2
                        ? Container(
                            height: 32.h,
                            width: 32.w,
                            decoration: BoxDecoration(
                              color: const Color(0xffff0000),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x40ff0000),
                                  offset: Offset(0, 3),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Center(
                              child: CustomSvgImage(
                                imageName: 'chart_car',
                                height: 20.h,
                                width: 16.w,
                                color: AppColors.whiteColor,
                              ),
                            ))
                        : CustomSvgImage(
                            imageName: 'chart_car',
                            height: 20.h,
                            width: 16.w,
                            color: Colors.grey),
                    indexTab == 3
                        ? Container(
                            height: 32.h,
                            width: 32.w,
                            decoration: BoxDecoration(
                              color: const Color(0xffff0000),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x40ff0000),
                                  offset: Offset(0, 3),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Center(
                              child: CustomSvgImage(
                                imageName: 'profile_car',
                                height: 20.h,
                                width: 16.w,
                                color: AppColors.whiteColor,
                              ),
                            ))
                        : CustomSvgImage(
                            imageName: 'profile_car',
                            height: 20.h,
                            width: 16.w,
                            color: AppColors.grey,
                          ),
                  ],
                  //,controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
            ),
          );
          // ClipRRect(
          //     borderRadius: BorderRadius.circular(30.r),
          //     child: Container(
          //         height: 90.h,
          //         width: Get.width,
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           boxShadow: [
          //             BoxShadow(
          //               color: const Color(0x26000000),
          //               offset: Offset(0, 3),
          //               blurRadius: 3,
          //             ),
          //           ],
          //         ),
          //         child: Padding(
          //           padding: EdgeInsets.only(top: 20.h),
          //           child: CustomNavBottom(),
          //         )));
        },
      ),
      body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: appController.controller,
          children: [
            HomeView(),
            NotificationView(),
            SPHelper.spHelper.getToken() == ""
                ? Center(
                    child: CustomText(
                      "Please Sign In To See Your Ads",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                : MyAdsView(),
            ProfileView(),
          ]),
    );
  }
}

// class PageNav {
//   static List<Widget> widgetOptions = <Widget>[];
// }
