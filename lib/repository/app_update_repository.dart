import 'package:atm/config/api_endpoints.dart';
import 'package:atm/models/app_update/app_update_model.dart';
import 'package:atm/models/app_update/razorpay_config_model.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/utils/networking/http_handler.dart';
import 'package:flutter/material.dart';

class AppUpdateRepository {
  static Future<AppUpdateModel?> checkAppConfigToUpdate({
    required BuildContext context,
  }) async {
    APIResponse response = await HttpHandler.getMethod(url: APIEndpoints.appUpdate);
    if (response.isSuccess) {
      AppUpdateModel appUpdateModel = appUpdateModelFromJson(response.data);
      return appUpdateModel;
    }
    return null;
  }

  static Future<RazorPayConfigModel?> checkRazorPayConfiguration({
    required BuildContext context,
  }) async {
    APIResponse response = await HttpHandler.getMethod(url: APIEndpoints.razorPayConfig);
    if (response.isSuccess) {
      RazorPayConfigModel razorPayConfigModel = razorPayConfigModeFromJson(response.data);
      return razorPayConfigModel;
    }
    return null;
  }
}
