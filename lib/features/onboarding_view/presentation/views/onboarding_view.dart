import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/value/animate_do.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/features/home_view/data/data_sources/most_popular_data_source.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:car_rental/features/signin_view/presentation/views/signin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class IndicatorOnboarding extends StatelessWidget {
  final int numPages, currentPage;

  IndicatorOnboarding({required this.numPages, required this.currentPage});

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < numPages; i++) {
      list.add(i == currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      // height: ScreenUtil().setHeight(10),
      // width: ScreenUtil().setWidth(10),
      height: 4.h,
      width: 32.w,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : Color(0xffEAEAEA0),
        borderRadius: BorderRadius.all(
          Radius.circular(5.r),
        ),
        // border: Border.all(
        //   color: AppColors.primaryColor,
        //   width: ScreenUtil().setWidth(1),
        // )و
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildPageIndicator(),
    );
  }
}

class OnBoardingScreen extends StatefulWidget {
  bool? isFirst;

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final int _numPages = 4;

  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;
  List<String> topImages = ["1", "2", "3", "4"];

  List<String> images = ["on1", "on2", "on3", "on4"];
  List<String> titles = [
    "Find Your Dream Car".tr,
    "Find Your Truck".tr,
    "Find Your Favorite Number".tr,
    "Find Service For Cars".tr
  ];
  List<String> des = [
    "Find the car of your dreams from the\nworld's largest car market".tr,
    "Find the truck of your dreams from the\nworld's largest trucks market".tr,
    "Through us, you will get the best\nNumber for your vehicles".tr,
    "Find All car parts for your car\nand choose from our services".tr,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          width: Get.width,
          height: 108.h,
          child: Center(
            child: CustomButton(
              title: "Get Started",
              txtColor: AppColors.whiteColor,
              onTap: () {
                if (_currentPage != _numPages - 1) {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                } else {
                  SPHelper.spHelper.setViewOnBarding(true);
homeMostPopularDataSource();
                  Get.offAll(() => MainView());
                }
              },
            ),
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        body: Column(children: [
          SizedBox(
            height: 100.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GestureDetector(
              onTap: () {
                SPHelper.spHelper.setViewOnBarding(true);

                Get.offAll(() => MainView());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
                    "Skip",
                    fontSize: 16.sp,
                    color: AppColors.grey,
                  )
                ],
              ),
            ),
          ),

          Expanded(
            child: PageView.builder(
              
              physics: ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    FadeIn(
                      child: CustomSvgImage(
                        height: 170.h,
                        width: 288.w,
                        imageName: topImages[index],
                      ),
                    ),
                    Container(
                        width: Get.width,
                        height: 237.h,
                        child: Center(
                            child: FadeInRight(
                          duration: Duration(seconds: 1),
                          child:
                              Image.asset("assets/images/${images[index]}.png"),
                        ))),
                    // CustomPngImage(
                    //   height: 110.h,
                    //   width: 219.w,
                    //   imageName: images[index],
                    // ),
                    // SizedBox(
                    //   height: 42.h,
                    // ),
                    FadeIn(
                      duration: Duration(seconds: 2),
                      child: CustomText(
                        titles[index],
                        fontSize: 27.sp,
                        fontFamily: 'tajawalb',
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomText(
                      des[index],
                      textAlign: TextAlign.center,
                      fontSize: 15.sp,
                      color: Color(0xffBFBFBF),
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                );
              },
              itemCount: 4,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40.h),
            child: IndicatorOnboarding(
              numPages: _numPages,
              currentPage: _currentPage,
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //     left: 20.w,
          //     right: 20.w,
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       GestureDetector(
          //         onTap: () {

          //         },
          //         child: Container(
          //             width: 100.w,
          //             height: 38.h,
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(20.w),
          //                 color: AppColors.primaryColor),
          //             child: Center(
          //               child: CustomText(
          //                 _currentPage != _numPages - 1 ? 'التالي' : 'إنطلق',
          //                 color: Colors.white,
          //                 fontSize: 16.sp,
          //               ),
          //             )),
          //       ),
          //     ],
          //   ),
          // )
        ]));
  }
}
