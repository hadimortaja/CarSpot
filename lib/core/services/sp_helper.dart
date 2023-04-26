import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  SPHelper._();
  static SPHelper spHelper = SPHelper._();

  SharedPreferences? sharedPreferences;

  Future<SharedPreferences> initSharedPrefrences() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences!;
    } else {
      return sharedPreferences!;
    }
  }

  setToken(String value) async {
    sharedPreferences!.setString('accessToken', value);
  }

  String? getToken() {
    String? x = sharedPreferences!.getString('accessToken') ?? '';
    print(x);
    return x;
  }

  setType(String value) async {
    sharedPreferences!.setString('type', value);
  }

  String? getType() {
    String? x = sharedPreferences!.getString('type');
    print(x);
    return x;
  }

  setViewOnBarding(bool value) async {
    sharedPreferences!.setBool('onBoarding', value);
  }

  bool? getViewOnBoarding() {
    bool? x = sharedPreferences!.getBool('onBoarding');
    print(x);
    return x;
  }

  String? getLanguage() {
    String? x = sharedPreferences!.getString('lang') ?? "en";
    print(x);
    return x;
  }

  setLanguage(String value) async {
    sharedPreferences!.setString('lang', value);
  }
}
