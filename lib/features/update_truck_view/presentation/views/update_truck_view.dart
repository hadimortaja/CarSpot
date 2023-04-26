import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/core/widgets/custom_text_form_field.dart';
import 'package:car_rental/features/calculator_view/data/data_sources/calculate_data_source.dart';
import 'package:car_rental/features/car_paint_color_view/data/data_sources/paint_color_data_source.dart';
import 'package:car_rental/features/car_paint_color_view/presentation/views/car_paint_color_view.dart';
import 'package:car_rental/features/choose_brand_view/data/data_sources/get_brands_data_source.dart';
import 'package:car_rental/features/choose_brand_view/presentation/views/choose_brand_view.dart';
import 'package:car_rental/features/choose_car_condition_view/presentation/views/choose_car_condition_view.dart';
import 'package:car_rental/features/choose_car_model_view.dart/data/data_sources/get_cars_model_data_source.dart';
import 'package:car_rental/features/choose_car_model_view.dart/presentation/views/choose_car_model_view.dart';
import 'package:car_rental/features/choose_car_year_view/data/data_sources/production_year_data_source.dart';
import 'package:car_rental/features/choose_car_year_view/presentation/views/choose_car_year_view.dart';
import 'package:car_rental/features/choose_country_view/data/data_souces/cities_data_source.dart';
import 'package:car_rental/features/choose_country_view/presentation/views/choose_country_view.dart';
import 'package:car_rental/features/my_ads_view/data/data_sources/my_ads_data_source.dart';
import 'package:car_rental/features/update_car_service_view/data/data_sources/delete_image_data_source.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/data_sources/update_ads_data_source.dart';
import 'package:car_rental/features/upload_ads_customer_view/data/data_sources/upload_ads_data_source.dart';
import 'package:car_rental/features/upload_car_view/presentation/widgets/stepper_car.dart';
import 'package:car_rental/features/upload_car_view/presentation/widgets/upload_widget.dart';
import 'package:car_rental/features/upload_truck_view/data/data_sources/get_truck_brands_data_source.dart';
import 'package:car_rental/features/upload_truck_view/data/data_sources/get_truck_model_data_source.dart';
import 'package:car_rental/features/upload_truck_view/presentation/views/choose_truck_brand_view.dart';
import 'package:car_rental/features/upload_truck_view/presentation/views/choose_truck_model_view.dart';
import 'package:dotted_border/dotted_border.dart';

class UpdateTruckView extends StatefulWidget {
  @override
  State<UpdateTruckView> createState() => _UpdateTruckViewState();
}

class _UpdateTruckViewState extends State<UpdateTruckView> {
  final formKey = GlobalKey<FormState>();

  final formKey1 = GlobalKey<FormState>();

  validation(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return 'This field is required*';
    }
  }

  ProfileController profileController = Get.find();

  AuthController authController = Get.find();

  UploadAdsController uploadAdsController = Get.find();

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
                      if (controller.indexStepper == 0) {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          controller.setIndexStepper(1);
                        }
                      } else if (controller.indexStepper == 1) {
                        if (uploadAdsController.imagesAds!.length == 0 &&
                            uploadAdsController.picturesUpdate.length == 0) {
                          BotToast.showText(
                              text: "Please Add at least 1 image".tr);
                        } else {
                          controller.setIndexStepper(2);
                        }
                      } else if (controller.indexStepper == 2) {
                        if (formKey1.currentState!.validate()) {
                          formKey1.currentState!.save();
                          controller.setIndexStepper(3);
                        }
                      } else {
                        updateAdsDataSource(
                            product_id: homeController
                                .getProductByIdData.value.data!.id
                                .toString(),
                            category_id: "2",
                            city_id: authController.getCitiesSelect.value.id
                                .toString(),
                            address: uploadAdsController.address,
                            brand_id: authController
                                .getTruckBrandsSelect.value.id
                                .toString(),
                            color_id: authController.getColorsSelect.value.id
                                .toString(),
                            condition: uploadAdsController.condition.value,
                            content: uploadAdsController.desc,
                            description: uploadAdsController.desc,
                            kilometer: uploadAdsController.Killometers,
                            name: uploadAdsController.name,
                            phone: uploadAdsController.mobile.toString(),
                            price: uploadAdsController.price.toString(),
                            production_year: uploadAdsController
                                .getProductionYearSelect.value.name
                                .toString(),
                            status: "1",
                            style_id: authController
                                .getTruckModelSelect.value.id
                                .toString(),
                            type_product: "for_sale",
                            whatsapp: uploadAdsController.whatsapp);
                      }
                    },
                    width: 329.w,
                    height: 59.h,
                    title: controller.indexStepper == 3
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
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          "Update Truck",
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
                  StepperCar(controller.indexStepper),
                  SizedBox(
                    height: 20.h,
                  ),
                  Obx(() {
                    return homeController.getProductByIdData.value.code == null
                        ? Helper.loading()
                        : Expanded(
                            child: SingleChildScrollView(
                            child: controller.indexStepper == 0
                                ? Form(
                                    key: formKey,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomTextFormField(
                                              height: 2,
                                              hint: "name",
                                              onSaved:
                                                  uploadAdsController.setName,
                                              validator: validation,
                                              // isBlack: uploadAdsController.name != "",
                                              textInputType: TextInputType.text,
                                              initial: homeController
                                                  .getProductByIdData
                                                  .value
                                                  .data!
                                                  .name!,
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            UploadWidget(
                                              isBlack: authController
                                                      .getTruckBrandsSelect
                                                      .value
                                                      .name !=
                                                  null,
                                              title: authController
                                                          .getTruckBrandsSelect
                                                          .value
                                                          .name ==
                                                      null
                                                  ? "Brand"
                                                  : authController
                                                      .getTruckBrandsSelect
                                                      .value
                                                      .name,
                                              onTap: () {
                                                getTruckBrandsDataSource();
                                                Get.to(() =>
                                                    ChooseTruckBrandView());
                                              },
                                            ),
                                            authController.getTruckBrandsSelect
                                                        .value.name ==
                                                    null
                                                ? SizedBox()
                                                : UploadWidget(
                                                    isBlack: authController
                                                            .getTruckModelSelect
                                                            .value
                                                            .name !=
                                                        null,
                                                    onTap: () {
                                                      getTruckModelDataSource(
                                                          authController
                                                              .getTruckBrandsSelect
                                                              .value
                                                              .id
                                                              .toString());
                                                      Get.to(() =>
                                                          ChooseTruckModelView());
                                                    },
                                                    title: authController
                                                                .getTruckModelSelect
                                                                .value
                                                                .name ==
                                                            null
                                                        ? "Truck Model"
                                                        : authController
                                                            .getTruckModelSelect
                                                            .value
                                                            .name,
                                                  ),
                                            UploadWidget(
                                              isBlack: uploadAdsController
                                                      .getProductionYearSelect
                                                      .value
                                                      .name !=
                                                  null,
                                              onTap: () {
                                                productionYearDataSource();
                                                Get.to(
                                                    () => ChooseCarYearView());
                                              },
                                              title: uploadAdsController
                                                          .getProductionYearSelect
                                                          .value
                                                          .name ==
                                                      null
                                                  ? "Production Year"
                                                  : uploadAdsController
                                                      .getProductionYearSelect
                                                      .value
                                                      .name,
                                            ),
                                            UploadWidget(
                                              isBlack: authController
                                                      .getColorsSelect
                                                      .value
                                                      .name !=
                                                  null,
                                              onTap: () {
                                                paintColorDataSource();
                                                Get.to(
                                                    () => CarPaintColorView());
                                              },
                                              title: authController
                                                          .getColorsSelect
                                                          .value
                                                          .name ==
                                                      null
                                                  ? "Truck Paint Color"
                                                  : authController
                                                      .getColorsSelect
                                                      .value
                                                      .name,
                                            ),
                                            UploadWidget(
                                              isBlack:
                                                  controller.condition.value !=
                                                      "",
                                              onTap: () {
                                                Get.to(() =>
                                                    ChooseCarConditionView());
                                              },
                                              title: controller
                                                          .condition.value ==
                                                      ""
                                                  ? "Condition"
                                                  : controller.condition.value,
                                            ),
                                            CustomTextFormField(
                                              height: 2,
                                              hint: "Kilometers",
                                              validator: validation,
                                              textInputType:
                                                  TextInputType.number,
                                              onSaved: uploadAdsController
                                                  .setKillometers,
                                              initial: homeController
                                                  .getProductByIdData
                                                  .value
                                                  .data!
                                                  .kilometer
                                                  .toString(),
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            CustomTextFormField(
                                              height: 2,
                                              hint: "Price",
                                              validator: validation,
                                              onSaved:
                                                  uploadAdsController.setPrice,
                                              textInputType:
                                                  TextInputType.number,
                                              initial: homeController
                                                  .getProductByIdData
                                                  .value
                                                  .data!
                                                  .price
                                                  .toString(),
                                            ),
                                          ]),
                                    ),
                                  )
                                : controller.indexStepper == 1
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 27.h,
                                              ),
                                              CustomText(
                                                "Upload You Car Pictures",
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.grey,
                                              ),
                                              SizedBox(
                                                height: 27.h,
                                              ),
                                              GridView.builder(
                                                itemCount: uploadAdsController
                                                            .imagesAds!
                                                            .length ==
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
                                                      Helper.childAspectRatio(
                                                          2.4),
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
                                                                      child:
                                                                          Icon(
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
                                                                      child: Image.file(
                                                                        uploadAdsController
                                                                            .imagesAds![index],
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
                                                        index == 0
                                                            ? Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: 5.w,
                                                                  ),
                                                                  Container(
                                                                    width: 5.w,
                                                                    height: 5.h,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: AppColors
                                                                            .grey),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5.w,
                                                                  ),
                                                                  CustomText(
                                                                    "Profile ad picture",
                                                                    fontSize:
                                                                        9.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        AppColors
                                                                            .grey,
                                                                  )
                                                                ],
                                                              )
                                                            : SizedBox()
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                height: 12.h,
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
                                                      Helper.childAspectRatio(
                                                          2.4),
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
                                                                    child: Image.network(
                                                                      uploadAdsController
                                                                          .picturesUpdate[
                                                                              index]
                                                                          .image!,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )),
                                                              ),
                                                              color: AppColors
                                                                  .grey,
                                                              borderType:
                                                                  BorderType
                                                                      .RRect,
                                                              radius: Radius
                                                                  .circular(
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
                                                            icon: Icon(
                                                                Icons.close)),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ]),
                                      )
                                    : controller.indexStepper == 2
                                        ? Form(
                                            key: formKey1,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.w),
                                              child: Column(children: [
                                                SizedBox(
                                                  height: 30.h,
                                                ),
                                                Obx(() => UploadWidget(
                                                      isBlack: authController
                                                              .getCitiesSelect
                                                              .value
                                                              .name !=
                                                          null,
                                                      onTap: () {
                                                        citiesDataSource();
                                                        Get.to(() =>
                                                            ChooseCountryView());
                                                      },
                                                      title: authController
                                                                  .getCitiesSelect
                                                                  .value
                                                                  .name ==
                                                              null
                                                          ? "City"
                                                          : authController
                                                              .getCitiesSelect
                                                              .value
                                                              .name,
                                                    )),
                                                Container(
                                                  width: Get.width,
                                                  height: 59.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.r),
                                                      border: Border.all(
                                                          color:
                                                              AppColors.grey)),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.w),
                                                    child: Row(children: [
                                                      Expanded(
                                                          child: TextFormField(
                                                        onSaved: (newValue) =>
                                                            uploadAdsController
                                                                .setAdress(
                                                                    newValue!),
                                                        validator: (value) =>
                                                            validation(value!),
                                                        initialValue:
                                                            homeController
                                                                .getProductByIdData
                                                                .value
                                                                .data!
                                                                .address,
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Address".tr,
                                                            helperStyle: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: AppColors
                                                                    .grey,
                                                                fontFamily:
                                                                    "tajawal",
                                                                fontSize:
                                                                    15.sp)),
                                                      )),
                                                      CustomSvgImage(
                                                        imageName:
                                                            "location_icon",
                                                        color: AppColors
                                                            .primaryColor,
                                                        height: 24.h,
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                Container(
                                                  width: Get.width,
                                                  height: 59.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.r),
                                                      border: Border.all(
                                                          color:
                                                              AppColors.grey)),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.w),
                                                    child: Row(children: [
                                                      Expanded(
                                                          child: TextFormField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onSaved: (newValue) =>
                                                            uploadAdsController
                                                                .setMobile(
                                                                    newValue!),
                                                        validator: (value) =>
                                                            validation(value!),
                                                        initialValue:
                                                            homeController
                                                                .getProductByIdData
                                                                .value
                                                                .data!
                                                                .phone
                                                                .toString(),
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Your Mobile Number"
                                                                    .tr,
                                                            helperStyle: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: AppColors
                                                                    .grey,
                                                                fontFamily:
                                                                    "tajawal",
                                                                fontSize:
                                                                    15.sp)),
                                                      )),
                                                      CustomSvgImage(
                                                        imageName: "call",
                                                        color: AppColors
                                                            .primaryColor,
                                                        height: 22.h,
                                                        width: 22.w,
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                Container(
                                                  width: Get.width,
                                                  height: 59.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.r),
                                                      border: Border.all(
                                                          color:
                                                              AppColors.grey)),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.w),
                                                    child: Row(children: [
                                                      Expanded(
                                                          child: TextFormField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onSaved: (newValue1) =>
                                                            uploadAdsController
                                                                .setWhatsapp(
                                                                    newValue1!),
                                                        validator: (value) =>
                                                            validation(value!),
                                                        initialValue:
                                                            homeController
                                                                .getProductByIdData
                                                                .value
                                                                .data!
                                                                .whatsapp
                                                                .toString(),
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Your Whatsapp"
                                                                    .tr,
                                                            helperStyle: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: AppColors
                                                                    .grey,
                                                                fontFamily:
                                                                    "tajawal",
                                                                fontSize:
                                                                    15.sp)),
                                                      )),
                                                      CustomSvgImage(
                                                        imageName: "whatsapp",
                                                        color: AppColors
                                                            .primaryColor,
                                                        height: 20.h,
                                                        width: 20.w,
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 5.h,
                                                      width: 5.w,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              AppColors.grey),
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    CustomText(
                                                      "Description",
                                                      fontSize: 8.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                  onSaved: uploadAdsController
                                                      .setDesc,
                                                  validator: validation,
                                                  initial: homeController
                                                      .getProductByIdData
                                                      .value
                                                      .data!
                                                      .description!,
                                                  textInputType:
                                                      TextInputType.multiline,
                                                ),
                                              ]),
                                            ),
                                          )
                                        : Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w),
                                                child: Row(
                                                  children: [
                                                    CustomPngImage(
                                                      imageName: "male_image",
                                                      height: 37.h,
                                                      width: 37.w,
                                                    ),
                                                    SizedBox(
                                                      width: 14.w,
                                                    ),
                                                    CustomText(
                                                      profileController
                                                              .getProfileData
                                                              .value
                                                              .data!
                                                              .name ??
                                                          "",
                                                      fontSize: 16.sp,
                                                      fontFamily: "tajawalb",
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              uploadAdsController.picturesUpdate
                                                          .length !=
                                                      0
                                                  ? Container(
                                                      width: Get.width,
                                                      height: 284.h,
                                                      child: Image.network(
                                                        uploadAdsController
                                                            .picturesUpdate[0]
                                                            .image!,
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
                                              // CustomPngImage(
                                              //   imageName: "car_image",
                                              //   width: Get.width,
                                              //   height: 284.h,
                                              // ),
                                              SizedBox(
                                                height: 22.h,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15.w),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      "Truck Details",
                                                      fontSize: 16.sp,
                                                      fontFamily: "tajawalb",
                                                    ),
                                                    SizedBox(
                                                      height: 16.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        CustomText(
                                                          "Brand",
                                                          fontSize: 14.sp,
                                                          color: AppColors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        Spacer(),
                                                        CustomText(
                                                          authController
                                                              .getTruckBrandsSelect
                                                              .value
                                                              .name,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 14.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        CustomText(
                                                          "Truck Model",
                                                          fontSize: 14.sp,
                                                          color: AppColors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        Spacer(),
                                                        CustomText(
                                                          authController
                                                                  .getTruckModelSelect
                                                                  .value
                                                                  .name ??
                                                              "",
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 14.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        CustomText(
                                                          "Production Year",
                                                          fontSize: 14.sp,
                                                          color: AppColors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        Spacer(),
                                                        CustomText(
                                                          uploadAdsController
                                                              .getProductionYearSelect
                                                              .value
                                                              .name
                                                              .toString(),
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 14.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        CustomText(
                                                          "Truck Paint Color",
                                                          fontSize: 14.sp,
                                                          color: AppColors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        Spacer(),
                                                        CustomText(
                                                          authController
                                                              .getColorsSelect
                                                              .value
                                                              .name,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 14.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        CustomText(
                                                          "Condition",
                                                          fontSize: 14.sp,
                                                          color: AppColors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        Spacer(),
                                                        CustomText(
                                                          uploadAdsController
                                                              .condition.value,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 14.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        CustomText(
                                                          "Kilometers",
                                                          fontSize: 14.sp,
                                                          color: AppColors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        Spacer(),
                                                        CustomText(
                                                          uploadAdsController
                                                              .Killometers,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 14.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        CustomText(
                                                          "Price",
                                                          fontSize: 14.sp,
                                                          color: AppColors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        Spacer(),
                                                        CustomText(
                                                          "${uploadAdsController.price} AED",
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 14.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        CustomText(
                                                          "City",
                                                          fontSize: 14.sp,
                                                          color: AppColors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        Spacer(),
                                                        CustomText(
                                                          authController
                                                              .getCitiesSelect
                                                              .value
                                                              .name,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 14.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        CustomText(
                                                          "Address",
                                                          fontSize: 14.sp,
                                                          color: AppColors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        Spacer(),
                                                        CustomText(
                                                          uploadAdsController
                                                              .address,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 27.h,
                                                    ),
                                                    CustomText(
                                                      "Truck Details",
                                                      fontSize: 16.sp,
                                                      fontFamily: "tajawalb",
                                                    ),
                                                    SizedBox(
                                                      height: 14.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        CustomText(
                                                          "Mobile Number",
                                                          fontSize: 14.sp,
                                                          color: AppColors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        Spacer(),
                                                        CustomText(
                                                          uploadAdsController
                                                              .mobile,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                                          color: AppColors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        Spacer(),
                                                        CustomText(
                                                          uploadAdsController
                                                              .whatsapp,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 27.h,
                                                    ),
                                                    CustomText(
                                                      "Truck Description",
                                                      fontSize: 16.sp,
                                                      fontFamily: "tajawalb",
                                                    ),
                                                    SizedBox(
                                                      height: 13.h,
                                                    ),
                                                    CustomText(
                                                      uploadAdsController.desc,
                                                      fontSize: 14.sp,
                                                      color: AppColors.grey,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
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