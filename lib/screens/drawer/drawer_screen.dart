import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_constant.dart';
import 'package:atm/models/authentication/login_model.dart';
import 'package:atm/repository/auth_repository.dart';
import 'package:atm/screens/help_and_support/customer_support_screen.dart';
import 'package:atm/screens/help_and_support/help_and_support_screen.dart';
import 'package:atm/screens/help_and_support/terms_and_conditions_screen.dart';
import 'package:atm/screens/refer_n_earn/refer_n_earn_screen.dart';
import 'package:atm/screens/setting/setting_screen.dart';
import 'package:atm/screens/transfer_plan/transfer_plan_screen.dart';
import 'package:atm/screens/withdraw/withdraw_screen.dart';
import 'package:atm/utils/local_storage/shared_preferences.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key, required this.onHomePressed, required this.onTransactionPressed}) : super(key: key);

  final Function() onHomePressed;
  final Function() onTransactionPressed;

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String userName = "--";

  @override
  void initState() {
    setUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: MediaQuery.of(context).size.width / 1.3,
      color: AppColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: AppColors.primaryColor.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    height: 75,
                    width: 75,
                    decoration: const BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
                    child: const Center(child: Icon(Icons.person, size: 50, color: AppColors.whiteColor)),
                  ),
                  SimpleTextView(
                      data: userName,
                      textColor: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      topPadding: 15,
                      bottomPadding: 40),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        PageNavigator.pop(context: context);
                        widget.onHomePressed();
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.home,
                        color: AppColors.greyColor,
                      ),
                      title: DescriptionTextView(data: "Home", fontWeight: FontWeight.w500, fontSize: 16,
                      textColor: AppColors.blackColor.withOpacity(0.7)),
                    ),
                    ListTile(
                      onTap: () {
                        PageNavigator.pop(context: context);
                        widget.onTransactionPressed();
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.event_note,
                        color: AppColors.greyColor,
                      ),
                      title: DescriptionTextView(data: "Transactions", fontWeight: FontWeight.w500, fontSize: 16,
                          textColor: AppColors.blackColor.withOpacity(0.7)
                    )),
                    ListTile(
                      onTap: () {
                        PageNavigator.pop(context: context);
                        PageNavigator.pushPage(context: context, page: const ReferNEarnScreen());
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.card_giftcard,
                        color: AppColors.greyColor,
                      ),
                      title: DescriptionTextView(data: "Refer n Earn", fontWeight: FontWeight.w500, fontSize: 16,
                          textColor: AppColors.blackColor.withOpacity(0.7)),
                    ),
                    ListTile(
                      onTap: () {
                        PageNavigator.pop(context: context);
                        PageNavigator.pushPage(context: context, page: const WithdrawScreen());
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.account_balance_wallet,
                        color: AppColors.greyColor,
                      ),
                      title: DescriptionTextView(data: "Withdraw Profit", fontWeight: FontWeight.w500, fontSize: 16,
                          textColor: AppColors.blackColor.withOpacity(0.7)),
                    ),
                    ListTile(
                      onTap: () {
                        PageNavigator.pop(context: context);
                        PageNavigator.pushPage(context: context, page: const TransferPlanScreen());
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.change_circle_outlined,
                        color: AppColors.greyColor,
                      ),
                      title: DescriptionTextView(data: "Transfer Plan",fontWeight: FontWeight.w500, fontSize: 16,
                          textColor: AppColors.blackColor.withOpacity(0.7)),
                    ),
                    ListTile(
                      onTap: () {
                        PageNavigator.pop(context: context);
                        PageNavigator.pushPage(context: context, page: const HelpAndSupportScreen());
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.help,
                        color: AppColors.greyColor,
                      ),
                      title: DescriptionTextView(data: "Help & Support", fontWeight: FontWeight.w500, fontSize: 16,
                          textColor: AppColors.blackColor.withOpacity(0.7)),
                    ),
                    ListTile(
                      onTap: () {
                        PageNavigator.pop(context: context);
                        PageNavigator.pushPage(context: context, page: const SettingScreen());
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.settings,
                        color: AppColors.greyColor,
                      ),
                      title: DescriptionTextView(data: "Settings",fontWeight: FontWeight.w500, fontSize: 16,
                          textColor: AppColors.blackColor.withOpacity(0.7)),
                    ),
                    ListTile(
                      onTap: () {
                        PageNavigator.pop(context: context);
                        PageNavigator.pushPage(context: context, page: const CustomerSupportScreen());
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.support_agent_rounded,
                        color: AppColors.greyColor,
                      ),
                      title: DescriptionTextView(data: "Customer Support",fontWeight: FontWeight.w500, fontSize: 16,
                          textColor: AppColors.blackColor.withOpacity(0.7)),
                    ),
                    ListTile(
                      onTap: () async {
                        AuthRepository.logout(context);
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.power_settings_new,
                        color: AppColors.greyColor,
                      ),
                      title: DescriptionTextView(data: "Logout", fontWeight: FontWeight.w500, fontSize: 16,
                          textColor: AppColors.blackColor.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setUserName() async {
    String? name = await LocalStorage.getString(key: AppConstant.userName);
    if(name != null){
      userName = name;
    }
    else{
      LoginModel loginModel = loginModelFromJson(await LocalStorage.getString(key: AppConstant.userDetails) ?? "");
      if (loginModel.userData != null) {
        userName = loginModel.userData!.name;
      }
    }
    if (mounted) {
      setState(() {});
    }
  }
}
