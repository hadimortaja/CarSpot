import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/utils/helper.dart';
import 'package:car_rental/core/value/colors.dart';
import 'package:dio/dio.dart';

class Apis {
  Apis._();
  static Apis apis = Apis._();

  Dio? dio;
  String baseUrl = 'https://cardeal.fresh-app.com/';

  // String baseImageUrl =
  //     "https://cardeal.fresh-app.com/images/uploads/categories/";

  initDio() {
    if (dio == null) {
      dio = Dio();
    }
    return dio;
  }

  Future<Response?> get<T>(
    String endPoint,
  ) async {
    try {
      initDio();
      String? accessToken = SPHelper.spHelper.getToken();
      Response response = await dio!.get(
        baseUrl + endPoint,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${accessToken} ',
          },
        ),
      );

      log('get$endPoint ${response.data}');

      if (response.data['status'].toString() == 'true') {
        return response;
      } else {
        if (endPoint.contains('join')) {
          Helper.getSheetError(response.data['message_ar']);
        }
        return null;
      }
    } on Exception catch (e) {
      log('error$endPoint $e');
      return null;
    }
  }

  Future<Response?> post<T>(String endPoint, {FormData? formData}) async {
    try {
      initDio();

      String? accessToken = SPHelper.spHelper.getToken();

      Response response = await dio!.post(
        baseUrl + endPoint,
        data: formData,
        options: Options(
          validateStatus: (status) => status! < 500,
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Accept': 'application/json'
          },
        ),
      );

      print(
          'postpostpostpostpostpostpostpost$endPoint ${response.data.runtimeType}');

      if (response.data.runtimeType != String) {
        if (response.data['code'].toString() == "200" ||
            response.data['code'].toString() == "201") {
          return response;
        } else {
          Helper.hideLoading();
          BotToast.showText(
              text: response.data['message'],
              contentColor: AppColors.primaryColor);
          // Helper.getSheetError(response.data['message']);

          return null;
        }
      }
    } on Exception catch (e) {
      log('e $e');
      Helper.hideLoading();
      // Helper.getSheetError(e.toString());
      return null;
    }
  }

  Future<Response?> delete<T>(String endPoint, {FormData? formData}) async {
    try {
      initDio();

      String? accessToken = SPHelper.spHelper.getToken();

      Response response = await dio!.delete(
        baseUrl + endPoint,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      log('postpostpostpostpostpostpostpost ${response.data}');

      if (response.data['status']) {
        return response;
      } else {
        Helper.getSheetError(response.data['message_ar']);
        return null;
      }
    } on Exception catch (e) {
      Helper.getSheetError(e.toString());
      return null;
    }
  }

  Future<Response?> put<T>(String endPoint, {FormData? formData}) async {
    try {
      initDio();

      String? accessToken = SPHelper.spHelper.getToken();

      Response response = await dio!.put(
        baseUrl + endPoint,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      log('putputputputputputput ${response.data}');

      if (response.data['status']) {
        return response;
      } else {
        Helper.getSheetError(response.data['message']);
        return null;
      }
    } on Exception catch (e) {
      Helper.getSheetError(e.toString());
      return null;
    }
  }
}
