import 'package:car_rental/core/utils/app_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
  
class IndicatorAds extends StatelessWidget {
  final int? numPages, currentPage;

  IndicatorAds({this.numPages, this.currentPage});

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < numPages!; i++) {
      list.add(i == currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.0.w),
      height: 8.h,
      width: isActive ? 18.w : 8.w,
      decoration: BoxDecoration(
        color:
            isActive ? AppColors.primaryColor : Colors.grey.withOpacity(0.23),
        borderRadius: BorderRadius.circular(isActive ? 200.r : 400.r),
        border: Border.all(width: 1.0.w, color: const Color(0x24fdcd1e)),
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
