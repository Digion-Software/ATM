import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_images.dart';
import 'package:atm/repository/referral_repository.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class ReferNEarnScreen extends StatefulWidget {
  const ReferNEarnScreen({Key? key}) : super(key: key);

  @override
  State<ReferNEarnScreen> createState() => _ReferNEarnScreenState();
}

class _ReferNEarnScreenState extends State<ReferNEarnScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Refer & Earn",
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Image.asset(AppImages.referNEarnImage),
            const SizedBox(height: 60),
            const SimpleTextView(data: "Refer & Earn", fontSize: 24, fontWeight: FontWeight.w400),
            const SizedBox(height: 8),
            DescriptionTextView(
                data: "*upto \$1000 every month",
              fontSize: 16,
              fontWeight: FontWeight.w400, textColor: AppColors.blackColor.withOpacity(0.5),),
            const SizedBox(height: 20),
             DescriptionTextView(
              data:
                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
              fontWeight: FontWeight.w400,
              textColor: AppColors.blackColor.withOpacity(0.5),
              textAlign: TextAlign.center,fontSize: 16,

            ),
            const SizedBox(height: 20),
            ButtonView(
              title: "INVITE AND EARN",
              textColor: AppColors.whiteColor,
              onTap: () async {
                await ReferralRepository.getReferralCode(
                    context: context);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
