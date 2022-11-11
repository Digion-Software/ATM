import 'package:atm/config/api_endpoints.dart';
import 'package:atm/config/app_constant.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/models/faq/faq_model.dart';
import 'package:atm/utils/local_storage/shared_preferences.dart';
import 'package:atm/utils/networking/http_handler.dart';
import 'package:flutter/material.dart';

class TicketRepository
{
  static Future<FaqModel?> getTicketList({required BuildContext context}) async {
    APIResponse apiResponse = await HttpHandler.postMethod(url: APIEndpoints.ticketList,useSecondUrl: true,
    context: context,
    data: {
      "is_app": AppConstant.isApp,
      "user_id": await LocalStorage.getString(key: AppConstant.userId),
      "auth_key": await LocalStorage.getString(key: AppConstant.token),
    }
    );
    if (apiResponse.isSuccess) {
      return faqModelFromJson(apiResponse.data);
    } else {
      return faqModelFromJson(apiResponse.data);
    }
  }
}