import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_images.dart';
import 'package:atm/models/app_update/razorpay_config_model.dart';
import 'package:atm/models/withdrawal/get_withdrawal_list_model.dart';
import 'package:atm/widgets/common/divider_view.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:atm/widgets/dashboard/dashboard_data_view.dart';
import 'package:flutter/material.dart';

enum DepositType { online_deposit, manual_deposit }

class DepositScreen extends StatefulWidget {
  const DepositScreen(
      {Key? key, required this.depositType, required this.razorPayConfigModel, required this.withdrawalDatum})
      : super(key: key);

  final WithdrawalDatum? withdrawalDatum;
  final DepositType? depositType;
  final RazorPayConfigModel? razorPayConfigModel;

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Expanded(
                        child: DashboardDataView(
                          title: "Active Plan",
                          data: "1",
                          statusColor: AppColors.greenColor,
                        ),
                      ),
                      Expanded(
                        child: DashboardDataView(
                          title: "Wallet Balance",
                          data: "\$30",
                          statusColor: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const DividerView(
                    topMargin: 15,
                    bottomMargin: 15,
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: DashboardDataView(
                          title: "Your Deposit",
                          data: "\$500",
                          statusColor: AppColors.primaryColor,
                        ),
                      ),
                      Expanded(
                        child: DashboardDataView(
                          title: "Total Earned",
                          data: "\$3,500",
                          statusColor: AppColors.greenColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const DescriptionTextView(data: "Investment Plans",fontWeight: FontWeight.w600,topPadding: 15,),
            ...List.generate(
              4 /*_dashboardModel!.planData!.length*/,
                  (index) => Container(
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.transparentColor,
                        image: DecorationImage(
                          image: AssetImage(index % 3 == 0 ? AppImages.moderateImage : AppImages.agressiveImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                SimpleTextView(data: "15-20% Monthly", bottomPadding: 3),
                                SimpleTextView(
                                  data: "Min Deposit: ₹500",
                                  textColor: AppColors.greyColor,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              /*showOptionForDeposit(
                                    withdrawalDatum: WithdrawalDatum(
                                      planId: _dashboardModel!.planData![index].planId,
                                      planName: _dashboardModel!.planData![index].planName,
                                      planDescription: _dashboardModel!.planData![index].planDescription,
                                      planMinimumAmount:
                                      _dashboardModel!.planData![index].planMinimumAmount,
                                      planMonthlyMinReturn:
                                      _dashboardModel!.planData![index].planMonthlyMinReturn,
                                      planMonthlyMaxReturn:
                                      _dashboardModel!.planData![index].planMonthlyMaxReturn,
                                      planBanner: _dashboardModel!.planData![index].planBanner,
                                      invested: _dashboardModel!.planData![index].invested,
                                      profit: _dashboardModel!.planData![index].profit,
                                    ),
                                  );*/
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.primaryColor),
                                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                                child: const SimpleTextView(
                                  data: "Invest",
                                  fontSize: 16,
                                  textColor: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
