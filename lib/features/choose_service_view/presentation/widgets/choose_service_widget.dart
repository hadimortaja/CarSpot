import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChooseServiceWidget extends StatelessWidget {
  final int? index, id;
  final String? imageName, title, desc;

  ChooseServiceWidget(
      {this.index, this.id, this.imageName, this.desc, this.title});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              // controller.setServiceId(id!);
              // print(index);
              // print("ssssssss ${controller.serviceId}");

              // print("idddddd $id");
              print(controller.indexService);
              controller.setIndexService(index!);
              controller.getServiceSelect.value =
                  controller.getServicesData.value.data![index!];
              print(controller.getServiceSelect.value.name);
              print(controller.getServiceSelect.value.id);
            },
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                          color: controller.indexService == index
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
                                color: controller.indexService == index
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
