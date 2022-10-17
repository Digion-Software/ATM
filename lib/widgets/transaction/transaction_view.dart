import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_images.dart';
import 'package:atm/models/transaction/transaction_model.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({Key? key,required this.data}) : super(key: key);
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
            const SimpleTextView(data: "S9EFDA3FE95D", textColor: AppColors.greyColor),
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
                    child: Image.asset(AppImages.appLogo),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SimpleTextView(data: "Interested from Aggressive"),
                      SizedBox(height: 5),
                      SimpleTextView(data: "14 Sep 2022", textColor: AppColors.greyColor),
                    ],
                  ),
                ),
                const SimpleTextView(
                  data: "+45.3",
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
