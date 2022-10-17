import 'package:atm/config/app_colors.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class WithdrawalBoxView extends StatelessWidget {
  const WithdrawalBoxView({Key? key}) : super(key: key);

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
            const SimpleTextView(data: "Moderate", fontSize: 22, fontWeight: FontWeight.w400),
            const SizedBox(height: 10),
            Row(
              children: const [
                SimpleTextView(data: "\$500.00", fontSize: 18),
                SizedBox(width: 20),
                SimpleTextView(data: "Invested"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.lock, size: 20),
                SizedBox(width: 5),
                SimpleTextView(data: "Profit Amount: 56.00"),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                      child: SimpleTextView(
                        data: "Deposit",
                        textColor: AppColors.whiteColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
