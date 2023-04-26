import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/features/cars_view/data/data_sources/products_by_category_data_source.dart';

class VehcileTypeView extends StatelessWidget {
  List<String> types = ["Car".tr, "Motorcycle".tr];
  String? id;
  final bool? isAdd;
  VehcileTypeView({this.id, this.isAdd = false});
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
            width: Get.width,
            height: 100.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: () {
                    if (isAdd!) {
                      Get.back();
                    } else {
                      getProductsByCategoryDataSource(1, true, id!,
                          vehicle_type: Get.find<UploadAdsController>()
                              .vehicleType
                              .value);
                      Get.back();
                    }
                  },
                  width: 329.w,
                  height: 59.h,
                  title: "Continue",
                )
              ],
            )),
        body: GetBuilder<UploadAdsController>(
          init: UploadAdsController(),
          builder: (controller) {
            return Column(children: [
              SizedBox(
                height: 60.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    CustomText(
                      "Vehicle Type",
                      fontSize: 22.sp,
                      fontFamily: "tajawalb",
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    SizedBox(
                      width: Get.width,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: types.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              controller.setIndexType(index);
                              controller.vehicleType.value = types[index];
                              print(controller.vehicleType.value);
                              // controller.getCitiesSelect.value =
                              //     authController
                              //         .getCitiesData.value.data![index];
                              // print(controller.getCitiesSelect.value.name);
                            },
                            child: Container(
                              width: Get.width,
                              height: 46.h,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xffFF0000)
                                        .withOpacity(0.10),
                                    offset: Offset(0, 2),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 13.w),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        types[index],
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      Icon(
                                        Icons.check,
                                        size: 20.r,
                                        color: controller.indexType == index
                                            ? AppColors.primaryColor
                                            : Colors.transparent,
                                      )
                                    ]),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ))
            ]);
          },
        ));
  }
}
