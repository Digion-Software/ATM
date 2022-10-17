import 'package:atm/config/app_colors.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class SettingBoxView extends StatelessWidget {
  const SettingBoxView(
      {Key? key, required this.icon, required this.title, required this.onTap, this.isKYCPending = false})
      : super(key: key);
  final IconData icon;
  final String title;
  final bool? isKYCPending;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isKYCPending! ? AppColors.redColor : AppColors.transparentColor),
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primaryColor),
              const SizedBox(width: 15),
              SimpleTextView(data: title, fontWeight: FontWeight.w500),
              const Spacer(),
              isKYCPending!
                  ? const SimpleTextView(data: "KYC Pending", fontSize: 10, textColor: AppColors.redColor)
                  : Container(),
              isKYCPending! ? const SizedBox(width: 15) : Container(),
              const Icon(Icons.arrow_forward_ios, color: AppColors.greyColor, size: 22)
            ],
          ),
        ),
      ),
    );
  }
}
