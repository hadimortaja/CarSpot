import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/widgets/customDropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
    
class CustomDropText extends StatelessWidget {
  final String? titleHint;
  final String? topTitle;

  final String? initValue;
  final List<dynamic>? itemList;
  final Function(int x, int y) onChangeFunction;

  const CustomDropText(
      {this.titleHint,
      this.topTitle,
      this.initValue,
      this.itemList,
      required this.onChangeFunction});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          topTitle,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          width: Get.width,
          height: 50.h,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
          ),
          child: CustomDropdown<int>(
            leadingIcon: true,
            initValue: initValue,
            onChange: onChangeFunction,

            child: CustomText(
              titleHint,
              fontSize: 16.sp,
              color: AppColors.grey,
              fontWeight: FontWeight.w400,
            ),
            // onChange: onChangeFunction,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
            ),
            dropdownButtonStyle: DropdownButtonStyle(
              width: 170.w,

              // height: 40.h,
              // elevation: 1,
              backgroundColor: Colors.transparent,
              // primaryColor: Colors.white,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            dropdownStyle: DropdownStyle(
              borderRadius: BorderRadius.circular(0),

              elevation: 10,

              color: Colors.white,

              // width: 180.w,
              // padding: EdgeInsets.all(5.h),
            ),
            items: itemList!
                // .asMap()
                // .entries
                .map(
                  (item) => DropdownItem<int>(
                    value: item['id'],
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                      child: Row(
                        children: [
                          CustomText(
                            item['title'],
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
