import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_images.dart';
import 'package:atm/models/referral/referral_model.dart';
import 'package:atm/repository/referral_repository.dart';
import 'package:atm/utils/common/loading_view.dart';
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
  ReferralModel? referralModel;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: CommonScaffold(
          title: "Refer & Earn",
          child: referralModel == null
              ? const Center(
                  child: LoadingView(),
                )
              : SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Image.asset(AppImages.referNEarnImage),
                      const SizedBox(height: 60),
                      const SimpleTextView(data: "Refer & Earn", fontSize: 24, fontWeight: FontWeight.w400),
                      const SizedBox(height: 8),
                      DescriptionTextView(
                        data: referralModel!.referralTitle,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.blackColor.withOpacity(0.5),
                      ),
                      const SizedBox(height: 20),
                      DescriptionTextView(
                        data: referralModel!.referralMsg,
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.blackColor.withOpacity(0.5),
                        textAlign: TextAlign.center,
                        fontSize: 16,
                      ),
                      const SizedBox(height: 20),
                      ButtonView(
                        title: "INVITE AND EARN",
                        textColor: AppColors.whiteColor,
                        onTap: () async {
                          await ReferralRepository.getFileAndShare(
                              context: context,
                              imageUrl: referralModel!.image,
                              referralCode: referralModel!.referralCode);
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void getData() async {
    referralModel = await ReferralRepository.getReferralCode(context: context, needShare: false);
    if (mounted) {
      setState(() {});
    }
  }
}
