import 'dart:io';

import 'package:atm/config/api_endpoints.dart';
import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_text_style.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: const BackArrowButtonView(color: AppColors.whiteColor),
        elevation: 0,
        title: Text("About Us",style: AppTextStyle.descriptionTextStyle.copyWith(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w600
        ),),
      ),
      body: const WebView(
        initialUrl: APIEndpoints.aboutUs,
        javascriptMode: JavascriptMode.unrestricted,
        zoomEnabled: false,
      ),
    );
  }
}
