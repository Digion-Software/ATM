import 'package:atm/config/api_endpoints.dart';
import 'package:atm/config/app_constant.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/models/simple_model.dart';
import 'package:atm/models/transfer_plan/internal_transfer_model.dart';
import 'package:atm/screens/dashboard/dashboard_screen.dart';
import 'package:atm/screens/transfer_plan/transfer_plan_verification_screen.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/common/show_snack_bar.dart';
import 'package:atm/utils/local_storage/shared_preferences.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/utils/networking/http_handler.dart';
import 'package:flutter/material.dart';

class TransferPlanRepository {
  static Future<InternalTransferModel?> internalTransferPlanList(
      {required BuildContext context, required String planId}) async {
    showLoadingDialog(context: context);
    APIResponse apiResponse = await HttpHandler.postMethod(url: APIEndpoints.internalTransfer, context: context, data: {
      "is_app": AppConstant.isApp,
      "action": APIActions.getPlanList,
      "plan_id": planId,
      "user_id": await LocalStorage.getString(key: AppConstant.userId),
      "auth_key": await LocalStorage.getString(key: AppConstant.token),
    });
    if (apiResponse.isSuccess) {
      hideLoadingDialog(context: context);
      return internalTransferModelFromJson(apiResponse.data);
    } else {
      hideLoadingDialog(context: context);
      return internalTransferModelFromJson(apiResponse.data);
    }
  }

  static Future<void> internalTransferPlanOTP(
      {required BuildContext context, required String planId, required String toPlanId, required String amount}) async {
    showLoadingDialog(context: context);
    APIResponse apiResponse = await HttpHandler.postMethod(url: APIEndpoints.internalTransfer, context: context, data: {
      "is_app": AppConstant.isApp,
      "action": APIActions.requestOTP,
      "plan_id": planId,
      "to_plan_id": toPlanId,
      "amount": amount,
      "user_id": await LocalStorage.getString(key: AppConstant.userId),
      "auth_key": await LocalStorage.getString(key: AppConstant.token),
    });
    if (apiResponse.isSuccess) {
      hideLoadingDialog(context: context);
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      PageNavigator.pop(context: context);
      PageNavigator.pushPage(
          context: context,
          page: TransferPlanVerificationScreen(
            planId: planId,
            toPlanId: toPlanId,
            amount: amount,
          ));
      showToast(msg: simpleModel.message, context: context);
    } else {
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      hideLoadingDialog(context: context);
      showToast(msg: simpleModel.message, context: context, isError: true);
    }
  }

  static Future<void> addTransferPlan(
      {required BuildContext context,
      required String planId,
      required String toPlanId,
      required String amount,
      required String otpCode}) async {
    showLoadingDialog(context: context);
    APIResponse apiResponse = await HttpHandler.postMethod(url: APIEndpoints.internalTransfer, context: context, data: {
      "is_app": AppConstant.isApp,
      "action": APIActions.addTransfer,
      "plan_id": planId,
      "to_plan_id": toPlanId,
      "amount": amount,
      "otp": otpCode,
      "user_id": await LocalStorage.getString(key: AppConstant.userId),
      "auth_key": await LocalStorage.getString(key: AppConstant.token),
    });
    if (apiResponse.isSuccess) {
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      hideLoadingDialog(context: context);
      showToast(msg: simpleModel.message, context: context);
      PageNavigator.pushAndRemoveUntilPage(context: context, page: const DashboardScreen());
    } else {
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      hideLoadingDialog(context: context);
      showToast(msg: simpleModel.message, context: context, isError: true);
    }
  }
}
