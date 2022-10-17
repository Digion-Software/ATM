import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_images.dart';
import 'package:atm/screens/authentication/login_screen.dart';
import 'package:atm/screens/refer_n_earn/refer_n_earn_screen.dart';
import 'package:atm/screens/setting/setting_screen.dart';
import 'package:atm/screens/transaction_tab/transaction_screen.dart';
import 'package:atm/screens/withdraw/withdraw_screen.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key,
  required this.onHomePressed,required this.onTransactionPressed}) : super(key: key);

  final Function() onHomePressed;
  final Function() onTransactionPressed;
  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width / 1.3,
          color: AppColors.whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 65),
              Container(
                height: MediaQuery.of(context).size.height / 5,
                width: double.infinity,
                color: AppColors.primaryColor.withOpacity(0.2),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.greyColor,
                          ),
                          image: const DecorationImage(
                            image: AssetImage(
                              AppImages.appLogo,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SimpleTextView(data: "User Name", textColor: AppColors.primaryColor),
                    ],
                  ),
                ),
              ),
              Padding(
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
                      title: const DescriptionTextView(data: "Home", fontWeight: FontWeight.w500, fontSize: 16),
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
                      title: const DescriptionTextView(data: "Transactions", fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    ListTile(
                      onTap: () {
                        PageNavigator.pushPage(context: context, page: const ReferNEarnScreen());
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.card_giftcard,
                        color: AppColors.greyColor,
                      ),
                      title: const DescriptionTextView(data: "Refer n Earn", fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    ListTile(
                      onTap: () {
                        PageNavigator.pushPage(context: context, page: const WithdrawScreen());
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.account_balance_wallet,
                        color: AppColors.greyColor,
                      ),
                      title: const DescriptionTextView(data: "Withdraw Profit", fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    ListTile(
                      onTap: () {},
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.help,
                        color: AppColors.greyColor,
                      ),
                      title: const DescriptionTextView(data: "Help & Support", fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    ListTile(
                      onTap: () {
                        PageNavigator.pushPage(context: context, page: const SettingScreen());
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.settings,
                        color: AppColors.greyColor,
                      ),
                      title: const DescriptionTextView(data: "Settings", fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    ListTile(
                      onTap: () {
                        PageNavigator.pushAndRemoveUntilPage(context: context, page: const LoginScreen());
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.power_settings_new,
                        color: AppColors.greyColor,
                      ),
                      title: const DescriptionTextView(data: "Logout", fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
