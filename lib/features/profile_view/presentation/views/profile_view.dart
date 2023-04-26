import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/controllers/app_controller.dart';
import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/widgets/cached_network_image.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/features/calculator_view/data/models/calculate_model.dart';
import 'package:car_rental/features/calculator_view/presentation/views/calculator_view.dart';
import 'package:car_rental/features/choose_language_view/presentation/views/choose_language_view.dart';
import 'package:car_rental/features/faqs_view/data/data_sources/faqs_data_source.dart';
import 'package:car_rental/features/faqs_view/presentation/views/faqs_view.dart';
import 'package:car_rental/features/help_view/presentation/views/help_view.dart';
import 'package:car_rental/features/my_ads_view/data/data_sources/my_ads_data_source.dart';
import 'package:car_rental/features/my_information_view_user/presentation/views/my_information_view.dart';
import 'package:car_rental/features/my_information_view_vendor/presentation/views/my_information_view_vendor.dart';
import 'package:car_rental/features/my_profile_view/presentation/views/my_profile_view.dart';
import 'package:car_rental/features/privacy_policy_view/data/data_sources/settings_data_source.dart';
import 'package:car_rental/features/privacy_policy_view/presentation/views/privacy_policy_view.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_vendor_profile_data_source.dart';
import 'package:car_rental/features/profile_view/presentation/widgets/profile_widget.dart';
import 'package:car_rental/features/reset_password_view/presentation/views/reset_password_view.dart';
import 'package:car_rental/features/signin_view/presentation/views/signin_view.dart';
import 'package:car_rental/features/sold_out_view/data/data_sources/get_sold_out_data_source.dart';
import 'package:car_rental/features/sold_out_view/presentation/views/sold_out_view.dart';
import 'package:car_rental/features/wishlist_view/data/data_sources/wishlist_data_source.dart';
import 'package:car_rental/features/wishlist_view/presentation/views/wishlist_view.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // String token = SPHelper.spHelper.getToken()!;
  ProfileController profileController = Get.find();
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<AppController>(
            init: AppController(),
            builder: (controller) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(children: [
                  SizedBox(
                    height: 90.h,
                  ),
                  Obx(() {
                    return profileController.getProfileData.value.code == null
                        ? SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SPHelper.spHelper.getToken() == "" ||
                                      SPHelper.spHelper.getToken() == null
                                  ? CustomSvgImage(
                                      imageName: "person_circle",
                                      height: 111.h,
                                      width: 111.w,
                                    )
                                  : SPHelper.spHelper.getType() == "0"
                                      ? CustomPngImage(
                                          imageName: controller.indexGender == 0
                                              ? "male_image"
                                              : "female_image",
                                          height: 111.h,
                                          width: 111.w,
                                        )
                                      : CachedNetworkImageShare(
                                          profileController.getProfileData.value
                                                  .data!.photo ??
                                              "",
                                          111,
                                          111,
                                          0)
                            ],
                          );
                  }),
                  SizedBox(
                    height: 20.h,
                  ),
                  SPHelper.spHelper.getToken() == "" ||
                          SPHelper.spHelper.getToken() == null
                      ? CustomText(
                          "@Guest",
                          fontSize: 24.sp,
                          fontFamily: "tajawalb",
                          color: AppColors.grey,
                        )
                      : Obx(
                          () => profileController.getProfileData.value.code ==
                                  null
                              ? SizedBox()
                              : CustomText(
                                  "${profileController.getProfileData.value.data!.name}",
                                  fontSize: 24.sp,
                                  fontFamily: "tajawalb",
                                ),
                        ),
                  SizedBox(
                    height: 30.h,
                  ),
                  SPHelper.spHelper.getType() == "0"
                      ? SizedBox()
                      : ProfileWidget(
                          onTap: () {
                            if (SPHelper.spHelper.getToken() == "" ||
                                SPHelper.spHelper.getToken() == null) {
                            } else {
                              myAdsDataSource(1, true);
                              getVendorProfileDataSource();
                              Get.to(() => MyProfileView());
                            }
                          },
                          title: "My Profile",
                          imageName: "my_profile_icon",
                          titleColor: SPHelper.spHelper.getToken() == "" ||
                                  SPHelper.spHelper.getToken() == null
                              ? AppColors.grey
                              : AppColors.black,
                          iconColor: SPHelper.spHelper.getToken() == "" ||
                                  SPHelper.spHelper.getToken() == null
                              ? AppColors.grey
                              : AppColors.primaryColor,
                        ),
                  ProfileWidget(
                    onTap: () {
                      if (SPHelper.spHelper.getToken() == "" ||
                          SPHelper.spHelper.getToken() == null) {
                      } else {
                        print(SPHelper.spHelper.getType());
                        if (SPHelper.spHelper.getType() == "0") {
                          Get.to(() => MyInformationView());
                        } else {
                          profileController.phonesEdit.clear();

                          getVendorProfileDataSource();
                          profileController.cleanImage();
                          for (int i = 0;
                              i <
                                  profileController.getVendorProfileData.value
                                      .data!.phones!.length;
                              i++) {
                            profileController.phonesEdit.add({
                              "index": i.toString(),
                              "phone": profileController.getVendorProfileData
                                  .value.data!.phones![i].number!,
                            });
                          }
                          Get.to(() => MyInformationVendorView());
                        }
                      }
                    },
                    title: "My Information",
                    imageName: "my_information_icon",
                    titleColor: SPHelper.spHelper.getToken() == "" ||
                            SPHelper.spHelper.getToken() == null
                        ? AppColors.grey
                        : AppColors.black,
                    iconColor: SPHelper.spHelper.getToken() == "" ||
                            SPHelper.spHelper.getToken() == null
                        ? AppColors.grey
                        : AppColors.primaryColor,
                  ),
                  ProfileWidget(
                    onTap: () {
                      if (SPHelper.spHelper.getToken() == "" ||
                          SPHelper.spHelper.getToken() == null) {
                      } else {
                        getWishlistDataSource();
                        Get.to(() => WishlistView());
                      }
                    },
                    title: "Wishlist",
                    imageName: "wishlist_icon",
                    titleColor: SPHelper.spHelper.getToken() == "" ||
                            SPHelper.spHelper.getToken() == null
                        ? AppColors.grey
                        : AppColors.black,
                    iconColor: SPHelper.spHelper.getToken() == "" ||
                            SPHelper.spHelper.getToken() == null
                        ? AppColors.grey
                        : AppColors.primaryColor,
                  ),
                  ProfileWidget(
                    onTap: () {
                      settingsDataSource();
                      Get.to(() => PrivacyPolicyView());
                    },
                    title: "Privacy & Policy",
                    imageName: "privacy_icon",
                  ),
                  ProfileWidget(
                    onTap: () {
                      Get.to(() => HelpView());
                    },
                    title: "Help & Support",
                    imageName: "help_icon",
                  ),
                  ProfileWidget(
                    onTap: () {
                      faqsDataSource();
                      Get.to(() => FaqsView());
                    },
                    title: "FAQ",
                    imageName: "faq_icon",
                  ),
                  ProfileWidget(
                    onTap: () {
                      getSoldOutDataSource();
                      Get.to(() => SoldOutView());
                    },
                    title: "Sold Out",
                    imageName: "soldout_icon",
                  ),
                  ProfileWidget(
                    onTap: () {
                      if (SPHelper.spHelper.getToken() == "" ||
                          SPHelper.spHelper.getToken() == null) {
                      } else {
                        homeController.getCalculateData.value =
                            CalculateModel();
                        Get.to(() => CalculatorView());
                      }
                    },
                    title: "Calculator",
                    imageName: "calculator_icon",
                    titleColor: SPHelper.spHelper.getToken() == "" ||
                            SPHelper.spHelper.getToken() == null
                        ? AppColors.grey
                        : AppColors.black,
                    iconColor: SPHelper.spHelper.getToken() == "" ||
                            SPHelper.spHelper.getToken() == null
                        ? AppColors.grey
                        : AppColors.primaryColor,
                  ),
                  ProfileWidget(
                    onTap: () {
                      Get.to(() => ChooseLanguageView());
                    },
                    title: "Language",
                    imageName: "language_icon",
                  ),
                  ProfileWidget(
                    onTap: () {
                      if (SPHelper.spHelper.getToken() == "" ||
                          SPHelper.spHelper.getToken() == null) {
                      } else {
                        Get.to(() => ResetPasswordView());
                      }
                    },
                    title: "Reset Password",
                    imageName: "reset_password_icon",
                    titleColor: SPHelper.spHelper.getToken() == "" ||
                            SPHelper.spHelper.getToken() == null
                        ? AppColors.grey
                        : AppColors.black,
                    iconColor: SPHelper.spHelper.getToken() == "" ||
                            SPHelper.spHelper.getToken() == null
                        ? AppColors.grey
                        : AppColors.primaryColor,
                  ),
                  ProfileWidget(
                    onTap: () {
                      if (SPHelper.spHelper.getToken() == null ||
                          SPHelper.spHelper.getToken() == "") {
                        Get.to(() => SignInView());
                      } else {
                        Get.dialog(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 205.w,
                              height: 264.h,
                              decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(25.r)),
                              child: Column(children: [
                                SizedBox(
                                  height: 30.h,
                                ),
                                Container(
                                    height: 55.h,
                                    width: 55.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryColor
                                            .withOpacity(0.20)),
                                    child: Center(
                                      child: Container(
                                        height: 37.h,
                                        width: 37.w,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primaryColor),
                                        child: Center(
                                            child: Icon(
                                          Icons.close,
                                          color: AppColors.whiteColor,
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
                                  "Are you sure you want\nLogout ?",
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
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          // controller.setIndexScreen(0);

                                          SPHelper.spHelper.setToken("");
                                          SPHelper.spHelper.setType("");
                                          Get.offAll(() => SignInView());
                                          BotToast.showText(
                                              text: "logged out successfully");
                                        },
                                        child: CustomText(
                                          "Yes",
                                          fontSize: 22.sp,
                                          color: AppColors.primaryColor,
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
                      }
                    },
                    title: SPHelper.spHelper.getToken() == "" ||
                            SPHelper.spHelper.getToken() == null
                        ? "Sign In"
                        : "Sign Out",
                    imageName: SPHelper.spHelper.getToken() == "" ||
                            SPHelper.spHelper.getToken() == null
                        ? "login_icon"
                        : "logout_icon",
                  ),
                ]),
              );
            }));
  }
}

//  Center( 
//           child: CustomButton(
//         btnColor: AppColors.primaryColor,
//         onTap: () {
//           if (SPHelper.spHelper.getToken() == "" ||
//               SPHelper.spHelper.getToken() == null) {
//             Get.to(() => SignInView());
//           } else {
//             appController.setIndexScreen(0);

//             SPHelper.spHelper.setToken("");
//             BotToast.showText(text: "logged out successfully");
//           }
//         },
//         title: SPHelper.spHelper.getToken() == "" ||
//                 SPHelper.spHelper.getToken() == null
//             ? "Sign In"
//             : "Log Out",
//       )),