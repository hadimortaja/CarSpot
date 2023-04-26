import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/core/value/animate_do.dart';
import 'package:car_rental/features/choose_country_view/data/data_souces/cities_data_source.dart';
import 'package:car_rental/features/choose_service_view/data/data_sources/choose_service_data_source.dart';
import 'package:car_rental/features/home_view/data/data_sources/home_banners_data_source.dart';
import 'package:car_rental/features/home_view/data/data_sources/home_categories_data_source.dart';
import 'package:car_rental/features/home_view/data/data_sources/most_popular_data_source.dart';
import 'package:car_rental/features/main_view/presentation/main_view.dart';
import 'package:car_rental/features/onboarding_view/presentation/views/onboarding_view.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_profile_data_source.dart';
import 'package:car_rental/features/profile_view/data/data_sources/get_vendor_profile_data_source.dart';
import 'package:car_rental/features/signin_view/presentation/views/signin_view.dart';

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    var delay = Duration(seconds: 3);
    Future.delayed(delay, () async {
      chooseServiceDataSource();
      homeCategoriesDataSource();
      homeMostPopularDataSource();
      homeBannersDataSource();
      citiesDataSource();
      getProfileDataSource();
      if (SPHelper.spHelper.getType() == "1") {
        getVendorProfileDataSource();
      } else {}
      if (SPHelper.spHelper.getViewOnBoarding() == true) {
        Get.offAll(() => MainView());
      } else {
        Get.offAll(() => OnBoardingScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FadeInLeft(
      animate: true,
      duration: Duration(seconds: 1),
      from: 300,
      child: Container(
        height: 150.h,
        width: 150.w,
        child: Image.asset("assets/images/app_logo_new.png"),
      ),
    )));
  }
}
