import 'package:atm/config/app_colors.dart';
import 'package:atm/models/withdrawal/get_withdrawal_list_model.dart';
import 'package:atm/repository/withdrawal_repository.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
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
                        onTransferPlanPressed: () {},
                        onDepositPressed: () {},
                        onWithdrawalPressed: () {},
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

  void changeState() {
    if (mounted) {
      setState(() {});
    }
  }
}
