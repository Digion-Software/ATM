import 'package:atm/config/api_endpoints.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/models/referral/referral_model.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/networking/common_body.dart';
import 'package:atm/utils/networking/http_handler.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ReferralRepository {
  static Future getReferralCode({required BuildContext context}) async {
    showLoadingDialog(context: context);
    APIResponse response =
        await HttpHandler.postMethod(context: context,url: APIEndpoints.referralCode, data: await CommonBody.authBody());
    if (response.isSuccess) {
      ReferralModel referralModel = referralModelFromJson(response.data);
      hideLoadingDialog(context: context);
      Share.share(
          "You will get ${referralModel.referralTitle} with this referral code ${referralModel.referralCode} and ${referralModel.referralMsg}");
    } else {
      hideLoadingDialog(context: context);
    }
  }
}
