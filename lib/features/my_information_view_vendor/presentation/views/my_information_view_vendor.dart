import 'dart:convert';
import 'dart:math';

import 'package:car_rental/core/controllers/app_controller.dart';
import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/cached_network_image.dart';
import 'package:car_rental/core/widgets/choose_gellery_or_camera_sheet.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/core/widgets/custom_text_form_field.dart';
import 'package:car_rental/features/add_working_time_view/presentation/views/add_working_time_view.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:car_rental/features/my_information_view_vendor/data/data_sources/set_image_data_source.dart';
import 'package:car_rental/features/my_information_view_vendor/data/data_sources/set_profile_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

import '../../../choose_gender_view/presentation/views/choose_gender_view.dart';

class MyInformationVendorView extends StatelessWidget {
  ProfileController profileController = Get.find();
  final formKey = GlobalKey<FormState>();
  validation(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return 'This field is required*'.tr;
    }
  }

  String? name, email, description, address;
  setName(String name) {
    this.name = name;
  }

  setEmail(String email) {
    this.email = email;
  }

  setDescription(String description) {
    this.description = description;
  }

  setAddress(String address) {
    this.address = address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(children: [
        SizedBox(
          height: 60.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                "Basic Information",
                fontSize: 22.sp,
                fontFamily: "tajawalb",
              ),
              GestureDetector(
                onTap: () async {
                  // formKey.currentState!.save();

                  List indexs = [];
                  List phones = [];
                  List phonesApi = [];
                  for (int i = 0;
                      i < profileController.phonesEdit.length;
                      i++) {
                    if (!indexs.contains(profileController.phonesEdit.reversed
                        .toList()[i]['index'])) {
                      indexs.add(profileController.phonesEdit.reversed
                          .toList()[i]['index']);
                      phones.add(profileController.phonesEdit.reversed
                          .toList()[i]['phone']);
                    }
                  }

                  for (int i = 0; i < phones.reversed.toList().length; i++) {
                    phonesApi.add(
                        {'\"phone\"': '\"${phones.reversed.toList()[i]}\"'});
                  }
                  print('phones $phonesApi');
                  if (profileController.profileImage != null)
                    setImageDataSource();
                  await setProfileDataSource(
                    name: name ??
                        profileController
                            .getVendorProfileData.value.data!.name!,
                    description: description ??
                        profileController
                            .getVendorProfileData.value.data!.description!,
                    email: email ??
                        profileController
                            .getVendorProfileData.value.data!.email!,
                    address: address ??
                        profileController
                            .getVendorProfileData.value.data!.address!,
                    phones: phonesApi.toString(),
                  );
                  // print("profileController.phonesEdit2 = ${profileController.phonesEdit.toSet().toList()}");
                  print("phones = $phones");
                  print("name = $name");
                  print("email = $email");
                  print("description = $description");
                  print("address = $address");
                },
                child: CustomText(
                  "Save",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          return profileController.getVendorProfileData.value.code == null
              ? Helper.loading()
              : GetBuilder<ProfileController>(
                  init: ProfileController(),
                  id: "image",
                  builder: (controller) {
                    return Expanded(
                      child: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 29.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(15.r)),
                                          ),
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) {
                                            return ChooseCameraOrGellerySheet(
                                              onTapCamera: () {
                                                controller.chooseImage(
                                                    ImageSource.camera);
                                              },
                                              onTapGallery: () {
                                                controller.chooseImage(
                                                    ImageSource.gallery);
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          controller.profileImage == null
                                              ? Container(
                                                  width: 111.w,
                                                  height: 111.h,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors.whiteColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: const Color(
                                                                0xff000000)
                                                            .withOpacity(0.23),
                                                        offset: Offset(0, 3),
                                                        blurRadius: 6,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Center(
                                                    child: CachedNetworkImageShare(
                                                        profileController
                                                                .getVendorProfileData
                                                                .value
                                                                .data!
                                                                .photo ??
                                                            "",
                                                        111,
                                                        111,
                                                        0),
                                                  ))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.r),
                                                  child: CircleAvatar(
                                                    radius: 60.r,
                                                    child: Image.file(
                                                      controller.profileImage!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                          Positioned(
                                            bottom: 0.h,
                                            right: 10.w,
                                            child: Container(
                                              width: 28.w,
                                              height: 28.h,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.whiteColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0xff000000)
                                                            .withOpacity(0.23),
                                                    offset: Offset(0, 3),
                                                    blurRadius: 6,
                                                  ),
                                                ],
                                              ),
                                              child: Center(
                                                  child: CustomSvgImage(
                                                imageName: "Icon awesome-pen",
                                                color: AppColors.primaryColor,
                                                height: 12.h,
                                                width: 12.w,
                                              )),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                    // CustomPngImage(
                                    //   imageName: controller.gender == "Male"
                                    //       ? "male_image"
                                    //       : "female_image",
                                    //   height: 111.h,
                                    //   width: 111.w,
                                    // )
                                  ],
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                CustomTextFormField(
                                  hint: "name",
                                  onSaved: setName,
                                  // validator: validation,
                                  initial: profileController
                                      .getVendorProfileData.value.data!.name!,
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                CustomTextFormField(
                                  hint: "Email Address",
                                  onSaved: setEmail,
                                  // validator: validation,
                                  textInputType: TextInputType.emailAddress,
                                  initial: profileController
                                      .getVendorProfileData.value.data!.email!,
                                ),
                                SizedBox(
                                  width: Get.width,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: profileController
                                          .getVendorProfileData
                                          .value
                                          .data!
                                          .phones!
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            CustomTextFormField(
                                              hint: "Phone Number 1",
                                              initial: profileController
                                                          .phonesEdit![index]
                                                      ['phone'] ??
                                                  "",
                                              onSaved: (String value) {
                                                profileController.phonesEdit
                                                    .add({
                                                  "index": profileController
                                                      .phonesEdit![index]
                                                          ['index']
                                                      .toString(),
                                                  "phone": value,
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              height: 30.h,
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                                CustomTextFormField(
                                  hint: "Address",
                                  initial: profileController
                                          .getVendorProfileData
                                          .value
                                          .data!
                                          .address ??
                                      "",
                                  onSaved: setAddress,
                                  validator: validation,
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
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
                                  onSaved: setDescription,
                                  // validator: validation,
                                  hint:
                                      """Lorem ipsum dolor sit amet. Nam perferendis
                       ipsum sit temporibus nisi eum placeat sunt est
                       dolor maxime sed libero odit""",
                                  maxLines: 4,
                                  initial: profileController
                                              .getVendorProfileData
                                              .value
                                              .data!
                                              .description ==
                                          null
                                      ? ""
                                      : profileController.getVendorProfileData
                                          .value.data!.description!,
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => AddWorkingTimeView());
                                    // showModalBottomSheet(
                                    //   isDismissible: false,
                                    //   context: context,
                                    //   builder: (context) {
                                    //     return Column(
                                    //       mainAxisSize: MainAxisSize.min,
                                    //       children: [
                                    //         SizedBox(
                                    //           height: 16.h,
                                    //         ),
                                    //         Padding(
                                    //           padding: EdgeInsets.symmetric(
                                    //               horizontal: 16.w),
                                    //           child: Row(
                                    //             mainAxisAlignment:
                                    //                 MainAxisAlignment
                                    //                     .spaceBetween,
                                    //             children: [
                                    //               GestureDetector(
                                    //                 onTap: () {
                                    //                   Get.back();
                                    //                 },
                                    //                 child: CustomText(
                                    //                   "Cancel",
                                    //                   fontSize: 16.w,
                                    //                   color: AppColors
                                    //                       .primaryColor,
                                    //                 ),
                                    //               ),
                                    //               CustomText(
                                    //                 "Set Time",
                                    //                 fontSize: 16.w,
                                    //               ),
                                    //               CustomText(
                                    //                 "Done",
                                    //                 fontSize: 16.w,
                                    //                 color:
                                    //                     AppColors.primaryColor,
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //         Container(
                                    //           height: 200.h,
                                    //           child: CupertinoDatePicker(
                                    //               mode: CupertinoDatePickerMode
                                    //                   .time,
                                    //               onDateTimeChanged: (value) {},
                                    //               initialDateTime:
                                    //                   DateTime.now(),
                                    //               minimumYear: 2019,
                                    //               maximumYear: 2030,
                                    //               minuteInterval: 1),
                                    //         ),
                                    //       ],
                                    //     );
                                    //   },
                                    // );
                                  },
                                  child: Container(
                                    width: Get.width,
                                    height: 55.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xffBFBFBF)),
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(children: [
                                            CustomText(
                                              "Working Time",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.grey,
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 12.r,
                                            )
                                          ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 36.h,
                                ),
                                CustomText(
                                  "Delete this account",
                                  fontSize: 22.sp,
                                  fontFamily: "tajawalb",
                                ),
                                SizedBox(
                                  height: 36.h,
                                ),
                                CustomButton(
                                  onTap: () {
                                    Get.dialog(Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 205.w,
                                          height: 264.h,
                                          decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(25.r)),
                                          child: Column(children: [
                                            SizedBox(
                                              height: 30.h,
                                            ),
                                            Container(
                                                height: 55.h,
                                                width: 55.w,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors
                                                        .primaryColor
                                                        .withOpacity(0.20)),
                                                child: Center(
                                                  child: Container(
                                                    height: 37.h,
                                                    width: 37.w,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColors
                                                            .primaryColor),
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.close,
                                                      color:
                                                          AppColors.whiteColor,
                                                    )),
                                                  ),
                                                )),
                                            SizedBox(
                                              height: 26.h,
                                            ),
                                            CustomText(
                                              "Warning !",
                                              fontSize: 22.sp,
                                              fontFamily: "tajawalb",
                                            ),
                                            CustomText(
                                              "Are you sure you want\nDelete your account ?",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.grey,
                                              textAlign: TextAlign.center,
                                            ),
                                            Spacer(),
                                            Divider(),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 28.w,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.back();
                                                      Get.back();

                                                      SPHelper.spHelper
                                                          .setToken("");
                                                      Get.offAll(
                                                          () => MainView());
                                                    },
                                                    child: CustomText(
                                                      "Yes",
                                                      fontSize: 22.sp,
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontFamily: "tajawalb",
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 0.09.w,
                                                    height: 50.h,
                                                    decoration: BoxDecoration(
                                                        color: AppColors.grey),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    child: CustomText(
                                                      "No",
                                                      fontSize: 22.sp,
                                                      fontFamily: "tajawalb",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ]),
                                        ),
                                      ],
                                    ));
                                  },
                                  width: Get.width,
                                  height: 59.h,
                                  borderColor: AppColors.primaryColor,
                                  btnColor: Colors.white,
                                  title: "Yes, Delete my account",
                                  txtColor: AppColors.primaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                SizedBox(
                                  height: 36.h,
                                ),
                              ],
                            )),
                      ),
                    );
                  });
        })
      ]),
    );
  }
}
