import 'package:car_rental/core/utils/app_imports.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChooseCameraOrGellerySheet extends StatelessWidget {
  Function()? onTapCamera;
  Function()? onTapGallery;
  ChooseCameraOrGellerySheet({this.onTapCamera, this.onTapGallery});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
          height: 34.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.w),
          child: Row(
            children: [
              GestureDetector(
                onTap: onTapCamera,
                child: Column(
                  children: [
                    CustomSvgImage(
                      imageName: "Icon awesome-camera",
                      height: 31.h,
                      width: 36.w,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomText(
                      "Camera",
                      fontSize: 15.sp,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: onTapGallery,
                child: Column(
                  children: [
                    CustomSvgImage(
                      imageName: "Icon material-perm-media",
                      height: 31.h,
                      width: 36.w,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomText(
                      "Media Library",
                      fontSize: 15.sp,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 34.h,
        ),
      ]),
    );
  }
}
