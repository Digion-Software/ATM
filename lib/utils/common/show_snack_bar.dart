import 'package:atm/config/app_colors.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

void showToast({required BuildContext context, required String msg, bool isError = false}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  SnackBar snackBar = SnackBar(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(10),
      elevation: 10,
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.transparentColor,
      content: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: isError ? AppColors.redColor /*.withOpacity(0.1)*/ : AppColors.greenColor /*.withOpacity(0.1)*/,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: const Icon(Icons.circle_rounded,
                      size: 12, color: AppColors.whiteColor /*isError ? AppColors.redColor : AppColors.greenColor,*/
                      )),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: SimpleTextView(
                  data: msg,
                  textColor: AppColors.whiteColor /*isError ? AppColors.redColor : AppColors.greenColor*/,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
