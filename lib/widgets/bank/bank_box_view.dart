import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_images.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class BankBoxView extends StatelessWidget {
  const BankBoxView({Key? key}) : super(key: key);

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
                image: const DecorationImage(image: AssetImage(AppImages.appLogo)),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SimpleTextView(data: "Vikas Patel", fontWeight: FontWeight.w500),
                  SizedBox(height: 10),
                  SimpleTextView(data: "********1234", textColor: AppColors.greyColor),
                  SizedBox(height: 5),
                  SimpleTextView(data: "State Bank Of India", textColor: AppColors.greyColor),
                ],
              ),
            ),
            const Icon(Icons.more_vert, color: AppColors.greyColor),
          ],
        ),
      ),
    );
  }
}
