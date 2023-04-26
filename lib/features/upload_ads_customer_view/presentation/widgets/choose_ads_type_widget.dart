import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChooseAdsTypeWidget extends StatelessWidget {
  final String? imageName, title, desc;
  final Function()? onTap;

  ChooseAdsTypeWidget({this.imageName, this.desc, this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UploadAdsController>(
        init: UploadAdsController(),
        builder: (controller) {
          return GestureDetector(
            onTap: onTap,
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: AppColors.borderColor)),
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomSvgImage(
                                imageName: imageName,
                                height: 20.h,
                                width: 20.w,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                width: 18.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    title,
                                    fontSize: 16.sp,
                                    fontFamily: "tajawalb",
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  Container(
                                    constraints:
                                        BoxConstraints(maxWidth: 245.w),
                                    child: CustomText(
                                      desc,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.borderColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          );
        });
  }
}
