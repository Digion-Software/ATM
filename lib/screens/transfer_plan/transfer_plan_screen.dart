import 'package:atm/config/app_colors.dart';
import 'package:atm/models/transfer_plan/internal_transfer_model.dart';
import 'package:atm/models/withdrawal/get_withdrawal_list_model.dart';
import 'package:atm/repository/transfer_plan_repository.dart';
import 'package:atm/repository/withdrawal_repository.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/common/type_strings.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_field_view.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:atm/widgets/withdrawal/withdrawal_box_view.dart';
import 'package:flutter/material.dart';

class TransferPlanScreen extends StatefulWidget {
  const TransferPlanScreen({Key? key}) : super(key: key);

  @override
  State<TransferPlanScreen> createState() => _TransferPlanScreenState();
}

class _TransferPlanScreenState extends State<TransferPlanScreen> {
  GetWithdrawalListModel? withdrawalListModel;
  InternalTransferModel? internalTransferModel;
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    getWithdrawalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Transfer Plan",
      child: withdrawalListModel == null
          ? const Center(child: LoadingView())
          : withdrawalListModel!.withdrawalData!.isEmpty
              ? const Center(
                  child: TitleTextView(
                    data: "No plans found!",
                    fontSize: 18,
                    textColor: AppColors.redColor,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: withdrawalListModel!.withdrawalData!.length,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: WithdrawalBoxView(
                        isForTransfer: true,
                        data: withdrawalListModel!.withdrawalData![index],
                        onTransferPlanPressed: () {
                          internalTransferData(
                            planId: withdrawalListModel!.withdrawalData![index].planId ?? "",
                            maxPlanAmount: ((withdrawalListModel!.withdrawalData![index].invested ?? 0) +
                                    (withdrawalListModel!.withdrawalData![index].profit ?? 0))
                                .toString(),
                            mainPlanName: withdrawalListModel!.withdrawalData![index].planName ?? "",
                          );
                        },
                        onCapitalWithdrawalPressed: () {},
                        onProfitWithdrawalPressed: () {},
                      ),
                    );
                  },
                ),
    );
  }

  Future<void> getWithdrawalData() async {
    withdrawalListModel = await WithdrawalRepository.getWithdrawalListData(context: context);
    changeState();
  }

  Future<void> internalTransferData({
    required String planId,
    required String mainPlanName,
    required String maxPlanAmount,
  }) async {
    internalTransferModel = await TransferPlanRepository.internalTransferPlanList(context: context, planId: planId);
    showOptionForTransferPlan(
      context: context,
      planId: planId,
      mainPlanName: mainPlanName,
      maxPlanAmount: maxPlanAmount,
    );
  }

  void showOptionForTransferPlan({
    required BuildContext context,
    required String planId,
    required String mainPlanName,
    required String maxPlanAmount,
  }) {
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
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: const Text(
                  "Select option for transfer plan",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              ...List.generate(
                internalTransferModel!.data!.length,
                (index) => InkWell(
                  onTap: () {
                    PageNavigator.pop(context: context);
                    showOptionEnterPayment(
                        context: context,
                        planId: planId,
                        toPlanId: internalTransferModel!.data![index].planId ?? "",
                        mainPlanName: mainPlanName,
                        maxPlanAmount: maxPlanAmount,
                        transferPlanName: internalTransferModel!.data![index].planName ?? "");
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(internalTransferModel!.data![index].planName ?? ""),
                        ),
                        const Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showOptionEnterPayment({
    required BuildContext context,
    required String planId,
    required String toPlanId,
    required String mainPlanName,
    required String transferPlanName,
    required String maxPlanAmount,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Material(
          color: AppColors.transparentColor,
          child: Container(
            decoration:
                const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(20)), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.only(top: 20,bottom: 5),
                  child: Row(
                    children: [
                      const Text(
                        "Transfer amount: ",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        mainPlanName,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor),
                      ),
                      const Text(
                        " To ",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        transferPlanName,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor),
                      ),
                    ],
                  )
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    "$mainPlanName Amount : ${getINRTypeValue(rupees: double.parse(maxPlanAmount))}",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: AppColors.redColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CommonTextField(
                    controller: amountController,
                    hintText: "Enter transfer amount",
                    iconChild: const SizedBox(),
                    title: "Enter transfer amount",
                    isObscure: false,
                    keyBoardType: TextInputType.number,
                  ),
                ),
                ButtonView(
                    title: "Transfer plan",
                    textColor: AppColors.whiteColor,
                    onTap: () {
                      PageNavigator.pop(context: context);
                      TransferPlanRepository.internalTransferPlanOTP(
                          context: context, planId: planId, toPlanId: toPlanId, amount: amountController.text);
                    },
                    topMargin: 10,
                    leftMargin: 10,
                    rightMargin: 10,
                    bottomMargin: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  void changeState() {
    if (mounted) {
      setState(() {});
    }
  }
}
