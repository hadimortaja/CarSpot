import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';

class CustomTextFormField extends StatelessWidget {
  AuthController authController = Get.find();
  final String? topTitle;
  final String? hint;
  final Function? onSaved;
  final Function? validator;
  final TextInputType? textInputType;
  final bool? isPassword;
  final double? height;
  final double? spaceSizeBox;
  final int? maxLines;
  final int? minLines;

  final Widget? prifix;
  final Widget? suffix;

  final bool? center;
  final dynamic initial;
  final Color? topColor;
  final bool? isTime;
  final Function? onTap;
  CustomTextFormField(
      {this.topTitle,
      this.hint,
      this.onSaved,
      this.validator,
      this.textInputType,
      this.isPassword = false,
      this.height,
      this.spaceSizeBox,
      this.maxLines,
      this.prifix,
      this.initial = "",
      this.center = false,
      this.topColor,
      this.isTime = false,
      this.onTap,
      this.suffix,
      this.minLines});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          focusNode: isTime! ? AlwaysDisabledFocusNode() : null,
          onTap: () {
            onTap == null ? '' : onTap!();
          },
          textAlign: center! ? TextAlign.center : TextAlign.start,
          onSaved: (value) => onSaved!(value),
          onChanged: (value) => onSaved!(value),
          validator: (newValue) => validator!(newValue),
          obscureText: isPassword!,
          maxLines: maxLines ?? 1,
          minLines: minLines == null ? 1 : null,
          keyboardType: textInputType ?? TextInputType.text,

          onFieldSubmitted: (value) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          // onTapOutside: (event) {
          //   FocusManager.instance.primaryFocus?.unfocus();
          // },
          onEditingComplete: () {},
          initialValue: initial,
          decoration: InputDecoration(
            prefixIconConstraints:
                BoxConstraints(minHeight: 30.h, minWidth: 30.w),
            prefixIcon: prifix ?? null,
            suffixIcon: suffix ?? null,
            filled: true,
            contentPadding: EdgeInsets.all(14.h),
            suffixIconConstraints:
                BoxConstraints(maxWidth: 55.w, maxHeight: 55.h),
            // isDense: true,
            // isCollapsed: false,

            errorStyle: TextStyle(fontSize: 12.0.sp, fontFamily: "montserrat"),
            hintText: hint?.tr,
            hintStyle: TextStyle(
                color: Color(0xffBFBFBF),
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                fontFamily: "montserrat"),
            fillColor: Colors.transparent,
            border: InputBorder.none,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: Helper.appRaduis,
              borderSide: BorderSide(color: AppColors.red),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: Helper.appRaduis,
              borderSide: BorderSide(
                color: Color(0xffBFBFBF),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: Helper.appRaduis,
              borderSide: BorderSide(
                color: AppColors.black,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: Helper.appRaduis,
              borderSide: BorderSide(color: AppColors.red),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: Helper.appRaduis,
              borderSide: BorderSide(color: AppColors.whiteColor),
            ),
          ),
          style: TextStyle(
            fontFamily: "montserrat",
            fontSize: 15.sp,
            height: height ?? 1.6,
          ),
        )
      ],
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
