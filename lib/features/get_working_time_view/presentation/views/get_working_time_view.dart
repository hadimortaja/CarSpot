import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/utils/helper.dart';

class GetWorkingTimeView extends StatelessWidget {
  ProfileController profileController =Get.find();
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
                      CustomText(
                        "Save",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          Obx((){
            return
             profileController.getVendorProfileByIdData.value.data!.workTime==null?CustomText("There is No Work Times",
             fontSize: 12.sp,
               fontWeight: FontWeight.w400,
             ) : profileController.getVendorProfileByIdData.value.data!.workTime!.length==0?CustomText("There is No Work Times",
               fontSize: 12.sp,
               fontWeight: FontWeight.w400,):    Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                    itemCount:  profileController.getVendorProfileByIdData.value.data!.workTime!.length,
                    itemBuilder: (context,index){
                  return Column(children: [
                    Row(
                       children: [
                      CustomText( profileController.getVendorProfileByIdData.value.data!.workTime![index].day,
                      fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: 50.w),
                            width:60.w,
                             child: CustomText( profileController.getVendorProfileByIdData.value.data!.workTime![index].from,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                         SizedBox(width: 50.w,),
                         CustomText( profileController.getVendorProfileByIdData.value.data!.workTime![index].to,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],),
                    SizedBox(height: 25.h,),
                  ],);
                }));
          })


        ],
      ),
    );
  }
}
