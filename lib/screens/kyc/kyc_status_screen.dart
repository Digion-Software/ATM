import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_images.dart';
import 'package:atm/screens/dashboard/dashboard_screen.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class KYCStatusScreen extends StatefulWidget {
  const KYCStatusScreen({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  State<KYCStatusScreen> createState() => _KYCStatusScreenState();
}

class _KYCStatusScreenState extends State<KYCStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "You're KYC ${widget.type}",
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(AppImages.kycStatusImage),
          ),
          const SizedBox(height: 40),
          SimpleTextView(data: "You're KYC ${widget.type}", fontSize: 28, fontWeight: FontWeight.w500),
          const SizedBox(height: 20),
          SimpleTextView(
              data: widget.type == "Pending"
                  ? "You're KYC is pending, After successfully verify you will can invest ATM."
                  : "You have been successfully verified and you can invest ATM.",
              fontSize: 18,
              textAlign: TextAlign.center),
          SizedBox(height: MediaQuery.of(context).size.width / 2),
          ButtonView(
            title: "CONTINUE",
            textColor: AppColors.whiteColor,
            onTap: () {
              PageNavigator.pop(context: context);
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
