import 'package:atm/config/api_endpoints.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/models/simple_model.dart';
import 'package:atm/screens/dashboard/dashboard_screen.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/common/show_snack_bar.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/utils/networking/http_handler.dart';
import 'package:flutter/material.dart';

class PaymentRepository {
  static Future<void> paymentSuccess({required BuildContext context, required int investmentId}) async {
    showLoadingDialog(context: context);
    APIResponse apiResponse = await HttpHandler.postMethod(
        context: context, url: APIEndpoints.paymentSuccess, data: {"investment_id": investmentId});
    if (apiResponse.isSuccess) {
      hideLoadingDialog(context: context);
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      PageNavigator.pushAndRemoveUntilPage(context: context, page: const DashboardScreen());
      showToast(context: context, msg: simpleModel.message);
    } else {
      hideLoadingDialog(context: context);
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      showToast(context: context, msg: simpleModel.message, isError: true);
    }
  }

  static Future<void> paymentFailed({required BuildContext context, required int investmentId}) async {
    showLoadingDialog(context: context);
    APIResponse apiResponse = await HttpHandler.postMethod(
        context: context, url: APIEndpoints.paymentFailed, data: {"investment_id": investmentId});
    if (apiResponse.isSuccess) {
      hideLoadingDialog(context: context);
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      PageNavigator.pushAndRemoveUntilPage(context: context, page: const DashboardScreen());
      showToast(context: context, msg: simpleModel.message, isError: true);
    } else {
      hideLoadingDialog(context: context);
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      showToast(context: context, msg: simpleModel.message, isError: true);
    }
  }
}
