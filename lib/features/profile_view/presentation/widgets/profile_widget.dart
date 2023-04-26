import 'package:car_rental/core/utils/app_imports.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileWidget extends StatelessWidget {
  final String? title, imageName;
  final Function()? onTap;
  final Color? titleColor, iconColor;
  ProfileWidget(
      {this.title,
      this.imageName,
      this.onTap,
      this.titleColor,
      this.iconColor});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              CustomSvgImage(
                imageName: imageName,
                width: 22.w,
                height: 22.h,
                color: iconColor,
              ),
              SizedBox(
                width: 13.w,
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: CustomText(
                  title,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400,
                  color: titleColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Divider(),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
