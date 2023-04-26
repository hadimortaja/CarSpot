import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/cached_network_image.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/core/widgets/custom_text_form_field.dart';
import 'package:car_rental/features/choose_brand_view/data/data_sources/get_brands_data_source.dart';
import 'package:car_rental/features/choose_brand_view/presentation/views/choose_brand_view.dart';
import 'package:car_rental/features/choose_car_condition_view/presentation/views/choose_car_condition_view.dart';
import 'package:car_rental/features/choose_car_service_view/presentation/views/choose_car_service_view.dart';
import 'package:car_rental/features/choose_country_view/data/data_souces/cities_data_source.dart';
import 'package:car_rental/features/choose_country_view/presentation/views/choose_country_view.dart';
import 'package:car_rental/features/home_view/data/data_sources/most_popular_data_source.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_profile_data_source.dart';
import 'package:car_rental/features/sim_type_view/presentation/views/sim_type_view.dart';
import 'package:car_rental/features/update_car_service_view/data/data_sources/delete_image_data_source.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/data_sources/categories_ads_data_source.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/data_sources/update_ads_data_source.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/data_sources/upload_ads_data_source.dart';
import 'package:car_rental/features/upload_car_parts_view/presentation/widgets/stepper_car_parts.dart';
import 'package:car_rental/features/upload_car_service_view/presentation/widgets/stepper_car_services.dart';
import 'package:car_rental/features/upload_car_view/data/data_sources/choose_plan_data_source.dart';
import 'package:car_rental/features/upload_car_view/presentation/widgets/upload_widget.dart';
import 'package:car_rental/features/upload_mobile_number_customer_view/presentation/widgets/stepper_mobile_number.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UpdateCarServiceView extends StatefulWidget {
  @override
  State<UpdateCarServiceView> createState() => _UpdateCarServiceViewState();
}

class _UpdateCarServiceViewState extends State<UpdateCarServiceView> {
  ProfileController profileController = Get.find();
  UploadAdsController uploadAdsController = Get.find();
  AuthController authController = Get.find();
  String? name, desc;

  final formKey = GlobalKey<FormState>();

  final formKey1 = GlobalKey<FormState>();

  validation(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return 'This field is required*'.tr;
    }
  }

  setName(String value) {
    this.name = value;
  }

  setDesc(String value) {
    this.desc = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          width: Get.width,
          height: 100.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<UploadAdsController>(
                init: UploadAdsController(),
                builder: (controller) {
                  return CustomButton(
                    onTap: () {
                      if (controller.indexCarServicesStepper == 0) {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          controller.setIndexCarServicesStepper(1);
                        }
                      } else if (controller.indexCarServicesStepper == 1) {
                        if (uploadAdsController.imagesAds!.length == 0 &&
                            uploadAdsController.picturesUpdate.length == 0) {
                          BotToast.showText(
                              text: "Please Add at least 1 image".tr);
                        } else {
                          controller.setIndexCarServicesStepper(2);
                        }
                      } else {
                        updateAdsDataSource(
                          product_id: homeController
                              .getProductByIdData.value.data!.id
                              .toString(),
                          category_id: uploadAdsController
                                      .getCategoriesSelect1.value.id !=
                                  null
                              ? uploadAdsController
                                  .getCategoriesSelect1.value.id
                                  .toString()
                              : null,
                          second_category: uploadAdsController
                                      .getCategoriesSelect2.value.id !=
                                  null
                              ? uploadAdsController
                                  .getCategoriesSelect2.value.id
                                  .toString()
                              : null,
                          name: name,

                          address: uploadAdsController.address,
                          content: desc,
                          description: desc,

                          // service_id: "1",
                        );
                      }
                    },
                    width: 329.w,
                    height: 59.h,
                    title: controller.indexCarServicesStepper == 2
                        ? "Update Now"
                        : "Continue",
                  );
                },
              ),
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
                      controller.indexCarServicesStepper == 0
                          ? "Update Car Services"
                          : controller.indexCarServicesStepper == 1
                              ? "Upload Pictures"
                              : "Check Your Ad",
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
              SizedBox(
                height: 20.h,
              ),
              StepperCarServices(controller.indexCarServicesStepper),
              SizedBox(
                height: 30.h,
              ),
              Obx(() {
                return homeController.getProductByIdData.value.code == null
                    ? Helper.loading()
                    : Expanded(
                        child: SingleChildScrollView(
                        child: controller.indexCarServicesStepper == 0
                            ? Form(
                                key: formKey,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Column(children: [
                                    CustomTextFormField(
                                      hint: "Service Name",
                                      height: 2,
                                      validator: validation,
                                      onSaved: setName,
                                      initial: homeController
                                          .getProductByIdData.value.data!.name!,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Obx(() => UploadWidget(
                                          onTap: () {
                                            categoriesAdsDataSource();
                                            authController.setIndexService(-1);
                                            Get.to(
                                                () => ChooseCarServiceView());
                                          },
                                          title: uploadAdsController
                                                          .getCategoriesSelect1
                                                          .value
                                                          .name ==
                                                      null &&
                                                  uploadAdsController
                                                          .getCategoriesSelect2
                                                          .value
                                                          .name ==
                                                      null
                                              ? "Car Services Type"
                                              : uploadAdsController
                                                              .getCategoriesSelect1
                                                              .value
                                                              .name !=
                                                          null &&
                                                      uploadAdsController
                                                              .getCategoriesSelect2
                                                              .value
                                                              .name !=
                                                          null
                                                  ? '${('${uploadAdsController.getCategoriesSelect1.value.name}' + ' & ' + '${uploadAdsController.getCategoriesSelect2.value.name}')}'
                                                  : uploadAdsController
                                                              .getCategoriesSelect1
                                                              .value
                                                              .name !=
                                                          null
                                                      ? uploadAdsController
                                                          .getCategoriesSelect1
                                                          .value
                                                          .name
                                                      : uploadAdsController
                                                                  .getCategoriesSelect2
                                                                  .value
                                                                  .name !=
                                                              null
                                                          ? uploadAdsController
                                                              .getCategoriesSelect2
                                                              .value
                                                              .name
                                                          : '',
                                          isBlack: uploadAdsController
                                                  .getCategoriesSelect1
                                                  .value
                                                  .name !=
                                              null,
                                        )),
                                    Row(
                                      children: [
                                        Container(
                                          height: 5.h,
                                          width: 5.w,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.grey),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        CustomText(
                                          "Description",
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.grey,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    CustomTextFormField(
                                      hint: "Description",
                                      maxLines: 4,
                                      minLines: 1,
                                      onSaved: setDesc,
                                      validator: validation,
                                      initial: homeController.getProductByIdData
                                          .value.data!.description!,
                                      textInputType: TextInputType.multiline,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                  ]),
                                ),
                              )
                            : controller.indexCarServicesStepper == 1
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 27.h,
                                          ),
                                          CustomText(
                                            "Upload Your Service Pictures",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.grey,
                                          ),
                                          SizedBox(
                                            height: 27.h,
                                          ),
                                          GridView.builder(
                                            itemCount: uploadAdsController
                                                        .imagesAds!.length ==
                                                    0
                                                ? 1
                                                : uploadAdsController
                                                    .imagesAds!.length,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            primary: false,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 12,
                                              crossAxisSpacing: 9,
                                              childAspectRatio:
                                                  Helper.childAspectRatio(2.4),
                                            ),
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  uploadAdsController
                                                      .addMultiImageToPost();
                                                  // uploadAdsController.imagesAds ==
                                                  //     null;
                                                },
                                                child: Column(
                                                  children: [
                                                    DottedBorder(
                                                      dashPattern: [
                                                        5,
                                                      ],
                                                      child: uploadAdsController
                                                                  .imagesAds!
                                                                  .length ==
                                                              0
                                                          ? Container(
                                                              height: 132.h,
                                                              width: 156.w,
                                                              child: Center(
                                                                  child: Icon(
                                                                Icons.add,
                                                                size: 30.r,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                            )
                                                          : ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.r),
                                                              child: Container(
                                                                  height: 132.h,
                                                                  width: 156.w,
                                                                  child: Image
                                                                      .file(
                                                                    uploadAdsController
                                                                            .imagesAds![
                                                                        index],
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )),
                                                            ),
                                                      color: AppColors.grey,
                                                      borderType:
                                                          BorderType.RRect,
                                                      radius:
                                                          Radius.circular(15.r),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          index == 0 ? 4.h : 0,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          GridView.builder(
                                            itemCount: uploadAdsController
                                                .picturesUpdate.length,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            primary: false,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 12,
                                              crossAxisSpacing: 9,
                                              childAspectRatio:
                                                  Helper.childAspectRatio(2.4),
                                            ),
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  uploadAdsController
                                                      .addMultiImageToPost();
                                                  // uploadAdsController.imagesAds ==
                                                  //     null;
                                                },
                                                child: Stack(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        DottedBorder(
                                                          dashPattern: [
                                                            5,
                                                          ],
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.r),
                                                            child: Container(
                                                                height: 132.h,
                                                                width: 156.w,
                                                                child: Image
                                                                    .network(
                                                                  uploadAdsController
                                                                      .picturesUpdate[
                                                                          index]
                                                                      .image!,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )),
                                                          ),
                                                          color: AppColors.grey,
                                                          borderType:
                                                              BorderType.RRect,
                                                          radius:
                                                              Radius.circular(
                                                                  15.r),
                                                        ),
                                                        SizedBox(
                                                          height: index == 0
                                                              ? 4.h
                                                              : 0,
                                                        ),
                                                      ],
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          deleteImageDataSource(
                                                              uploadAdsController
                                                                  .picturesUpdate[
                                                                      index]
                                                                  .id!
                                                                  .toString(),
                                                              uploadAdsController
                                                                  .picturesUpdate[
                                                                      index]
                                                                  .productId!
                                                                  .toString());
                                                        },
                                                        icon:
                                                            Icon(Icons.close)),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ]),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w),
                                        child: Row(
                                          children: [
                                            profileController.getProfileData
                                                        .value.data!.type ==
                                                    "1"
                                                ? CachedNetworkImageShare(
                                                    profileController
                                                            .getProfileData
                                                            .value
                                                            .data!
                                                            .photo ??
                                                        "profileController.getProfileData.value.data!.photo",
                                                    37,
                                                    37,
                                                    3)
                                                : CustomPngImage(
                                                    imageName: "male_image",
                                                    height: 37.h,
                                                    width: 37.w,
                                                  ),
                                            SizedBox(
                                              width: 22.w,
                                            ),
                                            CustomText(
                                              profileController.getProfileData
                                                  .value.data!.name,
                                              fontSize: 16.sp,
                                              fontFamily: "tajawalb",
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      uploadAdsController
                                                  .picturesUpdate.length !=
                                              0
                                          ? Container(
                                              width: Get.width,
                                              height: 284.h,
                                              child: Image.network(
                                                uploadAdsController
                                                    .picturesUpdate[0].image!,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Container(
                                              width: Get.width,
                                              height: 284.h,
                                              child: Image.file(
                                                uploadAdsController
                                                    .imagesAds![0],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                      SizedBox(
                                        height: 22.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              "Car Services Details",
                                              fontSize: 16.sp,
                                              fontFamily: "tajawalb",
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Row(
                                              children: [
                                                CustomText(
                                                  "Service Name",
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey,
                                                ),
                                                Spacer(),
                                                CustomText(
                                                  name,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Row(
                                              children: [
                                                CustomText(
                                                  "Car Services Type",
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey,
                                                ),
                                                Spacer(),
                                                CustomText(
                                                  uploadAdsController
                                                              .getCategoriesSelect1
                                                              .value
                                                              .name ==
                                                          null
                                                      ? uploadAdsController
                                                          .getCategoriesSelect2
                                                          .value
                                                          .name
                                                      : "",
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Row(
                                              children: [
                                                CustomText(
                                                  "Address",
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey,
                                                ),
                                                Spacer(),
                                                CustomText(
                                                  profileController
                                                      .getProfileData
                                                      .value
                                                      .data!
                                                      .address,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 27.h,
                                            ),
                                            CustomText(
                                              "Contact Details",
                                              fontSize: 16.sp,
                                              fontFamily: "tajawalb",
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Row(
                                              children: [
                                                CustomText(
                                                  "Mobile Number",
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey,
                                                ),
                                                Spacer(),
                                                CustomText(
                                                  profileController
                                                          .getProfileData
                                                          .value
                                                          .data!
                                                          .phoneNumber ??
                                                      "",
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 14.h,
                                            ),
                                            Row(
                                              children: [
                                                CustomText(
                                                  "Whatsapp",
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey,
                                                ),
                                                Spacer(),
                                                CustomText(
                                                  profileController
                                                          .getProfileData
                                                          .value
                                                          .data!
                                                          .phoneNumber ??
                                                      "",
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 14.h,
                                            ),
                                            SizedBox(
                                              height: 27.h,
                                            ),
                                            CustomText(
                                              "Car Care Description",
                                              fontSize: 16.sp,
                                              fontFamily: "tajawalb",
                                            ),
                                            SizedBox(
                                              height: 14.h,
                                            ),
                                            CustomText(
                                              desc,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.grey,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                      ));
              })
            ]);
          }),
    );
  }
}
