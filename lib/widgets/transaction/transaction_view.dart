import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_images.dart';
import 'package:atm/models/transaction/transaction_model.dart';
import 'package:atm/utils/common/type_strings.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({Key? key, required this.data}) : super(key: key);
  final TransactionDatum? data;

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
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleTextView(data: data!.transactionId ?? "--", textColor: AppColors.greyColor),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Image.asset(
                      AppImages.appLogo,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleTextView(data: data!.remarks ?? "--", fontWeight: FontWeight.w600),
                      const SizedBox(height: 5),
                      SimpleTextView(data: data!.addedDatetime ?? "--", textColor: AppColors.greyColor),
                    ],
                  ),
                ),
                SimpleTextView(
                  data:
                      "${data!.amount!.startsWith("-") ? "" : "+"}${getINRTypeValue(rupees: double.parse(data!.amount ?? "0"), decimalDigits: 2)}",
                  fontWeight: FontWeight.w600,
                  textColor: data!.amount!.startsWith("-") ? AppColors.redColor : AppColors.greenColor,
                  fontSize: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
