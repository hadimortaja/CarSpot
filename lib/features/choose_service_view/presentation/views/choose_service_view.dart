import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/features/choose_method_view/presentation/widgets/choose_method_widget.dart';
import 'package:car_rental/features/choose_service_view/presentation/widgets/choose_service_widget.dart';
import 'package:car_rental/features/create_account_provider/presentation/views/create_account_provider_view.dart';
import 'package:car_rental/features/upload_car_view/data/data_sources/choose_plan_data_source.dart';
import 'package:flutter/cupertino.dart';

class ChooseServiceView extends StatelessWidget {
  List<String> images = ["car_show", "truck", "care", "parts", "rent"];

  List<String> des = [
    "You will be able to see all ads but you\nwill be restricted when adding some ads"
        .tr,
    "You will be able to see all ads and you will be\nable to add ads in all sections"
        .tr,
    "You will be able to see all ads but you\nwill be restricted when adding some ads"
        .tr,
    "You will be able to see all ads but you\nwill be restricted when adding some ads"
        .tr,
    "You will be able to see all ads but you\nwill be restricted when adding some ads"
        .tr,
  ];
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 60.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(children: [
            Column(
              children: [
                CustomText(
                  "Choose your service",
                  fontSize: 22.sp,
                  fontFamily: "tajawalb",
                ),
                SizedBox(
                  height: 18.h,
                ),
                CustomText(
                  "Choose the category in app",
                  fontSize: 15.sp,
                  color: AppColors.borderColor,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 17.h,
                ),
                Obx(() {
                  return authController.getServicesData.value.status == null
                      ? CupertinoActivityIndicator()
                      : authController.getServicesData.value.data!.length == 0
                          ? CustomText(
                              "There is No Services",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            )
                          : SizedBox(
                              width: Get.width,
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: authController
                                      .getServicesData.value.data!.length,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemBuilder: (context, index) {
                                    return ChooseServiceWidget(
                                      id: authController.getServicesData.value
                                          .data![index].id,
                                      index: index,
                                      imageName: images[index],
                                      title: authController.getServicesData
                                          .value.data![index].name,
                                      desc: des[index],
                                    );
                                  }),
                            );
                }),
                SizedBox(
                  height: 17.h,
                ),
                CustomButton(
                  onTap: () {
                    authController.cleanFilter();
                    if (authController.indexService == -1) {
                      BotToast.showText(text: "Please Select Service".tr);
                    } else {
                      Get.to(() => CreateAccountProviderView());
                    }
                  },
                  width: Get.width,
                  height: 59.h,
                  btnColor: AppColors.primaryColor,
                  title: "Continue",
                ),
                SizedBox(
                  height: 17.h,
                ),
              ],
            )
          ]),
        ))
      ]),
    );
  }
}
