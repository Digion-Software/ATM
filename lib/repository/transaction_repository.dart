import 'package:atm/config/api_endpoints.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/models/transaction/transaction_model.dart';
import 'package:atm/utils/networking/common_body.dart';
import 'package:atm/utils/networking/http_handler.dart';
import 'package:flutter/material.dart';

class TransactionRepository {
  static Future<TransactionModel?> getTransactions({required BuildContext context}) async {
    APIResponse apiResponse =
        await HttpHandler.postMethod(context: context,url: APIEndpoints.transaction, data: await CommonBody.authBody());
    if (apiResponse.isSuccess) {
      return transactionModelFromJson(apiResponse.data);
    } else {
      return null;
    }
  }
}
