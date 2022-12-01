import 'package:atm/config/app_colors.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class SettingBoxView extends StatelessWidget {
  const SettingBoxView(
      {Key? key, required this.icon, required this.title, required this.onTap, this.kycStatus, this.isKYC = false})
      : super(key: key);
  final IconData icon;
  final String title;
  final String? kycStatus;
  final bool isKYC;
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
          border: Border.all(
              color: isKYC
                  ? kycStatus == "Approved"
                      ? AppColors.greenColor
                      : AppColors.redColor
                  : AppColors.transparentColor),
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
              isKYC
                  ? SimpleTextView(
                      data: kycStatus == "" ? "Upload KYC" : "KYC $kycStatus",
                      fontSize: 10,
                      textColor: AppColors.redColor)
                  : Container(),
              SizedBox(width: isKYC ? 15 : 0),
              const Icon(Icons.arrow_forward_ios, color: AppColors.greyColor, size: 22)
            ],
          ),
        ),
      ),
    );
  }
}
