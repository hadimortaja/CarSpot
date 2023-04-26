import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FaqsView extends StatelessWidget {
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
                "FAQ",
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
          return homeController.getFaqsData.value.code == null
              ? Helper.loading()
              : Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: homeController.getFaqsData.value.data!.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        backgroundColor:
                            AppColors.primaryColor.withOpacity(0.20),
                        title: CustomText(
                          homeController
                              .getFaqsData.value.data![index].quastion,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        children: <Widget>[
                          CustomText(
                            homeController
                                .getFaqsData.value.data![index].answer,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      );
                    },
                  ),
                );
        })
      ]),
    );
  }
}
