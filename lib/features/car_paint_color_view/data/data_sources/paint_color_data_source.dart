import 'package:car_rental/core/backend/apis.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/utils/app_imports.dart';
import 'package:car_rental/features/car_paint_color_view/data/models/colors_model.dart';

AuthController authController = Get.find();
paintColorDataSource() async {
  authController.getPaintColorData.value = ColorsModel();
  // BotToast.showLoading();

  dynamic response = await Apis.apis.get(
    'api/get_colors',
  );
  if (response != null) {
    authController.getPaintColorData.value =
        ColorsModel.fromJson(response.data);
  } else {}
}
