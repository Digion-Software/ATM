import 'package:atm/config/api_endpoints.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/models/dashboard/dashboard_model.dart';
import 'package:atm/utils/networking/common_body.dart';
import 'package:atm/utils/networking/http_handler.dart';
import 'package:flutter/cupertino.dart';

class HomeRepository {
  static Future<DashboardModel?> getDashboardData({required BuildContext context}) async {
    APIResponse apiResponse =
        await HttpHandler.postMethod(context: context,url: APIEndpoints.getDashboardData, data: await CommonBody.authBody());
    if (apiResponse.isSuccess) {
      return dashboardModelFromJson(apiResponse.data);
    } else {
      return null;
    }
  }
}
