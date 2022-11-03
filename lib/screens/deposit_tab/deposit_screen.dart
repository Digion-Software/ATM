import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_text_style.dart';
import 'package:atm/models/dashboard/dashboard_model.dart';
import 'package:atm/models/kyc/kyc_status_model.dart';
import 'package:atm/models/withdrawal/get_withdrawal_list_model.dart';
import 'package:atm/repository/home_repository.dart';
import 'package:atm/repository/kyc_repository.dart';
import 'package:atm/screens/bank/bank_account_screen.dart';
import 'package:atm/screens/withdraw/withdraw_screen.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/common/type_strings.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/common/divider_view.dart';
import 'package:atm/widgets/common/network_image_view.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:atm/widgets/dashboard/dashboard_data_view.dart';
import 'package:flutter/material.dart';

enum DepositType { online_deposit, manual_deposit }

class DepositScreen extends StatefulWidget {
  const DepositScreen({Key? key, required this.isNeedKYC}) : super(key: key);

  final Function(String) isNeedKYC;

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  DashboardModel? _dashboardModel;
  KycStatusModel? _kycStatusModel;

  @override
  void initState() {
    getDashboardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _dashboardModel == null || _kycStatusModel == null
        ? const Center(
            child: LoadingView(),
          )
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColors.primaryColor.withOpacity(0.1),),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DashboardDataView(
                                title: "Active Plans",
                                data: _dashboardModel!.activePlans == null
                                    ? "0"
                                    : _dashboardModel!.activePlans!.toString(),
                              ),
                            ),
                            Expanded(
                              child: DashboardDataView(
                                title: "Wallet Balance",
                                data: getINRTypeValue(
                                    rupees: double.parse((_dashboardModel!.walletBalance ?? 0).toString()),
                                    decimalDigits: 0),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: DashboardDataView(
                                title: "Your Deposits",
                                data: getINRTypeValue(
                                    rupees: double.parse((_dashboardModel!.totalCapital ?? 0).toString()),
                                    decimalDigits: 0),
                              ),
                            ),
                            Expanded(
                              child: DashboardDataView(
                                title: "Total Earnings",
                                data: getINRTypeValue(
                                    rupees: double.parse((_dashboardModel!.totalEarning ?? 0).toString()),
                                    decimalDigits: 0),
                                 valueColor: AppColors.greenColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColors.primaryColor.withOpacity(0.1),),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SimpleTextView(
                          data: "Withdraw Profit Amount",
                          fontSize: 14,
                          textColor: AppColors.greyColor,
                        ),
                        InkWell(
                          onTap: () {
                            PageNavigator.pushPage(context: context, page: const WithdrawScreen());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.greyColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                            child: Row(
                              children: const [
                                SimpleTextView(
                                  data: "Withdraw Now",
                                    textColor: AppColors.textColor
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.info_outline,
                                  size: 22,
                                  color: AppColors.textColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const DescriptionTextView(
                        data: "Your Investments",
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.textBluGreyColor,
                      ),
                      InkWell(
                        onTap: () {
                          PageNavigator.pushPage(context: context, page: const BankAccountScreen());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.greyColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                          child: Row(
                            children: const [
                              SimpleTextView(
                                  data: "Edit Bank",
                                  textColor: AppColors.textColor
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.money,
                                size: 22,
                                color: AppColors.textColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...List.generate(
                    _dashboardModel!.planData!.length,
                    (index) {
                      PlanDatum planData = _dashboardModel!.planData![index];
                      return Container(
                        margin: const EdgeInsets.only(top: 15),
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              networkImageView(
                                planData.planBanner ?? "",
                                height: MediaQuery.of(context).size.height / 5,
                                width: double.infinity,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SimpleTextView(
                                              data:
                                                  "Deposit Amount" /*"${planData.planMonthlyMinReturn}-${planData.planMonthlyMaxReturn}% Monthly"*/,
                                              bottomPadding: 3,
                                              textColor: AppColors.greyColor.withOpacity(0.8)),
                                          SimpleTextView(
                                            data: getINRTypeValue(
                                                rupees: double.parse((planData.invested ?? 0).toString()),
                                                decimalDigits:
                                                    0) /*"Min Deposit: ${getINRTypeValue(rupees: double.parse(planData.planMinimumAmount ?? "0"), decimalDigits: 0)}"*/,
                                            textColor: AppColors.textBluGreyColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showOptionForWithdraw(
                                          context: context,
                                          index: index,
                                          withdrawalDatum: WithdrawalDatum(
                                              planId: planData.planId,
                                              planName: planData.planName,
                                              planDescription: planData.planDescription,
                                              planMinimumAmount: planData.planMinimumAmount,
                                              planMonthlyMinReturn: planData.planMonthlyMinReturn,
                                              planMonthlyMaxReturn: planData.planMonthlyMaxReturn,
                                              planBanner: planData.planBanner,
                                              invested: planData.invested,
                                              profit: planData.profit),
                                          capitalAmount: double.parse((planData.invested ?? 0).toString()),
                                          profitAmount: double.parse((planData.profit ?? 0).toString()),
                                        );
                                        // showOptionForDeposit(context: context, withdrawalDatum: withdrawalDatum, onComplete: onComplete);
                                        // PageNavigator.pushPage(context: context, page: const PlanDetailScreen());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: AppColors.orangeColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.blackColor.withOpacity(0.0),
                                              offset: const Offset(0, 3),
                                              blurRadius: 10,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                        child: Text(
                                          "Withdrawal Deposit",
                                          style: AppTextStyle.buttonTextStyle.copyWith(
                                              color: AppColors.whiteColor, fontSize: 12, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    // investButton(
                                    //     context: context,
                                    //     withdrawalDatum: WithdrawalDatum(
                                    //       planId: _dashboardModel!.planData![index].planId,
                                    //       planName: _dashboardModel!.planData![index].planName,
                                    //       planDescription: _dashboardModel!.planData![index].planDescription,
                                    //       planMinimumAmount: _dashboardModel!.planData![index].planMinimumAmount,
                                    //       planMonthlyMinReturn: _dashboardModel!.planData![index].planMonthlyMinReturn,
                                    //       planMonthlyMaxReturn: _dashboardModel!.planData![index].planMonthlyMaxReturn,
                                    //       planBanner: _dashboardModel!.planData![index].planBanner,
                                    //       invested: _dashboardModel!.planData![index].invested,
                                    //       profit: _dashboardModel!.planData![index].profit,
                                    //     ),
                                    //     onComplete: () {
                                    //       getDashboardData();
                                    //     }),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
  }

  Future<void> getDashboardData() async {
    _dashboardModel = await HomeRepository.getDashboardData(context: context);
    _kycStatusModel = await KYCRepository.getKycStatus(context: context);
    if (_kycStatusModel != null) {
      widget.isNeedKYC(_kycStatusModel!.kycStatus!);
    }
    refreshState();
  }

  void refreshState() {
    if (mounted) {
      setState(() {});
    }
  }
}
