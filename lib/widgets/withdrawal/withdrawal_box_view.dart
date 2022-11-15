import 'package:atm/config/app_colors.dart';
import 'package:atm/models/withdrawal/get_withdrawal_list_model.dart';
import 'package:atm/screens/plan_detail/plan_detail_screen.dart';
import 'package:atm/screens/withdraw/withdrawal_screen.dart';
import 'package:atm/utils/common/type_strings.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class WithdrawalBoxView extends StatelessWidget {
  const WithdrawalBoxView(
      {Key? key,
      required this.data,
      this.isForTransfer = false,
      required this.onDepositPressed,
      required this.onWithdrawalPressed,
      required this.onTransferPlanPressed})
      : super(key: key);

  final WithdrawalDatum data;
  final bool isForTransfer;
  final Function() onTransferPlanPressed;
  final Function() onDepositPressed;
  final Function() onWithdrawalPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleTextView(data: data.planName ?? "--", fontSize: 22, fontWeight: FontWeight.w400),
            const SizedBox(height: 10),
            Row(
              children: [
                SimpleTextView(
                    data: getINRTypeValue(rupees: double.parse((data.invested ?? 0).toString())), fontSize: 18),
                const SizedBox(width: 10),
                const SimpleTextView(data: "Invested"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.lock, size: 20),
                const SizedBox(width: 5),
                SimpleTextView(
                    data: "Profit Amount: ${getINRTypeValue(rupees: double.parse((data.profit ?? 0).toString()))}"),
              ],
            ),
            const SizedBox(height: 30),
            isForTransfer
                ? InkWell(
                    onTap: onTransferPlanPressed,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                        child: SimpleTextView(
                          data: "Transfer Plan",
                          textColor: AppColors.whiteColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: onDepositPressed,
                          child: Container(
                            height: 40,
                            decoration:
                                BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(5)),
                            child: const Center(
                              child: SimpleTextView(
                                data: "Deposit",
                                textColor: AppColors.whiteColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                          onTap: onWithdrawalPressed,
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColors.primaryColor, width: 0.5),
                            ),
                            child: const Center(
                              child: SimpleTextView(
                                data: "Withdrawal",
                                textColor: AppColors.primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
