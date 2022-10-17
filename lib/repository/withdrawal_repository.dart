import 'package:atm/config/api_endpoints.dart';
import 'package:atm/config/app_constant.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/models/simple_model.dart';
import 'package:atm/models/withdrawal/get_withdrawal_list_model.dart';
import 'package:atm/screens/dashboard/dashboard_screen.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/common/show_snack_bar.dart';
import 'package:atm/utils/local_storage/shared_preferences.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/utils/networking/http_handler.dart';
import 'package:flutter/cupertino.dart';

class WithdrawalRepository {
  static Future<GetWithdrawalListModel?> getWithdrawalListData({required BuildContext context}) async {
    APIResponse apiResponse =
        await HttpHandler.postMethod(context: context, url: APIEndpoints.getWithdrawalList, data: {
      "is_app": AppConstant.isApp,
      "user_id": await LocalStorage.getString(key: AppConstant.userId),
      "auth_key": await LocalStorage.getString(key: AppConstant.token),
      "action": APIActions.getWithdrawal
    });
    if (apiResponse.isSuccess) {
      return getWithdrawalListModelFromJson(apiResponse.data);
    } else {
      return null;
    }
  }

  static Future<void> capitalWithdrawal({
    required BuildContext context,
    required int planId,
    required int bankId,
    required double withdrawalAmount,
    required int accountNumber,
  }) async {
    showLoadingDialog(context: context);
    APIResponse apiResponse =
        await HttpHandler.postMethod(context: context, url: APIEndpoints.getWithdrawalList, data: {
      "is_app": AppConstant.isApp,
      "user_id": await LocalStorage.getString(key: AppConstant.userId),
      "auth_key": await LocalStorage.getString(key: AppConstant.token),
      "action": APIActions.capitalWithdrawal,
      "plan_id": planId,
      "user_bank_id": bankId,
      "withdrawal_amount": withdrawalAmount,
      "withdrawal_account_number": accountNumber,
      "payment_method": "bank",
    });
    if (apiResponse.isSuccess) {
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      hideLoadingDialog(context: context);
      showToast(msg: simpleModel.message, context: context);
      PageNavigator.pushAndRemoveUntilPage(context: context, page: const DashboardScreen());
    } else {
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      hideLoadingDialog(context: context);
      showToast(msg: simpleModel.message, isError: true, context: context);
    }
  }

  static Future<void> profitWithdrawal({
    required BuildContext context,
    required int planId,
    required int bankId,
    required double withdrawalAmount,
    required int accountNumber,
  }) async {
    showLoadingDialog(context: context);
    APIResponse apiResponse =
        await HttpHandler.postMethod(context: context, url: APIEndpoints.getWithdrawalList, data: {
      "is_app": AppConstant.isApp,
      "user_id": await LocalStorage.getString(key: AppConstant.userId),
      "auth_key": await LocalStorage.getString(key: AppConstant.token),
      "action": APIActions.profitWithdrawal,
      "plan_id": planId,
      "user_bank_id": bankId,
      "withdrawal_amount": withdrawalAmount,
      "withdrawal_account_number": accountNumber,
      "payment_method": "bank",
    });
    if (apiResponse.isSuccess) {
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      hideLoadingDialog(context: context);
      showToast(msg: simpleModel.message, context: context);
      PageNavigator.pushAndRemoveUntilPage(context: context, page: const DashboardScreen());
    } else {
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      hideLoadingDialog(context: context);
      showToast(msg: simpleModel.message, isError: true, context: context);
    }
  }
}
