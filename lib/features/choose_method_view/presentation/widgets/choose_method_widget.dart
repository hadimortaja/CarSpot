import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChooseMethodWidget extends StatelessWidget {
  final int? index;
  final String? imageName, title, desc;

  ChooseMethodWidget({this.index, this.imageName, this.desc, this.title});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              controller.setIndex(index!);
            },
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                          color: controller.index == index
                              ? AppColors.black
                              : AppColors.borderColor)),
                  child: Padding(
                    padding: EdgeInsets.all(18.r),
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
                                color: controller.index == index
                                    ? AppColors.primaryColor
                                    : AppColors.borderColor,
                              ),
                              SizedBox(
                                width: 18.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    title,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  Container(
                                    constraints:
                                        BoxConstraints(maxWidth: 240.w),
                                    child: CustomText(
                                      desc,
                                      fontSize: 12.sp,
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
