import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_images.dart';
import 'package:atm/models/app_update/razorpay_config_model.dart';
import 'package:atm/models/dashboard/dashboard_model.dart';
import 'package:atm/models/withdrawal/get_withdrawal_list_model.dart';
import 'package:atm/repository/app_update_repository.dart';
import 'package:atm/repository/home_repository.dart';
import 'package:atm/screens/deposit_tab/deposit_screen.dart';
import 'package:atm/screens/plan_detail/plan_detail_screen.dart';
import 'package:atm/utils/common/show_snack_bar.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DashboardModel? _dashboardModel;

  @override
  void initState() {
    // getDashboardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
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
                    color: AppColors.primaryColor.withOpacity(0.2),
                    offset: const Offset(0, 3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              height: 125,
              width: MediaQuery.of(context).size.width - 30,
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const PageScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  ...List.generate(
                    3,
                    (index) => Image.asset(AppImages.depositImage,
                        fit: BoxFit.cover, height: 150, width: MediaQuery.of(context).size.width - 30),
                  )
                ],
              ),
            ),
            const DescriptionTextView(data: "Investment Plans", fontWeight: FontWeight.w600, topPadding: 15),
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
                              PageNavigator.pushPage(context: context, page: const PlanDetailScreen());
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
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> getDashboardData() async {
    _dashboardModel = await HomeRepository.getDashboardData(context: context);
    refreshState();
  }

  void showOptionForDeposit({required WithdrawalDatum withdrawalDatum}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 10,
      builder: (context) {
        return Container(
          decoration:
              const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(20)), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: const Text(
                  "Select option for deposit",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () async {
                  RazorPayConfigModel? razorPayConfigModel =
                      await AppUpdateRepository.checkRazorPayConfiguration(context: context);
                  if (razorPayConfigModel != null) {
                    PageNavigator.pop(context: context);
                    if (razorPayConfigModel.data.razorpayStatus == "enable") {
                      PageNavigator.pushPage(
                        context: context,
                        page: DepositScreen(
                          depositType: DepositType.online_deposit,
                          withdrawalDatum: withdrawalDatum,
                          razorPayConfigModel: razorPayConfigModel,
                        ),
                      ).whenComplete(() {
                        getDashboardData();
                      });
                    } else {
                      showToast(context: context, msg: "Online deposit will be available soon!", isError: true);
                    }
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: const [Expanded(child: Text("ONLINE DEPOSITE")), Icon(Icons.arrow_forward_ios)],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  RazorPayConfigModel? razorPayConfigModel =
                      await AppUpdateRepository.checkRazorPayConfiguration(context: context);
                  if (razorPayConfigModel != null) {
                    PageNavigator.pop(context: context);
                    PageNavigator.pushPage(
                      context: context,
                      page: DepositScreen(
                        depositType: DepositType.manual_deposit,
                        withdrawalDatum: withdrawalDatum,
                        razorPayConfigModel: razorPayConfigModel,
                      ),
                    ).whenComplete(() {
                      getDashboardData();
                    });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: const [Expanded(child: Text("MANUAL DEPOSIT")), Icon(Icons.arrow_forward_ios)],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void refreshState() {
    if (mounted) {
      setState(() {});
    }
  }
}
