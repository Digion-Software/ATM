import 'dart:io';

import 'package:atm/config/api_endpoints.dart';
import 'package:atm/config/app_constant.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/models/faq/faq_model.dart';
import 'package:atm/models/simple_model.dart';
import 'package:atm/models/ticket/ticket_list_model.dart';
import 'package:atm/models/ticket/ticket_option_model.dart';
import 'package:atm/models/ticket/view_ticket_chat_model.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/common/show_snack_bar.dart';
import 'package:atm/utils/local_storage/shared_preferences.dart';
import 'package:atm/utils/networking/http_handler.dart';
import 'package:flutter/material.dart';

class TicketRepository {
  static Future<TicketListModel?> getTicketList({required BuildContext context}) async {
    APIResponse apiResponse =
        await HttpHandler.postMethod(url: APIEndpoints.ticketList, useSecondUrl: true, context: context, data: {
      "is_app": AppConstant.isApp,
      "user_id": await LocalStorage.getString(key: AppConstant.userId),
      "auth_key": await LocalStorage.getString(key: AppConstant.token),
      "draw": "0",
      "start": "0",
      "length": "1000"
    });
    if (apiResponse.isSuccess) {
      return ticketListModelFromJson(apiResponse.data);
    } else {
      return ticketListModelFromJson(apiResponse.data);
    }
  }

  static Future<TicketOptionModel?> getTicketOption({required BuildContext context}) async {
    APIResponse apiResponse = await HttpHandler.postMethod(url: APIEndpoints.ticketOption, context: context, data: {
      "is_app": AppConstant.isApp,
      "action": APIActions.ticketOption,
      "user_id": await LocalStorage.getString(key: AppConstant.userId),
      "auth_key": await LocalStorage.getString(key: AppConstant.token),
    });
    if (apiResponse.isSuccess) {
      return ticketOptionModelFromJson(apiResponse.data);
    } else {
      return ticketOptionModelFromJson(apiResponse.data);
    }
  }

  static Future createTicket({
    required BuildContext context,
    required String ticketTitle,
    required String? subject,
    required String ticketBody,
    required File? attachment,
  }) async {
    if (ticketTitle.isEmpty) {
      showToast(context: context, msg: "Enter ticket title.", isError: true);
    } else if (subject == null || subject.isEmpty) {
      showToast(context: context, msg: "Select yor ticket option.", isError: true);
    } else if (ticketBody.isEmpty) {
      showToast(context: context, msg: "Enter ticket description.", isError: true);
    } else if (attachment == null) {
      showToast(context: context, msg: "Upload your attachment.", isError: true);
    } else {
      showLoadingDialog(context: context);
      APIResponse apiResponse = await HttpHandler.postMultiPartRequestMethod(
          url: APIEndpoints.createTicket,
          data: {
            "is_app": AppConstant.isApp.toString(),
            "ticketTitle": ticketTitle,
            "subject": subject,
            "ticketBody": ticketBody,
            "user_id": await LocalStorage.getString(key: AppConstant.userId) ?? "",
            "auth_key": await LocalStorage.getString(key: AppConstant.token) ?? "",
          },
          file1Key: "attachment",
          file1Data: attachment);
      if (apiResponse.isSuccess) {
        SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
        hideLoadingDialog(context: context);
        showToast(msg: simpleModel.message, context: context);
      } else {
        SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
        hideLoadingDialog(context: context);
        showToast(msg: simpleModel.message, context: context);
      }
    }
  }

  static Future<ViewTicketChatModel?> viewTicketChat({required BuildContext context}) async {
    APIResponse apiResponse = await HttpHandler.postMethod(url: APIEndpoints.viewTicketChat, context: context, data: {
      "is_app": AppConstant.isApp,
      "ticket_id": "63",
      "user_id": await LocalStorage.getString(key: AppConstant.userId),
      "auth_key": await LocalStorage.getString(key: AppConstant.token),
    });
    if (apiResponse.isSuccess) {
      return viewTicketChatModelFromJson(apiResponse.data);
    } else {
      return viewTicketChatModelFromJson(apiResponse.data);
    }
  }
}
