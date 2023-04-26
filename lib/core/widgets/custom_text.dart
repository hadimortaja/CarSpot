import 'package:car_rental/core/utils/app_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final TextAlign? textAlign;
  final Color? color;
  final bool? underline;
  final FontWeight? fontWeight;
  final int? maxLines;
  final String? fontFamily;
  final double? letterspacing;

  CustomText(this.text,
      {this.fontSize,
      this.textAlign,
      this.color,
      this.fontWeight,
      this.underline = false,
      this.maxLines,
      this.fontFamily,
      this.letterspacing});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!.tr,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(
        letterSpacing: letterspacing,
        fontWeight: fontWeight ?? FontWeight.bold,
        fontSize: fontSize ?? 22.sp,
        color: color ?? Colors.black,
        fontFamily: fontFamily ?? 'montserrat',
        decoration: underline! ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
