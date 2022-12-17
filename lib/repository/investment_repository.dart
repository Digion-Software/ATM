import 'dart:io';

import 'package:atm/config/api_endpoints.dart';
import 'package:atm/config/app_constant.dart';
import 'package:atm/models/app_update/razorpay_config_model.dart';
import 'package:atm/models/authentication/login_model.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/models/investment_manage/investment_manage_model.dart';
import 'package:atm/models/payments/crypto_response_model.dart';
import 'package:atm/models/payments/deposit_status_model.dart';
import 'package:atm/models/simple_model.dart';
import 'package:atm/repository/payment_repository.dart';
import 'package:atm/screens/dashboard/dashboard_screen.dart';
import 'package:atm/screens/payments/crypto_response_screen.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/common/show_snack_bar.dart';
import 'package:atm/utils/local_storage/shared_preferences.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/utils/networking/http_handler.dart';
import 'package:atm/utils/payment/razorpay_payment.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class InvestRepository {
  static Future<void> investmentManualManage({
    required BuildContext context,
    required String amount,
    required File image,
    required String planId,
  }) async {
    showLoadingDialog(context: context);
    APIResponse apiResponse = await HttpHandler.postMultiPartRequestMethod(
        url: APIEndpoints.investmentManage,
        file1Data: image,
        file1Key: "payment_screenshort_image",
        data: {
          "manual_deposit": "1",
          "is_app": AppConstant.isApp.toString(),
          "action": APIActions.buyPackage,
          "user_id": await LocalStorage.getString(key: AppConstant.userId) ?? "",
          "auth_key": await LocalStorage.getString(key: AppConstant.token) ?? "",
          "plan_id": planId,
          "amount": amount
        });
    if (apiResponse.isSuccess) {
      hideLoadingDialog(context: context);
      InvestmentManageModel investmentManageModel = investmentManageModelFromJson(apiResponse.data);
      showToast(context: context, msg: investmentManageModel.message ?? "");
      PageNavigator.pushAndRemoveUntilPage(context: context, page: const DashboardScreen());
    } else {
      hideLoadingDialog(context: context);
    }
  }

  static Future<void> investmentOnlineManage({
    required BuildContext context,
    required String amount,
    required String planId,
    required String razorPayKey,
    required RazorPayConfigModel razorPayConfigModel,
  }) async {
    showLoadingDialog(context: context);
    APIResponse apiResponse = await HttpHandler.postMethod(context: context, url: APIEndpoints.investmentManage, data: {
      "manual_deposit": "0",
      "is_app": AppConstant.isApp.toString(),
      "action": APIActions.buyPackage,
      "user_id": await LocalStorage.getString(key: AppConstant.userId) ?? "",
      "auth_key": await LocalStorage.getString(key: AppConstant.token) ?? "",
      "plan_id": planId,
      "amount": amount
    });
    if (apiResponse.isSuccess) {
      hideLoadingDialog(context: context);
      InvestmentManageModel investmentManageModel = investmentManageModelFromJson(apiResponse.data);
      RazorpayPayment.paymentRequestOptions['key'] = razorPayKey;
      RazorpayPayment.paymentRequestOptions['amount'] = (int.parse(amount) * 100).toString();
      RazorpayPayment.paymentRequestOptions['name'] = razorPayConfigModel.data.razorpayData.name;
      RazorpayPayment.paymentRequestOptions['description'] = razorPayConfigModel.data.razorpayData.description;
      if (await LocalStorage.getString(key: AppConstant.userDetails) != null) {
        LoginModel loginModel = loginModelFromJson(await LocalStorage.getString(key: AppConstant.userDetails) ?? "");
        if (loginModel.userData != null) {
          RazorpayPayment.paymentRequestOptions['prefill']["contact"] = loginModel.userData!.userPhone;
          if (loginModel.userData!.email.isNotEmpty) {
            RazorpayPayment.paymentRequestOptions['prefill']["email"] = loginModel.userData!.email;
          } else {
            RazorpayPayment.paymentRequestOptions['prefill']["email"] = "ATM";
          }
        }
      }

      RazorpayPayment.addRazorpayListeners(
        onSuccessHandel: (PaymentSuccessResponse response) async {
          await PaymentRepository.paymentSuccess(context: context, investmentId: investmentManageModel.investmentId!);
        },
        onFailureHandel: (PaymentFailureResponse response) async {
          await PaymentRepository.paymentFailed(context: context, investmentId: investmentManageModel.investmentId!);
        },
      );
      RazorpayPayment.openRazorpayPayment();
    } else {
      hideLoadingDialog(context: context);
    }
  }

  static Future<void> investmentUPIManage(
      {required BuildContext context,
      required String amount,
      required File? image,
      required String planId,
      required String depositMethod}) async {
    showLoadingDialog(context: context);
    APIResponse apiResponse = await HttpHandler.postMultiPartRequestMethod(
        url: APIEndpoints.addDeposit,
        file1Data: image,
        file1Key: "deposit_proof",
        data: {
          "manual_deposit": "1",
          "is_app": AppConstant.isApp.toString(),
          "user_id": await LocalStorage.getString(key: AppConstant.userId) ?? "",
          "auth_key": await LocalStorage.getString(key: AppConstant.token) ?? "",
          "plan_id": planId,
          "amount": amount,
          "deposit_method": depositMethod,
        });
    if (apiResponse.isSuccess) {
      hideLoadingDialog(context: context);
      print("DATA : ${apiResponse.data}");
      // InvestmentManageModel investmentManageModel = investmentManageModelFromJson(apiResponse.data);
      // showToast(context: context, msg: investmentManageModel.message ?? "");
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      showToast(context: context, msg: simpleModel.message);

      ///SHOW SUCCESS MESSAGE
      PageNavigator.pushAndRemoveUntilPage(context: context, page: const DashboardScreen());
    } else {
      ///SHOW FAILED MESSAGE
      hideLoadingDialog(context: context);
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      showToast(context: context, msg: simpleModel.message, isError: true);
    }
  }

  static Future<void> investmentCryptoManage({
    required BuildContext context,
    required String amount,
    required String planId,
    required String depositMethod,
    required String cryptoType,
  }) async {
    showLoadingDialog(context: context);
    APIResponse apiResponse = await HttpHandler.postMethod(context: context, url: APIEndpoints.addDeposit, data: {
      "manual_deposit": "0",
      "is_app": AppConstant.isApp.toString(),
      "user_id": await LocalStorage.getString(key: AppConstant.userId) ?? "",
      "auth_key": await LocalStorage.getString(key: AppConstant.token) ?? "",
      "plan_id": planId,
      "amount": amount,
      "deposit_method": depositMethod,
      "crypto_type": cryptoType.toUpperCase()
    });
    if (apiResponse.isSuccess) {
      hideLoadingDialog(context: context);
      // print("DATA : ${apiResponse.data}");
      CryptoResponseModel cryptoResponseModel = cryptoResponseModelFromJson(apiResponse.data);
      showToast(context: context, msg: cryptoResponseModel.message);
      PageNavigator.pushAndRemoveUntilPage(
          context: context,
          page: CryptoResponseScreen(
            cryptoData: cryptoResponseModelFromJson(apiResponse.data).data!,
          ));

      ///GO FOR TIMER SCREEN
    } else {
      hideLoadingDialog(context: context);
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      showToast(context: context, msg: simpleModel.message, isError: true);
    }
  }

  static Future<void> checkCryptoResponse({
    required BuildContext context,
    required String investmentId,
    required String transactionId,
  }) async {
    APIResponse apiResponse =
        await HttpHandler.postMethod(context: context, url: APIEndpoints.checkDepositStatus, data: {
      "manual_deposit": "0",
      "is_app": AppConstant.isApp.toString(),
      "user_id": await LocalStorage.getString(key: AppConstant.userId) ?? "",
      "auth_key": await LocalStorage.getString(key: AppConstant.token) ?? "",
      "investment_id": investmentId,
      "transaction_id": transactionId,
    });
    DepositStatusModel depositStatusModel = depositStatusModelFromJson(apiResponse.data);
    if (depositStatusModel.depositStatus == "0") {
      Future.delayed(const Duration(seconds: 10),() {
        checkCryptoResponse(context: context,investmentId: investmentId,transactionId: transactionId);
      },);
    } else if (depositStatusModel.depositStatus == "1") {
      showToast(context: context, msg: depositStatusModel.message);
      PageNavigator.pushAndRemoveUntilPage(context: context, page: const DashboardScreen());
    }
    else if (depositStatusModel.depositStatus == "2") {
      showToast(context: context, msg: depositStatusModel.message);
      PageNavigator.pushAndRemoveUntilPage(context: context, page: const DashboardScreen());
    }

  }
}
