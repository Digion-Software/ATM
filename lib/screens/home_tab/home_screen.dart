import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_constant.dart';
import 'package:atm/config/app_text_style.dart';
import 'package:atm/models/app_update/razorpay_config_model.dart';
import 'package:atm/models/dashboard/dashboard_model.dart';
import 'package:atm/models/kyc/kyc_status_model.dart';
import 'package:atm/models/withdrawal/get_withdrawal_list_model.dart';
import 'package:atm/repository/app_update_repository.dart';
import 'package:atm/repository/home_repository.dart';
import 'package:atm/repository/kyc_repository.dart';
import 'package:atm/screens/deposit_tab/deposit_screen.dart';
import 'package:atm/screens/plan_detail/plan_detail_screen.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/common/show_snack_bar.dart';
import 'package:atm/utils/common/type_strings.dart';
import 'package:atm/utils/local_storage/shared_preferences.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/common/network_image_view.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.isNeedKYC}) : super(key: key);

  final Function(String) isNeedKYC;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DashboardModel? _dashboardModel;
  KycStatusModel? _kycStatusModel;

  @override
  void initState() {
    getDashboardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _dashboardModel == null
        ? const Center(
            child: LoadingView(),
          )
        : SingleChildScrollView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
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
                            _dashboardModel!.sliderData!.length,
                            (index) => Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width - 30,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(_dashboardModel!.sliderData![index].bannerImage!),fit: BoxFit.fill)),
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              /*child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SimpleTextView(
                                      data: _dashboardModel!.sliderData![index].bannerName ?? "--",
                                      fontSize: 14,
                                      topPadding: 5,
                                      bottomPadding: 5),
                                  DescriptionTextView(
                                      data: _dashboardModel!.sliderData![index].bannerDescription ?? "--",
                                      fontSize: 18,
                                      textColor: AppColors.primaryColor),
                                ],
                              ),*/
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const DescriptionTextView(data: "Investment Plans", fontWeight: FontWeight.w600, topPadding: 15,textColor: AppColors.textBluGreyColor),
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
                                    const Icon(
                                      Icons.access_time,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SimpleTextView(
                                              data:
                                                  "${planData.planMonthlyMinReturn}-${planData.planMonthlyMaxReturn}% Monthly",
                                              bottomPadding: 3),
                                          SimpleTextView(
                                            data:
                                                "Min Deposit: ${getINRTypeValue(rupees: double.parse(planData.planMinimumAmount ?? "0"), decimalDigits: 0)}",
                                            textColor: AppColors.greyColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    investButton(
                                        context: context,
                                        withdrawalDatum: WithdrawalDatum(
                                          planId: _dashboardModel!.planData![index].planId,
                                          planName: _dashboardModel!.planData![index].planName,
                                          planDescription: _dashboardModel!.planData![index].planDescription,
                                          planMinimumAmount: _dashboardModel!.planData![index].planMinimumAmount,
                                          planMonthlyMinReturn: _dashboardModel!.planData![index].planMonthlyMinReturn,
                                          planMonthlyMaxReturn: _dashboardModel!.planData![index].planMonthlyMaxReturn,
                                          planBanner: _dashboardModel!.planData![index].planBanner,
                                          invested: _dashboardModel!.planData![index].invested,
                                          profit: _dashboardModel!.planData![index].profit,
                                        ),
                                        onComplete: () {
                                          getDashboardData();
                                        }),
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

InkWell investButton(
    {required BuildContext context, required WithdrawalDatum withdrawalDatum, required Function() onComplete}) {
  return InkWell(
    onTap: (){
      showOptionForDeposit(context: context, withdrawalDatum: withdrawalDatum, onComplete: onComplete);
      // PageNavigator.pushPage(context: context, page: const PlanDetailScreen());
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.orangeColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(
        "Invest",
        style: AppTextStyle.buttonTextStyle
            .copyWith(color: AppColors.whiteColor, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

void showOptionForDeposit(
    {required BuildContext context, required WithdrawalDatum withdrawalDatum, required Function() onComplete}) async{

  String paymentMethodForDeposit = await LocalStorage.getString(key: AppConstant.paymentMethodForDeposit) ?? "";
  if(paymentMethodForDeposit.toLowerCase() == "both"){
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
                child: const SimpleTextView(
                  data: "Select option for deposit",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        RazorPayConfigModel? razorPayConfigModel =
                        await AppUpdateRepository.checkRazorPayConfiguration(context: context);
                        if (razorPayConfigModel != null) {
                          PageNavigator.pop(context: context);
                          if (razorPayConfigModel.data.razorpayStatus == "enable") {
                            PageNavigator.pushPage(
                              context: context,
                              page: PlanDetailScreen(
                                depositType: DepositType.online_deposit,
                                withdrawalDatum: withdrawalDatum,
                                razorPayConfigModel: razorPayConfigModel,
                              ),
                            ).whenComplete(() {
                              onComplete();
                            });
                          } else {
                            showToast(context: context, msg: "Online deposit will be available soon!", isError: true);
                          }
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Row(
                          children: const [Expanded(child: Text("ONLINE DEPOSITE")), Icon(Icons.arrow_forward_ios)],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        RazorPayConfigModel? razorPayConfigModel =
                        await AppUpdateRepository.checkRazorPayConfiguration(context: context);
                        if (razorPayConfigModel != null) {
                          PageNavigator.pop(context: context);
                          PageNavigator.pushPage(
                            context: context,
                            page: PlanDetailScreen(
                              depositType: DepositType.manual_deposit,
                              withdrawalDatum: withdrawalDatum,
                              razorPayConfigModel: razorPayConfigModel,
                            ),
                          ).whenComplete(() {
                            onComplete();
                          });
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Row(
                          children: const [Expanded(child: Text("MANUAL DEPOSIT")), Icon(Icons.arrow_forward_ios)],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  else{
    RazorPayConfigModel? razorPayConfigModel =
    await AppUpdateRepository.checkRazorPayConfiguration(context: context);
    if (razorPayConfigModel != null) {
      if (razorPayConfigModel.data.razorpayStatus == "enable") {
        PageNavigator.pushPage(
          context: context,
          page: PlanDetailScreen(
            depositType: DepositType.online_deposit,
            withdrawalDatum: withdrawalDatum,
            razorPayConfigModel: razorPayConfigModel,
          ),
        ).whenComplete(() {
          onComplete();
        });
      } else {
        showToast(context: context, msg: "Online deposit will be available soon!", isError: true);
      }
    }
  }
}
