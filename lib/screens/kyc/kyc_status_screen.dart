import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_images.dart';
import 'package:atm/screens/dashboard/dashboard_screen.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class KYCStatusScreen extends StatefulWidget {
  const KYCStatusScreen({Key? key}) : super(key: key);

  @override
  State<KYCStatusScreen> createState() => _KYCStatusScreenState();
}

class _KYCStatusScreenState extends State<KYCStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "You're Verified",
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(AppImages.kycStatusImage),
          ),
          const SizedBox(height: 40),
          const SimpleTextView(data: "You're Verified", fontSize: 28, fontWeight: FontWeight.w500),
          const SizedBox(height: 20),
          const SimpleTextView(
              data: "You have been successfully verified and you can invest ATM",
              fontSize: 18,
              textAlign: TextAlign.center),
          SizedBox(height: MediaQuery.of(context).size.width/2),
          ButtonView(
            title: "CONTINUE",
            textColor: AppColors.whiteColor,
            onTap: () {
              PageNavigator.pushAndRemoveUntilPage(context: context, page: const DashboardScreen());
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
