import 'package:atm/config/app_colors.dart';
import 'package:atm/models/kyc/kyc_status_model.dart';
import 'package:atm/models/profile/profile_data_model.dart';
import 'package:atm/repository/auth_repository.dart';
import 'package:atm/repository/kyc_repository.dart';
import 'package:atm/repository/profile_repository.dart';
import 'package:atm/screens/bank/bank_account_screen.dart';
import 'package:atm/screens/help_and_support/help_and_support_screen.dart';
import 'package:atm/screens/kyc/kyc_screen.dart';
import 'package:atm/screens/kyc/kyc_status_screen.dart';
import 'package:atm/screens/profile/edit_profile_screen.dart';
import 'package:atm/screens/refer_n_earn/refer_n_earn_screen.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/common/type_strings.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/divider_view.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:atm/widgets/setting/setting_box_view.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  ProfileDataModel? profileDataModel;
  KycStatusModel? kycStatusModel;

  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Setting",
      child: profileDataModel == null
          ? const Center(child: LoadingView())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          offset: const Offset(0, 3),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration:
                                BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10)),
                            child: const Center(child: Icon(Icons.person, size: 40, color: AppColors.whiteColor)),
                          ),
                          const SizedBox(height: 10),
                          SimpleTextView(
                              data: "${profileDataModel!.data!.userName}", fontSize: 22, fontWeight: FontWeight.w500),
                          const SizedBox(height: 10),
                          SimpleTextView(
                              data: profileDataModel!.data!.userPhone ?? "",
                              fontSize: 15,
                              textColor: AppColors.greyColor),
                          const DividerView(topMargin: 20, bottomMargin: 20),
                          SimpleTextView(
                              data:
                                  "Invested Balance: ${getINRTypeValue(rupees: double.parse((profileDataModel!.totalCapital ?? 0).toString()))}",
                              textColor: AppColors.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SettingBoxView(
                    title: "Edit Profile",
                    icon: Icons.person,
                    onTap: () {
                      PageNavigator.pushPage(
                          context: context,
                          page: EditProfile(
                            profileDataModel: profileDataModel!,
                            isUpdated: (v) async {
                              if (v) {
                                PageNavigator.pop(context: context);
                                await getProfileData();
                              }
                            },
                          )).whenComplete(() async {
                        await getProfileData();
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  SettingBoxView(
                    title: "Bank Account",
                    icon: Icons.account_balance,
                    onTap: () {
                      PageNavigator.pushPage(context: context, page: const BankAccountScreen());
                    },
                  ),
                  const SizedBox(height: 15),
                  SettingBoxView(
                    title: "Refer a Friend",
                    icon: Icons.card_giftcard,
                    onTap: () {
                      PageNavigator.pushPage(context: context, page: const ReferNEarnScreen());
                    },
                  ),
                  const SizedBox(height: 15),
                  SettingBoxView(
                    title: "KYC Document",
                    icon: Icons.article,
                    kycStatus: kycStatusModel!.kycStatus,
                    isKYC: true,
                    onTap: () async {
                      if (kycStatusModel!.kycStatus == "Rejected" || kycStatusModel!.kycStatus == "") {
                        PageNavigator.pushPage(context: context, page: const KYCScreen(isEditable: true));
                      } else {
                        PageNavigator.pushPage(
                          context: context,
                          page: KYCStatusScreen(type: kycStatusModel!.kycStatus!),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  SettingBoxView(
                    title: "Help & Support",
                    icon: Icons.help,
                    onTap: () {
                      PageNavigator.pushPage(context: context, page: const HelpAndSupportScreen());
                    },
                  ),
                  const SizedBox(height: 15),
                  SettingBoxView(
                    title: "Terms and Conditions",
                    icon: Icons.contact_page_sharp,
                    onTap: () {},
                  ),
                  const SizedBox(height: 15),
                  SettingBoxView(
                    title: "About",
                    icon: Icons.info,
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  ButtonView(
                    title: "SIGN OUT",
                    textColor: AppColors.whiteColor,
                    onTap: () {
                      AuthRepository.logout(context);
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  getProfileData() async {
    kycStatusModel = await KYCRepository.getKycStatus(context: context);
    profileDataModel = await ProfileRepository.getProfileData(context: context);
    changeState();
  }

  void changeState() {
    if (mounted) {
      setState(() {});
    }
  }
}
