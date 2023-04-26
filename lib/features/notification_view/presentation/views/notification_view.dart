import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/cached_network_image.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NotificationView extends StatelessWidget {
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120.h,
              ),
              SPHelper.spHelper.getToken() == ""
                  ? Center(
                      child: CustomText(
                        "Please Make Login",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : Obx(() {
                      return homeController.getNotificationsData.value.code ==
                              null
                          ? Helper.loading()
                          : homeController.getNotificationsData.value.data!
                                      .data!.length ==
                                  0
                              ? CustomText("There is No Notifications",
                      fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      )
                              : SizedBox(
                                  width: Get.width,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: homeController
                                        .allNotificationsList.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: 40.w,
                                                height: 40.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                    border: Border.all(
                                                        color: AppColors.grey)),
                                                child: Center(
                                                  child: CachedNetworkImageShare(
                                                      homeController
                                                          .allNotificationsList[
                                                              index]
                                                          .image,
                                                      30,
                                                      30,
                                                      10),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 12.w,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    homeController
                                                        .allNotificationsList[
                                                            index]
                                                        .title,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.black,
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  CustomText(
                                                    homeController
                                                        .allNotificationsList[
                                                            index]
                                                        .title,
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.grey,
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 25.h),
                                                child: CustomText(
                                                  homeController
                                                      .allNotificationsList[
                                                          index]
                                                      .createdAt
                                                      .toString()
                                                      .substring(0, 10),
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Divider(),
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                );
                    })
            ],
          )),
    );
  }
}
