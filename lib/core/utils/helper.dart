import 'dart:io';
import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/utils/app_imports.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Helper {
  static getAllDataWithoutToken() {}

  static getAllDataWithToken() {}

  static List<Widget> getStarsList(double rate, {double size = 18}) {
    var list = <Widget>[];
    list = List.generate(rate.floor(), (index) {
      return Row(
        children: [
          CustomSvgImage(
              imageName: "star",
              height: size,
              width: size,
              color: Color(0xffFFC107)),
          SizedBox(
            width: 5.w,
          )
        ],
      );
    });
    if (rate - rate.floor() > 0) {
      list.add(Row(
        children: [
          CustomSvgImage(
              imageName: "star",
              height: size,
              width: size,
              color: Color(0xffFFC107)),
          SizedBox(
            width: 5.w,
          )
        ],
      ));
    }
    list.addAll(
        List.generate(5 - rate.floor() - (rate - rate.floor()).ceil(), (index) {
      return Row(
        children: [
          CustomSvgImage(
              imageName: "star",
              height: size,
              width: size,
              color: Color(0xffFFC107)),
          SizedBox(
            width: 5.w,
          )
        ],
      );
    }));
    return list;
  }

  static String limitString(String text, int limit) {
    return text.toString().substring(0, min<int>(limit, text.length)) +
        (text.length > limit ? "..." : '');
  }

  static validation(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return "الحقل مطلوب";
    }
  }

  static getSheetError(String title) {
    return Get.snackbar(
      '',
      '',
      messageText: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            title,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            color: Colors.red,
          ),
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
          Icon(
            Icons.info,
            color: Colors.red,
          ),
        ],
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
    );
  }

  static getSheetSucsses(String title) {
    return Get.snackbar(
      '',
      '',
      messageText: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            title,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            color: AppColors.primaryColor,
          ),
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        ],
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
    );
  }

  static double childAspectRatio(double ratio) {
    return MediaQuery.of(Get.context!).size.width /
        (MediaQuery.of(Get.context!).size.height / ratio);
  }

  static loading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image.asset("assets/images/walking.gif",
        // height: 20.h,
        // )
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                backgroundColor: AppColors.whiteColor,
              ),
            ),
            // SizedBox(
            //   height: 10.h,
            // ),
          ],
        ),
      ],
    );
  }

  static var appRaduis = BorderRadius.circular(15.r);
  // DateTime _selectedDate;

  // TimeOfDay _selectedTime;
  static selectDate(
      BuildContext context, textEditingController, selectedDate) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate != null ? selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext? context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: AppColors.black,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: AppColors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });

    if (newSelectedDate != null) {
      selectedDate = newSelectedDate;
      textEditingController
        ..text = "${selectedDate.toLocal()}".split(' ')[0]
        // DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  static selectTime(
      BuildContext context, textEditingController, selectedTime) async {
    TimeOfDay? newSelectedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime != null ? selectedTime : TimeOfDay.now(),

        // initialDate: ,
        // firstDate: DateTime(2000),
        // lastDate: DateTime(2040),
        builder: (BuildContext? context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: AppColors.black,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: AppColors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });

    if (newSelectedTime != null) {
      final localizations = MaterialLocalizations.of(context);

      selectedTime = newSelectedTime;
      textEditingController
        ..text = "${selectedTime.hour}:${selectedTime.minute}"
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  static selectYear(BuildContext context, selectedDate, textEditingController) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: CustomText(
              "اختر السنة",
            ),
            content: Container(
              // Need to use container to add size constraint.
              width: 300,
              height: 300,
              child: YearPicker(
                firstDate: DateTime(DateTime.now().year - 100, 1),
                lastDate: DateTime(DateTime.now().year + 100, 1),
                initialDate:
                    selectedDate != null ? selectedDate : DateTime.now(),

                // save the selected date to _selectedDate DateTime variable.
                // It's used to set the previous selected date when
                // re-showing the dialog.

                selectedDate: selectedDate,
                onChanged: (DateTime dateTime) {
                  textEditingController..text = "${dateTime.year}";
                  // close the dialog when year is selected.
                  Navigator.pop(context);

                  // Do something with the dateTime selected.
                  // Remember that you need to use dateTime.year to get the year
                },
              ),
            ),
          );
        });
  }

  static showLoading() {
    return BotToast.showCustomLoading(
      toastBuilder: (cancelFunc) {
        return Container(
          height: 60.h,
          width: 60.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r), color: Colors.grey),
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColors.primaryColor,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  static hideLoading() {
    return BotToast.closeAllLoading();
  }

  static Future<File?> imagePickerExample(ImageSource imageSource) async {
    final pickedFile =
        await ImagePicker().pickImage(source: imageSource, imageQuality: 22);

    try {
      var croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile!.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'اقتصاص الصورة',
            toolbarColor: AppColors.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'اقتصاص الصورة',
          )
        ],
      );

      return File(croppedFile!.path);
    } catch (e) {
      return null;
    }
  }

  String replaceEnglishNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], arabic[i]);
    }

    return input;
  }
}
