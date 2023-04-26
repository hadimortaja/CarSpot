import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/custom_button.dart';
import 'package:car_rental/core/widgets/custom_text_form_field.dart';
import 'package:car_rental/features/calculator_view/data/data_sources/calculate_data_source.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CalculatorView extends StatefulWidget {
  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  ProfileController profileController = Get.find();

  List<String> titles = ["Prepaid Value".tr, "Without Prepaid".tr];

  String? price, years, rate, prepaid;

  setPrice(String value) {
    this.price = value;
  }

  setYears(String value) {
    this.years = value;
  }

  setRate(String value) {
    this.rate = value;
  }

  setPrepaid(String value) {
    this.prepaid = value;
  }

  final formKey = GlobalKey<FormState>();

  validation(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return 'This field is required*'.tr;
    }
  }

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
                "Calculator",
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
        Form(
          key: formKey,
          child: Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 111.h,
                    width: 111.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor.withOpacity(0.30)),
                    child: Center(
                        child: CustomSvgImage(
                      imageName: "calculator",
                      height: 70.h,
                    )),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomText(
                "Car Price :",
                fontSize: 15.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomTextFormField(
                onSaved: setPrice,
                validator: validation,
                textInputType: TextInputType.number,
              ),
              SizedBox(
                height: 23.h,
              ),
              CustomText(
                "Number of Years :",
                fontSize: 15.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomTextFormField(
                onSaved: setYears,
                validator: validation,
                textInputType: TextInputType.number,
              ),
              SizedBox(
                height: 23.h,
              ),
              CustomText(
                "Interest Rate :",
                fontSize: 15.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomTextFormField(
                onSaved: setRate,
                validator: validation,
                textInputType: TextInputType.number,
              ),
              SizedBox(
                height: 23.h,
              ),

              // Visibility(
              //     visible:profileController.indexSelectCalculator==0,
              //     child: Row(
              //       children: [
              //         CustomTextFormField(
              //
              //         ),
              //       ],
              //     )) ,

              SizedBox(
                width: Get.width,
                child: ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {});
                          profileController.setIndexSelectCalculator(index);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 20.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: profileController
                                                  .indexSelectCalculator ==
                                              index
                                          ? AppColors.primaryColor
                                          : Colors.transparent,
                                      border: Border.all(
                                          color: profileController
                                                      .indexSelectCalculator ==
                                                  index
                                              ? AppColors.primaryColor
                                              : AppColors.black)),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CustomText(
                                  titles[index],
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      profileController.indexSelectCalculator ==
                                              index
                                          ? AppColors.black
                                          : AppColors.grey,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              profileController.indexSelectCalculator == 0
                  ? CustomTextFormField(
                      onSaved: setPrepaid,
                      textInputType: TextInputType.number,
                    )
                  : SizedBox(),
              SizedBox(
                height: 15.h,
              ),
              CustomButton(
                onTap: () {
                  // if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  calculateDataSource(
                    price: price,
                    rate: rate,
                    years: years,
                    prepaid: profileController.indexSelectCalculator == 1
                        ? "0"
                        : prepaid,
                  );
                  // }
                },
                btnColor: AppColors.primaryColor,
                borderColor: AppColors.primaryColor,
                title: "Calculate",
                width: Get.width.w,
                height: 59.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(() => homeController.getCalculateData.value.code == null
                  ? SizedBox()
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              "Monthly Installment",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            CustomText(
                              homeController.getCalculateData.value.data
                                  .toString(),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              "Total Yearly Installment",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            CustomText(
                              (num.parse(homeController
                                          .getCalculateData.value.data!) *
                                      12)
                                  .toString(),
                              // num.parse()homeController
                              //             .getCalculateData.value.data )*
                              //         12

                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ],
                    )),
              SizedBox(
                height: 50.h,
              ),
            ]),
          )),
        )
      ]),
    );
  }
}
