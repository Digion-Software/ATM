import 'package:atm/config/api_endpoints.dart';
import 'package:atm/config/app_constant.dart';
import 'package:atm/models/bank/bank_model.dart';
import 'package:atm/models/bank/get_bank_name_logo_model.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/models/simple_model.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/common/show_snack_bar.dart';
import 'package:atm/utils/local_storage/shared_preferences.dart';
import 'package:atm/utils/networking/http_handler.dart';
import 'package:flutter/material.dart';

class BankRepository {
  static Future<BankModel?> getBankList({required BuildContext context}) async {
    APIResponse apiResponse = await HttpHandler.postMethod(context: context, url: APIEndpoints.bankManage, data: {
      "is_app": AppConstant.isApp,
      "action": APIActions.getBankList,
      "user_id": await LocalStorage.getString(key: AppConstant.userId),
      "auth_key": await LocalStorage.getString(key: AppConstant.token),
    });
    if (apiResponse.isSuccess) {
      return bankModelFromJson(apiResponse.data);
    } else {
      return bankModelFromJson(apiResponse.data);
    }
  }

  static Future<GetBankNameLogoModel?> getBankNameLogo({required BuildContext context}) async {
    APIResponse apiResponse = await HttpHandler.getMethod(url: APIEndpoints.getBankNameLogo);
    if (apiResponse.isSuccess) {
      return getBankNameLogoModelFromJson(apiResponse.data);
    } else {
      return getBankNameLogoModelFromJson(apiResponse.data);
    }
  }

  static Future<void> deleteBank(
      {required BuildContext context, required String bankId, required Function(bool) onDelete}) async {
    showLoadingDialog(context: context);
    APIResponse apiResponse = await HttpHandler.postMethod(context: context, url: APIEndpoints.bankManage, data: {
      "is_app": AppConstant.isApp,
      "action": APIActions.bankDelete,
      "bank_id": bankId,
      "user_id": await LocalStorage.getString(key: AppConstant.userId),
      "auth_key": await LocalStorage.getString(key: AppConstant.token),
    });
    if (apiResponse.isSuccess) {
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      onDelete(true);
      hideLoadingDialog(context: context);
      showToast(context: context, msg: simpleModel.message);
    } else {
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      hideLoadingDialog(context: context);
      showToast(context: context, msg: simpleModel.message, isError: true);
    }
  }

  static Future<void> addBank({
    required BuildContext context,
    required String bankName,
    required String bankAccountName,
    required String bankAccountNumber,
    required String confirmBankNumber,
    required String bankIFSC,
    required Function(bool) onAddBank,
  }) async {
    if (bankName.isEmpty) {
      showToast(context: context, msg: "Enter bank name.", isError: true);
    } else if (bankAccountName.isEmpty) {
      showToast(context: context, msg: "Enter account holder name.", isError: true);
    } else if (bankAccountNumber.isEmpty) {
      showToast(context: context, msg: "Enter account number.", isError: true);
    } else if (bankAccountNumber.length != 12) {
      showToast(context: context, msg: "Enter valid account number.", isError: true);
    } else if (confirmBankNumber.isEmpty) {
      showToast(context: context, msg: "Enter confirm account number.", isError: true);
    } else if (confirmBankNumber.length != 12) {
      showToast(context: context, msg: "Enter valid confirm account number.", isError: true);
    } else if (confirmBankNumber.toString().trim() != bankAccountNumber.toString().trim()) {
      showToast(context: context, msg: "Account number and Confirm account number should be same.", isError: true);
    } else if (bankIFSC.isEmpty) {
      showToast(context: context, msg: "Enter IFSC number.", isError: true);
    } else if (!isValidIIFC(bankIFSC)) {
      showToast(context: context, msg: "Enter valid IFSC number.", isError: true);
    } else {
      showLoadingDialog(context: context);
      APIResponse apiResponse = await HttpHandler.postMethod(context: context, url: APIEndpoints.bankManage, data: {
        "is_app": AppConstant.isApp,
        "action": APIActions.bankAdd,
        "user_id": await LocalStorage.getString(key: AppConstant.userId),
        "auth_key": await LocalStorage.getString(key: AppConstant.token),
        "bank_name": bankName,
        "bank_account_number": bankAccountNumber,
        "confirm_bank_account_number": confirmBankNumber,
        "bank_ifsc": bankIFSC,
        "bank_account_name": bankAccountName,
      });
      if (apiResponse.isSuccess) {
        SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
        hideLoadingDialog(context: context);
        showToast(context: context, msg: simpleModel.message);
        onAddBank(true);
      } else {
        SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
        hideLoadingDialog(context: context);
        showToast(context: context, msg: simpleModel.message, isError: true);
      }
    }
  }

  static Future<void> editBank({
    required BuildContext context,
    required String bankName,
    required String bankAccountName,
    required String bankAccountNumber,
    required String confirmBankNumber,
    required String bankIFSC,
    required Function(bool) onAddBank,
    required String bankId,
  }) async {
    if (bankName.isEmpty) {
      showToast(context: context, msg: "Enter bank name.", isError: true);
    } else if (bankAccountName.isEmpty) {
      showToast(context: context, msg: "Enter account holder name.", isError: true);
    } else if (bankAccountNumber.isEmpty) {
      showToast(context: context, msg: "Enter account number.", isError: true);
    } else if (bankAccountNumber.length != 12) {
      showToast(context: context, msg: "Enter valid account number.", isError: true);
    } else if (confirmBankNumber.isEmpty) {
      showToast(context: context, msg: "Enter confirm account number.", isError: true);
    } else if (confirmBankNumber.length != 12) {
      showToast(context: context, msg: "Enter valid confirm account number.", isError: true);
    } else if (confirmBankNumber.toString().trim() != bankAccountNumber.toString().trim()) {
      showToast(context: context, msg: "Account number and Confirm account number should be same.", isError: true);
    } else if (bankIFSC.isEmpty) {
      showToast(context: context, msg: "Enter IFSC number.", isError: true);
    } else if (!isValidIIFC(bankIFSC)) {
      showToast(context: context, msg: "Enter valid IFSC number.", isError: true);
    } else {
      showLoadingDialog(context: context);
      APIResponse apiResponse = await HttpHandler.postMethod(context: context, url: APIEndpoints.bankManage, data: {
        "is_app": AppConstant.isApp,
        "action": APIActions.bankEdit,
        "bank_id": bankId,
        "user_id": await LocalStorage.getString(key: AppConstant.userId),
        "auth_key": await LocalStorage.getString(key: AppConstant.token),
        "bank_name": bankName,
        "bank_account_number": bankAccountNumber,
        "confirm_bank_account_number": confirmBankNumber,
        "bank_ifsc": bankIFSC,
        "bank_account_name": bankAccountName,
      });
      if (apiResponse.isSuccess) {
        SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
        hideLoadingDialog(context: context);
        showToast(context: context, msg: simpleModel.message);
        onAddBank(true);
      } else {
        SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
        hideLoadingDialog(context: context);
        showToast(context: context, msg: simpleModel.message, isError: true);
      }
    }
  }
}

bool isValidIIFC(String iifc) {
  String p = r'^[A-Z]{4}0[A-Z0-9]{6}$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(iifc);
}
