import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/features/add_working_time_view/data/data_sources/set_work_time_data_source.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_vendor_profile_data_source.dart';

class AddWorkingTimeView extends StatefulWidget {
  @override
  State<AddWorkingTimeView> createState() => _AddWorkingTimeViewState();
}

selectTime(
    BuildContext context, Function(String) onChange, selectedTime) async {
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

    String text =
        "${selectedTime.hour.toString().padLeft(2, "0")}:${selectedTime.minute.toString().padLeft(2, "0")}";
    print(text);
    onChange(text);
  }
}

class _AddWorkingTimeViewState extends State<AddWorkingTimeView> {
  ProfileController profileController = Get.find();
  TextEditingController fromMonday = TextEditingController();

  TextEditingController toMonday = TextEditingController();

  TimeOfDay? selectedTimeFromMonday;

  TimeOfDay? selectedTime1ToMonday;

  TextEditingController fromTuesday = TextEditingController();

  TextEditingController toTuesday = TextEditingController();

  TimeOfDay? selectedTimeFromTuesday;

  TimeOfDay? selectedTimeToTuesday;

  TextEditingController fromWednesday = TextEditingController();

  TextEditingController toWednesday = TextEditingController();

  TimeOfDay? selectedTimeFromWednesday;

  TimeOfDay? selectedTimetoWednesday;

  TextEditingController fromThursday = TextEditingController();

  TextEditingController toThursday = TextEditingController();

  TimeOfDay? selectedTimeFromThursday;

  TimeOfDay? selectedTimetoThursday;

  TextEditingController fromFriday = TextEditingController();

  TextEditingController toFriday = TextEditingController();

  TimeOfDay? selectedTimeFromFriday;

  TimeOfDay? selectedTimetoFriday;

  TextEditingController fromSaturday = TextEditingController();

  TextEditingController toSaturday = TextEditingController();

  TimeOfDay? selectedTimeFromSaturday;

  TimeOfDay? selectedTimetoSaturday;

  TextEditingController fromSunday = TextEditingController();

  TextEditingController toSunday = TextEditingController();

  TimeOfDay? selectedTimeFromSunday;

  TimeOfDay? selectedTimetoSunday;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: Get.width,
            height: 120.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.primaryColor,
                          )),
                      CustomText(
                        "Working Time",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      GestureDetector(
                        onTap: () {
//                       if(fromSaturday.text==""||toSaturday.text==""||fromSunday.text==""||toSunday.text==""||fromMonday.text==""||toMonday.text==""||fromTuesday.text==""||toTuesday.text==""||fromWednesday.text==""||toWednesday.text==""||fromThursday.text==""||toThursday.text==""||fromFriday.text==""||toFriday.text==""){
// BotToast.showText(text: "Please Add All Times",
// contentColor: AppColors.primaryColor
// );
//                       }else{
                          String date = [
                            {
                              '\"day\"': '\"saterday\"',
                              '\"from\"':
                                  '\"${fromSaturday.text == "" ? profileController.getVendorProfileData.value.data!.vendor!.workTime![0].from : fromSaturday.text}\"',
                              '\"to\"':
                                  '\"${toSaturday.text == "" ? profileController.getVendorProfileData.value.data!.vendor!.workTime![0].to : toSaturday.text}\"'
                            },
                            {
                              '\"day\"': '\"Sunday\"',
                              '\"from\"':
                                  '\"${fromSunday.text == "" ? profileController.getVendorProfileData.value.data!.vendor!.workTime![1].from : fromSunday.text}\"',
                              '\"to\"':
                                  '\"${toSunday.text == "" ? profileController.getVendorProfileData.value.data!.vendor!.workTime![1].to : toSunday.text}\"'
                            },
                            {
                              '\"day\"': '\"Monday\"',
                              '\"from\"':
                                  '\"${fromMonday.text == "" ? profileController.getVendorProfileData.value.data!.vendor!.workTime![2].from : fromMonday.text}\"',
                              '\"to\"':
                                  '\"${toMonday.text == "" ? profileController.getVendorProfileData.value.data!.vendor!.workTime![2].to : toMonday.text}\"'
                            },
                            {
                              '\"day\"': '\"Tuseday\"',
                              '\"from\"':
                                  '\"${fromTuesday.text == "" ? profileController.getVendorProfileData.value.data!.vendor!.workTime![3].from : fromTuesday.text}\"',
                              '\"to\"':
                                  '\"${toTuesday.text == "" ? profileController.getVendorProfileData.value.data!.vendor!.workTime![3].to : toTuesday.text}\"'
                            },
                            {
                              '\"day\"': '\"Wednsday\"',
                              '\"from\"':
                                  '\"${fromWednesday.text == "" ? profileController.getVendorProfileData.value.data!.vendor!.workTime![4].from : fromWednesday.text}\"',
                              '\"to\"':
                                  '\"${toWednesday.text == "" ? profileController.getVendorProfileData.value.data!.vendor!.workTime![4].to : toWednesday.text}\"'
                            },
                            {
                              '\"day\"': '\"Thursday\"',
                              '\"from\"':
                                  '\"${fromThursday.text == "" ? profileController.getVendorProfileData.value.data!.vendor!.workTime![5].from : fromThursday.text}\"',
                              '\"to\"':
                                  '\"${toThursday.text == "" ? profileController.getVendorProfileData.value.data!.vendor!.workTime![5].to : toThursday.text}\"'
                            },
                            {
                              '\"day\"': '\"Friday\"',
                              '\"from\"':
                                  '\"${fromFriday.text == "" ? profileController.getVendorProfileData.value.data!.vendor!.workTime![6].from : fromFriday.text}\"',
                              '\"to\"':
                                  '\"${toFriday.text == "" ? profileController.getVendorProfileData.value.data!.vendor!.workTime![6].to : toFriday.text}\"'
                            }
                          ].toString();

                          log(date);
                          setWorkTimeDataSource(work_times: date);
                          getVendorProfileDataSource();
                          // }
                        },
                        child: CustomText(
                          "Save",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      "Monday      ",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectTime(context, (value) {
                          setState(() {
                            fromMonday = TextEditingController(text: value);
                          });
                        }, selectedTimeFromMonday);
                      },
                      child: CustomText(
                        fromMonday.text == ""
                            ? profileController.getVendorProfileData.value.data!
                                .vendor!.workTime![2].from
                            : fromMonday.text,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: fromMonday.text != ""
                            ? AppColors.primaryColor
                            : AppColors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectTime(context, (value) {
                          setState(() {
                            toMonday = TextEditingController(text: value);
                          });
                        }, selectedTime1ToMonday);
                      },
                      child: CustomText(
                        toMonday.text == ""
                            ? profileController.getVendorProfileData.value.data!
                                .vendor!.workTime![2].to
                            : toMonday.text,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: toMonday.text != ""
                            ? AppColors.primaryColor
                            : AppColors.grey,
                      ),
                    ),
                    CustomText(
                      "",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      "Tuesday      ",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectTime(context, (value) {
                          setState(() {
                            fromTuesday = TextEditingController(text: value);
                          });
                        }, selectedTimeFromTuesday);
                      },
                      child: CustomText(
                        fromTuesday.text == ""
                            ? profileController.getVendorProfileData.value.data!
                                .vendor!.workTime![3].from
                            : fromTuesday.text,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectTime(context, (value) {
                          setState(() {
                            toTuesday = TextEditingController(text: value);
                          });
                        }, selectedTimeToTuesday);
                      },
                      child: CustomText(
                        toTuesday.text == ""
                            ? profileController.getVendorProfileData.value.data!
                                .vendor!.workTime![3].to
                            : toTuesday.text,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                    CustomText(
                      "",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      "Wednesday",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectTime(context, (value) {
                          setState(() {
                            fromWednesday = TextEditingController(text: value);
                          });
                        }, selectedTimeFromWednesday);
                      },
                      child: CustomText(
                        fromWednesday.text == ""
                            ? profileController.getVendorProfileData.value.data!
                                .vendor!.workTime![4].from
                            : fromWednesday.text,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectTime(context, (value) {
                          setState(() {
                            toWednesday = TextEditingController(text: value);
                          });
                        }, selectedTimetoWednesday);
                      },
                      child: CustomText(
                        toWednesday.text == ""
                            ? profileController.getVendorProfileData.value.data!
                                .vendor!.workTime![4].to
                            : toWednesday.text,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                    CustomText(
                      "",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      "Thursday    ",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectTime(context, (value) {
                          setState(() {
                            fromThursday = TextEditingController(text: value);
                          });
                        }, selectedTimeFromThursday);
                      },
                      child: CustomText(
                        fromThursday.text == ""
                            ? profileController.getVendorProfileData.value.data!
                                .vendor!.workTime![5].from
                            : fromThursday.text,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectTime(context, (value) {
                          setState(() {
                            toThursday = TextEditingController(text: value);
                          });
                        }, selectedTimetoThursday);
                      },
                      child: CustomText(
                        toThursday.text == ""
                            ? profileController.getVendorProfileData.value.data!
                                .vendor!.workTime![5].to
                            : toThursday.text,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                    CustomText(
                      "",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      "Friday         ",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectTime(context, (value) {
                          setState(() {
                            fromFriday = TextEditingController(text: value);
                          });
                        }, selectedTimeFromFriday);
                      },
                      child: CustomText(
                        fromFriday.text == ""
                            ? profileController.getVendorProfileData.value.data!
                                .vendor!.workTime![6].from
                            : fromFriday.text,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectTime(context, (value) {
                          setState(() {
                            toFriday = TextEditingController(text: value);
                          });
                        }, selectedTimetoFriday);
                      },
                      child: CustomText(
                        toFriday.text == ""
                            ? profileController.getVendorProfileData.value.data!
                                .vendor!.workTime![6].to
                            : toFriday.text,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                    CustomText(
                      "",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      "Saturday    ",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectTime(context, (value) {
                          setState(() {
                            fromSaturday = TextEditingController(text: value);
                          });
                        }, selectedTimeFromSaturday);
                      },
                      child: CustomText(
                        fromSaturday.text == ""
                            ? profileController.getVendorProfileData.value.data!
                                .vendor!.workTime![0].from
                            : fromSaturday.text,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectTime(context, (value) {
                          setState(() {
                            toSaturday = TextEditingController(text: value);
                          });
                        }, selectedTimetoSaturday);
                      },
                      child: CustomText(
                        toSaturday.text == ""
                            ? profileController.getVendorProfileData.value.data!
                                .vendor!.workTime![0].to
                            : toSaturday.text,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                    CustomText(
                      "",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      "Sunday       ",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectTime(context, (value) {
                          setState(() {
                            fromSunday = TextEditingController(text: value);
                          });
                        }, selectedTimeFromSunday);
                      },
                      child: CustomText(
                        fromSunday.text == ""
                            ? profileController.getVendorProfileData.value.data!
                                .vendor!.workTime![1].from
                            : fromSunday.text,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectTime(context, (value) {
                          setState(() {
                            toSunday = TextEditingController(text: value);
                          });
                        }, selectedTimetoSunday);
                      },
                      child: CustomText(
                        toSunday.text == ""
                            ? profileController.getVendorProfileData.value.data!
                                .vendor!.workTime![1].to
                            : toSunday.text,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                    CustomText(
                      "",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
