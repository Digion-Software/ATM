import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_images.dart';
import 'package:atm/models/bank/bank_model.dart';
import 'package:atm/repository/bank_repository.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class BankBoxView extends StatelessWidget {
  const BankBoxView({Key? key,
  required this.data,
  required this.onEditPressed,
    required this.onDeletePressed,
  }) : super(key: key);

  final BankDatum data;
  final Function onEditPressed;
  final Function onDeletePressed;
  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  width: 2,
                ),
                image: DecorationImage(image: NetworkImage(data.bankLogo??"--"),fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SimpleTextView(data: data.bankAccountHolderName ?? "--", fontWeight: FontWeight.w500),
                  const SizedBox(height: 10),
                  SimpleTextView(data: "**********${data.bankAccountNumber!.replaceRange(0, 8, "")}", textColor: AppColors.greyColor),
                  const SizedBox(height: 5),
                  SimpleTextView(data: data.bankName ?? "--", textColor: AppColors.greyColor),
                ],
              ),
            ),
            PopupMenuButton<int>(
              color: Colors.white,
              onSelected: (item) async {
                if (item == 0) {
                  onEditPressed();
                }
                else if (item == 1) {
                  onEditPressed();
                }
              },
              child: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text('Edit'),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
