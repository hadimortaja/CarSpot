import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/features/choose_method_view/presentation/widgets/choose_method_widget.dart';
import 'package:car_rental/features/choose_service_view/data/data_sources/choose_service_data_source.dart';
import 'package:car_rental/features/choose_service_view/presentation/views/choose_service_view.dart';
import 'package:car_rental/features/create_account_normal_user/presentation/views/create_account_user_view.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChooseMethodView extends StatelessWidget {
  AuthController authController = Get.find();
  List<String> images = ["customer", "vendor"];

  List<String> titles = ["Customer".tr, "Vendor".tr];

  List<String> des = [
    "You will be able to see all ads and you will be able to add ads in all sections",
    "You will be able to see all ads but you will be restricted when adding some ads",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 100.h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.w),
              child: CustomButton(
                onTap: () {
                  if (authController.index == 0) {
                    Get.to(() => CreateAccountNormalUserView());
                  } else {
                    chooseServiceDataSource();
                    authController.cleanImage();
                    Get.to(() => ChooseServiceView());
                  }
                },
                width: Get.width,
                height: 59.h,
                btnColor: AppColors.primaryColor,
                title: "Continue",
              ),
            ),
          ],
        ),
      ),
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 46.h,
            ),
            Row(
              children: [
                CustomText(
                  "Hi ! Welcome to",
                  fontSize: 27.sp,
                  fontFamily: "tajawalb",
                ),
                SizedBox(
                  width: 5.w,
                ),
                CustomText(
                  "CARDEAL",
                  fontSize: 27.sp,
                  fontFamily: "tajawalb",
                  color: AppColors.primaryColor,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomText(
              "Choose the registration method you will use in application",
              fontSize: 14.sp,
              color: AppColors.borderColor,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              height: 36.h,
            ),
            SizedBox(
              width: Get.width,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 2,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    return ChooseMethodWidget(
                      index: index,
                      imageName: images[index],
                      title: titles[index],
                      desc: des[index],
                    );
                  }),
            ),
          ]),
        ))
      ]),
    );
  }
}
