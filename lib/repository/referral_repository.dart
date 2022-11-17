import 'dart:io';
import 'dart:typed_data';

import 'package:atm/config/api_endpoints.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/models/referral/referral_model.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/common/show_logs.dart';
import 'package:atm/utils/networking/common_body.dart';
import 'package:atm/utils/networking/http_handler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ReferralRepository {
  static Future<ReferralModel?> getReferralCode({required BuildContext context, required bool needShare}) async {
    APIResponse response = await HttpHandler.postMethod(
        context: context, url: APIEndpoints.referralCode, data: await CommonBody.authBody());
    if (response.isSuccess) {
      return referralModelFromJson(response.data);
    } else {
      return null;
    }
  }

  static Future getFileAndShare(
      {required BuildContext context, required String imageUrl, required String referralCode}) async {
    showLoadingDialog(context: context);
    showLogs(message: "IMAGE URL -- $imageUrl");
    http.Response response = await http.get(
      Uri.parse(imageUrl),
    );
    showLogs(message: "GET RESPONSE CODE -- '${response.statusCode}'");
    showLogs(message: "GET RESPONSE -- '${response.body}'");
    Uint8List uint8list = response.bodyBytes;
    final Directory directory = await getTemporaryDirectory();
    final String filePath = "${directory.path}/image.jpg";
    File(filePath).writeAsBytesSync(uint8list);
    hideLoadingDialog(context: context);
    Share.shareXFiles(
      [XFile(filePath)],
      text: """Hi, I just invited you to use the "ATM" AnyTimeMoney Investment app Use Referral code $referralCode!.

Step1: Use referral code to SignUp into the app.

Step2: Register using your mobile number and link your bank account.

Step3: Start making money 24x7, with instant UPI payments for your investments.

It's 100% safe & secure.

Download the app now.
https://play.google.com/store/apps/details?id=com.any.time.money""" /*"You will get ${referralModel.referralTitle} with this referral code ${referralModel.referralCode} and ${referralModel.referralMsg}"*/,
    );
  }
}
